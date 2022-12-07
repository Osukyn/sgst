import { Personne } from "@prisma/client";
import prisma from "../prisma/database";

const personneModel = prisma.personne;

export const findAll = (): Promise<Personne[]> =>
  personneModel.findMany();

export const findOne = (email: string): Promise<Personne> =>
  personneModel.findUniqueOrThrow({
    where: {
      email,
    },
  });

