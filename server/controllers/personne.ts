import { Request, Response } from "express";
import * as standService from "../services/personne";

export const findAll = async (req: Request, res: Response) => {
  const stand = await standService.findAll();
  res.send(stand);
};

export const findOne = async (req: Request, res: Response) => {
  try {
    const id = req.params.id;
    const stand = await standService.findOne(id);
    res.send(stand);
  } catch (e) {
    res.send(e);
  }
};