import { Stand } from "@prisma/client";
import prisma from "../prisma/database";

const standModel = prisma.stand;

export const findAll = (): Promise<Stand[]> =>
  standModel.findMany();

export const findOne = (id: number): Promise<Stand> =>
  standModel.findUniqueOrThrow({
    where: {
      id,
    },
  });

