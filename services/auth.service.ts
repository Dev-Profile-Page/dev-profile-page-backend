import StackOverflowService, { StackOverflowAccessTokenData } from "./platforms/stackoverflow";

export default class AuthService {

  public async authenticateWithStackOverflow(authorizationCode: string): Promise<StackOverflowAccessTokenData | false> {
    return StackOverflowService.exchangeAuthorizationCodeForAccessToken(authorizationCode);
  }
}
