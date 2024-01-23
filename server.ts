import express, { Express, Request, Response } from 'express';
import compression from 'compression';

import authRouter from './routers/auth.routes';
import cardsRouter from './routers/cards.routes';

import { authNZ } from './middelwares/authnz.middleware';

const app: Express = express();
const port = process.env.PORT;

app.use(compression());

app.get('/', (req: Request, res: Response) => {
  res.send('Express + TypeScript Server');
});

app.use('/oauth/callback', authRouter);

app.use('/cards', authNZ(['user']), cardsRouter);

app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port} 🔥`);
});