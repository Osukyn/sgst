import { Munition } from "@prisma/client";
import prisma from "../prisma/database";

const munitionModel = prisma.munition;

export const findAll = (): Promise<Munition[]> =>
  munitionModel.findMany();

export const findOne = (id: number): Promise<Munition> =>
  munitionModel.findUniqueOrThrow({
    where: {
      id,
    },
  });

