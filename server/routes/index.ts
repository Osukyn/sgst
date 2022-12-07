import { Router } from "express";

const stand = require('../controllers/stand');
const achatmunition = require('../controllers/achatmunition');
const arme = require('../controllers/arme');
const creneau = require('../controllers/creneau');
const habilitation = require('../controllers/habilitation');
const licencie = require('../controllers/licencie');
const moniteur = require('../controllers/moniteur');
const munition = require('../controllers/munition');
const pas = require('../controllers/pas');
const personne = require('../controllers/personne');
const possedeHabilitation = require('../controllers/possedeHabilitation');
const reservation = require('../controllers/reservation');



const router = Router();


router.get("/stand/:id", stand.findOne);
router.get("/stand", stand.findAll);

router.get("/achatmunition/:id", achatmunition.findOne);
router.get("/achatmunition", achatmunition.findAll);

router.get("/arme/:id", arme.findOne);
router.get("/arme", arme.findAll);

router.get("/creneau/:id", creneau.findOne);
router.get("/creneau", creneau.findAll);

router.get("/habilitation/:id", habilitation.findOne);
router.get("/habilitation", habilitation.findAll);

router.get("/licencie/:id", licencie.findOne);
router.get("/licencie", licencie.findAll);

router.get("/moniteur/:id", moniteur.findOne);
router.get("/moniteur", moniteur.findAll);

router.get("/munition/:id", munition.findOne);
router.get("/munition", munition.findAll);

router.get("/pas/:id", pas.findOne);
router.get("/pas", pas.findAll);

router.get("/personne/:id", personne.findOne);
router.get("/personne", personne.findAll);

router.get("/possedeHabilitation/:id", possedeHabilitation.findOne);
router.get("/possedeHabilitation", possedeHabilitation.findAll);

router.get("/reservation/:id", reservation.findOne);
router.get("/reservation", reservation.findAll);

export default router;

