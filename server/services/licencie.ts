import { Licencie } from "@prisma/client";
import prisma from "../prisma/database";

const licencieModel = prisma.licencie;

export const findAll = (): Promise<Licencie[]> =>
  licencieModel.findMany({
    include: {
      personne: true,
    }
  });

export const findOne = (numLicencie: number): Promise<Licencie> =>
  licencieModel.findUniqueOrThrow({
    where: {
      numLicencie,
    },
    include: {
      personne: true,
    }
  });

