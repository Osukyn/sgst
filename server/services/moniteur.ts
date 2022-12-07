import { Moniteur } from "@prisma/client";
import prisma from "../prisma/database";

const moniteurModel = prisma.moniteur;

export const findAll = (): Promise<Moniteur[]> =>
  moniteurModel.findMany();

export const findOne = (numAgrement: number): Promise<Moniteur> =>
  moniteurModel.findUniqueOrThrow({
    where: {
      numAgrement,
    },
  });

