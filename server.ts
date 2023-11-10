import express, { Express, Request, Response } from 'express';
import compression from 'compression';

const app: Express = express();
const port = process.env.PORT;

app.use(compression());

app.get('/', (req: Request, res: Response) => {
  res.send('Express + TypeScript Server');
});

app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port} 🔥`);
});