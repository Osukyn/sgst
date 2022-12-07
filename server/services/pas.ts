import { Pas } from "@prisma/client";
import prisma from "../prisma/database";

const pasModel = prisma.pas;

export const findAll = (): Promise<Pas[]> =>
  pasModel.findMany();

export const findOne = (num: number): Promise<Pas> =>
  pasModel.findUniqueOrThrow({
    where: {
      num,
    },
  });

