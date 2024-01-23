import type { Request, Response, NextFunction } from "express";
import { validateAuthorizationHeader } from "../utils/request.utils";
import { CryptoUtils } from "../utils/crypto.utils";
import { ACCESS_TOKEN_PRIVATE_KEY } from "../global";
import { AccessTokenData } from "../services/auth/auth.types";
import { Response as AppResponse } from "../utils/response.utils";

const accessTokenCryptoUtil = new CryptoUtils(ACCESS_TOKEN_PRIVATE_KEY);

export function authNZ(expectedRoles: string[], shouldAllRolesRequired: boolean = true) {
  return (req: Request, res: Response, next: NextFunction) => {
    const authorization = req.headers['authorization'] || '';

    if(!validateAuthorizationHeader(authorization)) return sendUnauthorizedResponse(res);

    const token = authorization.split(' ')[1];
    
    const payload = accessTokenCryptoUtil.verifyJWT(token);

    if(!payload || typeof payload === 'string') return sendUnauthorizedResponse(res);

    // By now, the access token is valid and not expired. So the authentication is completed.
    const accessToken = payload as AccessTokenData;

    // Authorization
    const roles = accessToken.roles;

    let areRolesSatisfied: boolean;

    if(shouldAllRolesRequired) {
      areRolesSatisfied = expectedRoles.every(expectedRole => roles.includes(expectedRole));
    } else {
      areRolesSatisfied = expectedRoles.some(expectedRole => roles.includes(expectedRole));
    }

    if(areRolesSatisfied) {
      return next();
    } else {
      return sendUnauthorizedResponse(res);
    }
  }
}

export function sendUnauthorizedResponse(res: Response) {
  const response = AppResponse.withoutData().toUnauthorizedResponse();
  res.status(response.status).json(response);
}