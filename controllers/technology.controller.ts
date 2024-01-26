import type { Request, Response } from 'express';

import { prisma } from '../db/prisma_client';

import { Response as AppResponse } from '../utils/response.utils';
import TechnologyService from '../services/technology/technology.service';

const technologyService = new TechnologyService(prisma);

export async function listTechnologies(_req: Request, res: Response) {
  try {
    const technologies = await technologyService.listTechnologies();

    const response = AppResponse.withData(technologies).toSuccessResponseWithData();
    return res.status(200).json(response);
  } catch(err) {
    console.log(err);
    const response = AppResponse.withoutData().toServerIssueResponse();
    return res.status(500).json(response);
  }
}
