import type { Request, Response } from 'express';

import { prisma } from '../db/prisma_client';

import CardsService from '../services/cards/cards.service';
import { Response as AppResponse } from '../utils/response.utils';

const cardSerivce = new CardsService(prisma);

export async function listCards(_req: Request, res: Response) {
  try {
    const cards = await cardSerivce.listCards();

    const response = AppResponse.withData(cards).toSuccessResponseWithData();
    return res.status(200).json(response);
  } catch(err) {
    console.log(err);
    const response = AppResponse.withoutData().toServerIssueResponse();
    return res.status(500).json(response);
  }
}
