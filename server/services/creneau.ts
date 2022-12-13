import { Creneau } from "@prisma/client";
import prisma from "../prisma/database";

const creneauModel = prisma.creneau;

export const findAll = (): Promise<Creneau[]> =>
  creneauModel.findMany();

export const findOne = (heure: number): Promise<Creneau> =>
  creneauModel.findUniqueOrThrow({
    where: {
      heure,
    },
  });
