export type StackOverflowAccessTokenResponse = {
  access_token: string,
  expires_in: number,
}

export type StackOverflowAccessTokenData = {
  accessToken: string,
  expiresIn: number,
}

export interface StackOverflowUserDataResponse {
  items: Item[]
}

export interface Item {
  badge_counts: BadgeCounts
  view_count: number
  answer_count: number
  reputation: number
  user_id: number
  about_me: string
  location: string
  website_url: string
  link: string
  profile_image: string
  display_name: string
}

export interface BadgeCounts {
  bronze: number
  silver: number
  gold: number
}

export interface TotalResponse {
  total: number;
}

export interface StackOverflowUser {
  badges: number;
  views: number;
  answers: number;
  reputation: number;
  userId: number;
  bio: string;
  city: string;
  website: string;
  link: string;
  picture: string;
  name: string;
};