import { Request, Response } from "express";
import * as standService from "../services/reservation";

export const findAll = async (req: Request, res: Response) => {
  const resa = await standService.findAll();
  res.send(resa);
};

export const findOne = async (req: Request, res: Response) => {
  try {
    const id = parseInt(req.params["id"]);
    const resa = await standService.findOne(id);
    res.send(resa);
  } catch (e) {
    res.send(e);
  }
};

export const create = async (req: Request, res: Response) => {
  try {
    console.log(req.body);
    const resa = {
      "date": req.body.date,
      "numLicencie": req.body.numLicencie,
      "emailPersonne": req.body.emailPersonne,
      "numAgrement": req.body.numAgrement,
      "numArme": req.body.numArme,
      "creneauHeure": req.body.creneauHeure,
      "pasId": req.body.pasId,
    }

    await standService.create(resa);
    // const stand = await standService.findOne(id);
    res.status(200).json(req.body.version);
  } catch (e) {
    res.send(e);
  }
};
