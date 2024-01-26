import type { PrismaClient, User } from "@prisma/client";

export default class TechnologyService {
  private prismaClient: PrismaClient;

  constructor(prismaClient: PrismaClient) {
    this.prismaClient = prismaClient;
  }

  public async listTechnologies() {
    return this.prismaClient.technology.findMany();
  }
}