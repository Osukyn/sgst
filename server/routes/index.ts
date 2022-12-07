import { Router } from "express";

import {
  findAll, findOne
} from "../controllers/stand";



const router = Router();


router.get("/stand/:id", findOne);
router.get("/stand", findAll);

router.get("/achatmunition/:id", findOne);
router.get("/achatmunition", findAll);

router.get("/arme/:id", findOne);
router.get("/arme", findAll);

router.get("/creneau/:id", findOne);
router.get("/creneau", findAll);

router.get("/habilitation/:id", findOne);
router.get("/habilitation", findAll);

router.get("/licencie/:id", findOne);
router.get("/licencie", findAll);

router.get("/moniteur/:id", findOne);
router.get("/moniteur", findAll);

router.get("/munition/:id", findOne);
router.get("/munition", findAll);

router.get("/pas/:id", findOne);
router.get("/pas", findAll);

router.get("/personne/:id", findOne);
router.get("/personne", findAll);

router.get("/possedeHabilitation/:id", findOne);
router.get("/possedeHabilitation", findAll);

router.get("/reservation/:id", findOne);
router.get("/reservation", findAll);

export default router;

