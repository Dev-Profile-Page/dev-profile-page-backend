import { StackOverflowUser } from "../platforms/stackoverflow/stackoverflow.types";

// It'll be a union of all platform user objects
export type PlatformUserData = null | StackOverflowUser;

export type AccessTokenData = {
  id: number,
  name: string,
  picture: string,
  roles: string[],
};