declare global {
  namespace NodeJS {
    interface ProcessEnv {
      NODE_ENV: 'development' | 'production';
      PORT?: string;
      STACKOVERFLOW_CLIENT_ID: string;
      STACKOVERFLOW_CLIENT_SECRET: string;
      STACKOVERFLOW_CLIENT_REDIRECT_URI: string;
      ACCESS_TOKEN_PRIVATE_KEY: string;
    }
  }
}

// If this file has no import/export statements (i.e. is a script)
// convert it into a module by adding an empty export statement.
export {}