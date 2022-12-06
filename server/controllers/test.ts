import { Request, Response } from "express";
import * as affectationService from "../services/test";


export const test = async (req: Request, res: Response) => {
  res.status(200).json({ message: "hello" });
};
