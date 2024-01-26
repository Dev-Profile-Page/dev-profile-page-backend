import express from 'express';
import { listTechnologies } from '../controllers/technology.controller';

const router = express.Router();

router.get('/', listTechnologies);

export default router;