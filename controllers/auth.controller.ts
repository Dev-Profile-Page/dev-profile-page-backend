import type { Request, Response } from 'express';

import { prisma } from '../db/prisma_client';

import { ACCESS_TOKEN_PRIVATE_KEY, CONTROL_PANEL_URL } from '../global';

import { Platform } from '../types/global.types';
import { StackOverflowAccessTokenData } from '../services/platforms/stackoverflow/stackoverflow.types';

import AuthService from '../services/auth/auth.service';

type StackOverflowOAuthCallbackQueryType = {
  code: string,
};

const authService = new AuthService(prisma, ACCESS_TOKEN_PRIVATE_KEY);

export async function handleStackOverflowCallback(req: Request<{}, {}, {}, StackOverflowOAuthCallbackQueryType>, res: Response) {
  const accessTokenData: StackOverflowAccessTokenData | false = await authService.authenticateWithStackOverflow(req.query.code);

  if(accessTokenData !== false) {
    const accessToken = await authService.signUpOrLogin(Platform.STACKOVERFLOW, accessTokenData.accessToken);

    return res.redirect(`${CONTROL_PANEL_URL}/auth-callback?accessToken=${accessToken}`);
  }

  return res.redirect(`${CONTROL_PANEL_URL}/unauthorized`);
}