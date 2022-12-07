import { Arme } from "@prisma/client";
import prisma from "../prisma/database";

const armeModel = prisma.arme;

export const findAll = (): Promise<Arme[]> =>
  armeModel.findMany();

export const findOne = (numSerie: number): Promise<Arme> =>
  armeModel.findUniqueOrThrow({
    where: {
      numSerie,
    },
  });

