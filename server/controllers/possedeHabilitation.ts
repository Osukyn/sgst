import { Request, Response } from "express";
import * as standService from "../services/possedeHabilitation";

export const findAll = async (req: Request, res: Response) => {
  const stand = await standService.findAll();
  res.send(stand);
};

export const findOne = async (req: Request, res: Response) => {
  try {
    const numLicencie = parseInt(req.params.numLicencie);
    const idHabilitation = parseInt(req.params.idHabilitation);
    const stand = await standService.findOne(numLicencie,idHabilitation);
    res.send(stand);
  } catch (e) {
    res.send(e);
  }
};
