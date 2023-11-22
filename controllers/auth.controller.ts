import { Request, Response } from 'express';
import AuthService from '../services/auth.service';
import StackOverflowService, { StackOverflowAccessTokenData } from '../services/platforms/stackoverflow';

type StackOverflowOAuthCallbackQueryType = {
  code: string,
};

const authService = new AuthService();

export async function handleStackOverflowCallback(req: Request<{}, {}, {}, StackOverflowOAuthCallbackQueryType>, res: Response) {
  const accessTokenData: StackOverflowAccessTokenData | false = await authService.authenticateWithStackOverflow(req.query.code);

  if(accessTokenData !== false) {
    // TODO: prepare and send our own access token
    // TODO: call respective services to obtain data about user

    return res.redirect('http://localhost:5173/dashboard');
  }

  return res.redirect('http://localhost:5173/unauthorized');
}