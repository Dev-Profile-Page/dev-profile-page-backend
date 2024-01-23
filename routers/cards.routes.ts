import express from 'express';
import { listCards } from '../controllers/cards.controller';

const router = express.Router();

router.get('/', listCards);

export default router;