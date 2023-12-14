import { URLSearchParams } from "url"

import { STACKEXCHANE_SITE, STACKEXCHANGE_ROOT_URL, STACKEXCHANGE_SITE_KEY, STACKEXCHANGE_USER_FILTER, STACKOVERFLOW_CLIENT_ID, STACKOVERFLOW_CLIENT_REDIRECT_URI, STACKOVERFLOW_CLIENT_SECRET } from "../../../global"

import { StackOverflowAccessTokenData, StackOverflowAccessTokenResponse, StackOverflowUserDataResponse } from "./stackoverflow.types";

export default class StackOverflowService {
  private accessToken: string = '';

  constructor(accessToken: string) {
    this.accessToken = accessToken;
  }

  private prepareGetRequestURL(endpoint: string): URL {
    const url = new URL(`${STACKEXCHANGE_ROOT_URL}/${endpoint}`);
    url.searchParams.append('key', STACKEXCHANGE_SITE_KEY);
    url.searchParams.append('access_token', this.accessToken);
    url.searchParams.append('site', STACKEXCHANE_SITE);

    return url;
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

      console.log(data);

      return {
        accessToken: data.access_token,
        expiresIn: data.expires_in,
      };

    } catch(err) {
      console.log(err);
      return false;
    }
  }

  public async getUserData(): Promise<StackOverflowUserDataResponse | false> {
    try {
      const url = this.prepareGetRequestURL('me');
      url.searchParams.append('filter', STACKEXCHANGE_USER_FILTER);

      const response = await fetch(url);

      const data: StackOverflowUserDataResponse = await response.json();
      return data;
    } catch(err) {
      console.log(err);
      return false;
    }
  }
}