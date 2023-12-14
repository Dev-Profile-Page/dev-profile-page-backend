import express from 'express';

import { handleStackOverflowCallback } from '../controllers/auth.controller';

const router = express.Router();

router.get('/stackoverflow', handleStackOverflowCallback);

export default router;