import { Router } from "express";

import {
  findAll, findOne
} from "../controllers/stand";



const router = Router();


router.get("/stand/:id", findOne);
router.get("/stand", findAll);




export default router;

