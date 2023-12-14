import { Request, Response } from 'express';
import AuthService from '../services/auth/auth.service';
import StackOverflowService from '../services/platforms/stackoverflow/stackoverflow';
import { StackOverflowAccessTokenData } from '../services/platforms/stackoverflow/stackoverflow.types';
import { Platform } from '../types/global.types';
import { prisma } from '../db/prisma_client';
import { ACCESS_TOKEN_PRIVATE_KEY } from '../global';

type StackOverflowOAuthCallbackQueryType = {
  code: string,
};

const authService = new AuthService(prisma, ACCESS_TOKEN_PRIVATE_KEY);

export async function handleStackOverflowCallback(req: Request<{}, {}, {}, StackOverflowOAuthCallbackQueryType>, res: Response) {
  const accessTokenData: StackOverflowAccessTokenData | false = await authService.authenticateWithStackOverflow(req.query.code);

  if(accessTokenData !== false) {
    const accessToken = await authService.signUpOrLogin(Platform.STACKOVERFLOW, accessTokenData.accessToken);

    return res.redirect(`http://localhost:5173?accessToken=${accessToken}`);
  }

  return res.redirect('http://localhost:5173/unauthorized');
}