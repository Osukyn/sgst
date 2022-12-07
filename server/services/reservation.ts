import { Reservation, Stand } from "@prisma/client";
import prisma from "../prisma/database";

const reservationModel = prisma.reservation;

export const findAll = (): Promise<Reservation[]> =>
  reservationModel.findMany({
    include: {
      personne: true,
      licencie: {
        include: {
          personne: true
        }
      },
      moniteur: {
        include: {
          personne: true
        }
      },
      Pas: {
        include : {
          stand: true,
        }
      },
      arme: true,
    }
  });

export const findOne = (num: number): Promise<Reservation> =>
  reservationModel.findUniqueOrThrow({
    where: {
      num,
    },
  });

export const create = (resa: any): Promise<Reservation> =>
  reservationModel.create({
    data: resa
  });

