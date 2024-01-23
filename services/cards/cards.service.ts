import type { PrismaClient, User } from "@prisma/client";

export default class CardsService {
  private prismaClient: PrismaClient;

  constructor(prismaClient: PrismaClient) {
    this.prismaClient = prismaClient;
  }

  public async listCards() {
    return this.prismaClient.card.findMany({
      include: {
        platform: true,
      },
      where: {
        isActive: true,

        platform: {
          isActive: true,
        }
      },
    });
  }
}