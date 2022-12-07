import express, { Express, NextFunction, Request, Response } from "express";
import router from "./routes";
import { PrismaClient } from '@prisma/client'


const app: Express = express();

export default app;


const headers = (req: Request, res: Response) => {
  res.setHeader("Cache-Control", "no-cache");
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Credentials", "true");
  res.setHeader(
    "Access-Control-Allow-Methods",
    "GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS"
  );
  res.setHeader(
    "Access-Control-Allow-Headers",
    "Content-Type, Authorization, Accept"
  );
};
app.use((req: Request, res: Response, next: NextFunction) => {
  headers(req, res);
  res.removeHeader("X-Powered-By");
  if (req.method === "OPTIONS") {
    return res.end();
  }
  next();
});

app.use(express.json({ limit: "50MB" }));
app.use(express.urlencoded({ extended: false }));
app.use(router);



