import { Request, Response } from "express";
import * as standService from "../services/achatMunition";

export const findAll = async (req: Request, res: Response) => {
  const stand = await standService.findAll();
  res.send(stand);
};

export const findOne = async (req: Request, res: Response) => {
  try {
    const numLicencie = parseInt(req.params.inumLicencied);
    const idMunition = parseInt(req.params.idMunition);
    const stand = await standService.findOne(numLicencie,idMunition);
    res.send(stand);
  } catch (e) {
    res.send(e);
  }
};
