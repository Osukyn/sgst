import { PossedeHabilitation } from "@prisma/client";
import prisma from "../prisma/database";

const possedeHabilitationModel = prisma.possedeHabilitation;

export const findAll = (): Promise<PossedeHabilitation[]> =>
  possedeHabilitationModel.findMany();

export const findOne = (idHabilitation: number, numLicencie: number ): Promise<PossedeHabilitation> =>
  possedeHabilitationModel.findUniqueOrThrow({
    where: {
      numLicencie_idHabilitation: { numLicencie, idHabilitation  }
    },
  });

