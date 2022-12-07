import { AchatMunition } from "@prisma/client";
import prisma from "../prisma/database";

const achatMunitionModel = prisma.achatMunition;

export const findAll = (): Promise<AchatMunition[]> =>
  achatMunitionModel.findMany();

export const findOne = (idMunition: number, numLicencie: number ): Promise<AchatMunition> =>
  achatMunitionModel.findUniqueOrThrow({
    where: {
      numLicencie_idMunition: { idMunition, numLicencie  }
    },
  });

