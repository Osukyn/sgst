import { Reservation } from "@prisma/client";
import prisma from "../prisma/database";

const reservationModel = prisma.reservation;

export const findAll = (): Promise<Reservation[]> =>
  reservationModel.findMany();

export const findOne = (num: number): Promise<Reservation> =>
  reservationModel.findUniqueOrThrow({
    where: {
      num,
    },
  });

