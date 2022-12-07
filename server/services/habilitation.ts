import { Habilitation } from "@prisma/client";
import prisma from "../prisma/database";

const habilitationModel = prisma.habilitation;

export const findAll = (): Promise<Habilitation[]> =>
  habilitationModel.findMany();

export const findOne = (id: number): Promise<Habilitation> =>
  habilitationModel.findUniqueOrThrow({
    where: {
      id,
    },
  });

