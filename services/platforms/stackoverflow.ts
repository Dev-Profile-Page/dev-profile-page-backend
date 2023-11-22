import { URLSearchParams } from "url"
import { STACKOVERFLOW_CLIENT_ID, STACKOVERFLOW_CLIENT_REDIRECT_URI, STACKOVERFLOW_CLIENT_SECRET } from "../../global"

type StackOverflowAccessTokenResponse = {
  access_token: string,
  expires_in: number,
}

export type StackOverflowAccessTokenData = {
  accessToken: string,
  expiresIn: number,
}

export default class StackOverflowService {
  private accessToken: string = '';

  constructor(accessToken: string) {
    this.accessToken = accessToken;
  }

  public static async exchangeAuthorizationCodeForAccessToken(authorizationCode: string): Promise<StackOverflowAccessTokenData | false> {
    try {
      const response = await fetch('https://stackoverflow.com/oauth/access_token/json', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
          client_id: STACKOVERFLOW_CLIENT_ID,
          client_secret: STACKOVERFLOW_CLIENT_SECRET,
          redirect_uri: STACKOVERFLOW_CLIENT_REDIRECT_URI,
          code: authorizationCode,
        }),
      });
  
      const data: StackOverflowAccessTokenResponse = await response.json();

      return {
        accessToken: data.access_token,
        expiresIn: data.expires_in,
      };

    } catch(err) {
      console.log(err);
      return false;
    }
  }

  // TODO: other methods to get data about user
}