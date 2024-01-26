import type { PrismaClient, User } from "@prisma/client";

import { AccessTokenData, PlatformUserData } from "./auth.types";
import { Platform } from "../../types/global.types";
import { StackOverflowAccessTokenData, StackOverflowUser } from "../platforms/stackoverflow/stackoverflow.types";

import StackOverflowService from "../platforms/stackoverflow/stackoverflow";

import { CryptoUtils } from "../../utils/crypto.utils";
import { removeEscapeCharacters, stripHTML } from "../../utils/string.utils";

export default class AuthService {

  private prismaClient: PrismaClient;
  private accessTokenCryptoUtil: CryptoUtils;

  constructor(prismaClient: PrismaClient, accessTokenPrivateKey: string) {
    this.prismaClient = prismaClient;
    this.accessTokenCryptoUtil = new CryptoUtils(accessTokenPrivateKey);
  }

  public async authenticateWithStackOverflow(authorizationCode: string): Promise<StackOverflowAccessTokenData | false> {
    return StackOverflowService.exchangeAuthorizationCodeForAccessToken(authorizationCode);
  }

  public async signUpOrLogin(platform: Platform, platformAccessToken: string): Promise<string> {
    let accessToken = '';
    let accessTokenData: (AccessTokenData | null) = null;

    const { user, platformUserData } = await this.getUserByPlatform(platform, platformAccessToken)

    console.log('user from DB', user)

    if(!user) {
      // Sign up
      console.log('User signing up..');
      accessTokenData = await this.createNewUser(platformUserData, platform);
    } else {
      // Log In
      console.log('User logging in..');
      accessTokenData = {
        id: user.id,
        name: user.name || '',
        picture: user.picture || '',
        roles: ['user'],
      }
    }

    if(accessTokenData !== null) {
      accessToken = this.generateAccessToken(accessTokenData);
    } else {
      throw '';
    }

    return accessToken;
  }

  private async getUserByPlatform(platform: Platform, platformAccessToken: string) {
    let platformUserId = null;
    let platformUserData: PlatformUserData = null;

    if(platform === Platform.STACKOVERFLOW) {
      const stackoverflowService = new StackOverflowService(platformAccessToken);
      const user = await stackoverflowService.getUserData();

      if(user) {
        const userObj = user.items[0];

        platformUserId = userObj.user_id;
        platformUserData = {
          answers: userObj.answer_count,
          badges: (userObj.badge_counts.bronze || 0) + (userObj.badge_counts.silver || 0) + (userObj.badge_counts.gold || 0),
          bio: removeEscapeCharacters(stripHTML(userObj.about_me)),
          city: userObj.location,
          link: userObj.link,
          name: userObj.display_name,
          picture: userObj.profile_image,
          reputation: userObj.reputation,
          userId: userObj.user_id,
          views: userObj.view_count,
          website: userObj.website_url,
        } as StackOverflowUser;
      }
    }

    const user = await this.getUserByPlatformID(platform, String(platformUserId));

    return { platformUserData, user };
  }

  private async createNewUser(platformUserData: PlatformUserData, platform: Platform) {
    const platformObj = await this.prismaClient.platform.findFirst({
      where: {
        name: platform,
      },
      include: {
        card: true
      }
    });

    if(platformUserData !== null) {
      try {
        

        const newUser = await this.prismaClient.user.create({
          data: {
            createdAt: new Date(),
            bio: platformUserData.bio,
            city: platformUserData.city,
            name: platformUserData.name,
            picture: platformUserData.picture,

            socialAccount: {
              create: {
                platformAccountId: String(platformUserData.userId),
                ...platformUserData,
                platform: {
                  connect: {
                    id: platformObj?.id,
                  }
                }
              }
            },
            
            pagePageUserIdToUser: {
              create: {
                likes: 0,
              }
            }
          },
        });

        const accessTokenData: AccessTokenData = {
          id: newUser.id,
          picture: newUser.picture || '',
          name: newUser.name || '',
          roles: ['user'],
        };

        return accessTokenData;
      } catch(err) {
        console.log('Error while signing up', err);
        return null;
      }
    }

    return null;
  }

  private async getUserByPlatformID(platform: Platform, platformUserId: (string | null)): Promise<User | null> {
    if(platformUserId === null) {
      return null;
    }

    const socialAccount = await this.prismaClient.socialAccount.findFirst({
      select: {
        user: true
      },
      where: {
        AND: {
          platform: {
            name: {
              equals: platform
            }
          },
          platformAccountId: {
            equals: platformUserId,
          },
        },
      }
    });

    if(!socialAccount) {
      return null;
    }

    return socialAccount.user;
  }

  private generateAccessToken(accessTokenData: AccessTokenData) {
    return this.accessTokenCryptoUtil.createJWT(accessTokenData);
  }

  private validateAccessToken(accessToken: string) {
    return this.accessTokenCryptoUtil.verifyJWT(accessToken);
  }
}
