-- CreateTable
CREATE TABLE "Personne" (
    "email" TEXT NOT NULL,
    "prenom" TEXT NOT NULL,
    "nom" TEXT NOT NULL,
    "adresse" TEXT NOT NULL,
    "ville" TEXT NOT NULL,
    "cp" VARCHAR(5) NOT NULL,
    "telephone" VARCHAR(10) NOT NULL,
    "dateNaissance" DATE NOT NULL,

    CONSTRAINT "Personne_pkey" PRIMARY KEY ("email")
);

-- CreateTable
CREATE TABLE "Moniteur" (
    "numAgrement" INTEGER NOT NULL,
    "personneEmail" TEXT NOT NULL,

    CONSTRAINT "Moniteur_pkey" PRIMARY KEY ("numAgrement")
);

-- CreateTable
CREATE TABLE "Licencie" (
    "numLicencie" INTEGER NOT NULL,
    "annee" INTEGER NOT NULL,
    "personneEmail" TEXT NOT NULL,

    CONSTRAINT "Licencie_pkey" PRIMARY KEY ("numLicencie")
);

-- CreateTable
CREATE TABLE "Habilitation" (
    "id" SERIAL NOT NULL,
    "libelle" TEXT NOT NULL,

    CONSTRAINT "Habilitation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Arme" (
    "numSerie" INTEGER NOT NULL,
    "nom" TEXT NOT NULL,
    "tarif" MONEY NOT NULL,
    "idHabilitation" INTEGER NOT NULL,
    "idMunition" INTEGER NOT NULL,

    CONSTRAINT "Arme_pkey" PRIMARY KEY ("numSerie")
);

-- CreateTable
CREATE TABLE "AchatMunition" (
    "quantite" INTEGER NOT NULL,
    "numLicencie" INTEGER NOT NULL,
    "idMunition" INTEGER NOT NULL,

    CONSTRAINT "AchatMunition_pkey" PRIMARY KEY ("numLicencie","idMunition")
);

-- CreateTable
CREATE TABLE "PossedeHabilitation" (
    "dateObtention" DATE NOT NULL,
    "numLicencie" INTEGER NOT NULL,
    "idHabilitation" INTEGER NOT NULL,

    CONSTRAINT "PossedeHabilitation_pkey" PRIMARY KEY ("numLicencie","idHabilitation")
);

-- CreateTable
CREATE TABLE "Munition" (
    "id" SERIAL NOT NULL,
    "libelle" TEXT NOT NULL,
    "tailleBoite" INTEGER NOT NULL,

    CONSTRAINT "Munition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Reservation" (
    "num" SERIAL NOT NULL,
    "date" DATE NOT NULL,
    "numLicencie" INTEGER,
    "emailPersonne" TEXT,
    "numAgrement" INTEGER,
    "numArme" INTEGER NOT NULL,
    "creneauHeure" INTEGER,
    "pasId" INTEGER,

    CONSTRAINT "Reservation_pkey" PRIMARY KEY ("num")
);

-- CreateTable
CREATE TABLE "Creneau" (
    "heure" INTEGER NOT NULL,

    CONSTRAINT "Creneau_pkey" PRIMARY KEY ("heure")
);

-- CreateTable
CREATE TABLE "Pas" (
    "num" SERIAL NOT NULL,
    "idStand" INTEGER NOT NULL,

    CONSTRAINT "Pas_pkey" PRIMARY KEY ("num")
);

-- CreateTable
CREATE TABLE "Stand" (
    "id" SERIAL NOT NULL,
    "distance" INTEGER NOT NULL,

    CONSTRAINT "Stand_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Personne_email_key" ON "Personne"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Moniteur_personneEmail_key" ON "Moniteur"("personneEmail");

-- CreateIndex
CREATE UNIQUE INDEX "Licencie_personneEmail_key" ON "Licencie"("personneEmail");

-- AddForeignKey
ALTER TABLE "Moniteur" ADD CONSTRAINT "Moniteur_personneEmail_fkey" FOREIGN KEY ("personneEmail") REFERENCES "Personne"("email") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Licencie" ADD CONSTRAINT "Licencie_personneEmail_fkey" FOREIGN KEY ("personneEmail") REFERENCES "Personne"("email") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Arme" ADD CONSTRAINT "Arme_idHabilitation_fkey" FOREIGN KEY ("idHabilitation") REFERENCES "Habilitation"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Arme" ADD CONSTRAINT "Arme_idMunition_fkey" FOREIGN KEY ("idMunition") REFERENCES "Munition"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AchatMunition" ADD CONSTRAINT "AchatMunition_idMunition_fkey" FOREIGN KEY ("idMunition") REFERENCES "Munition"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AchatMunition" ADD CONSTRAINT "AchatMunition_numLicencie_fkey" FOREIGN KEY ("numLicencie") REFERENCES "Licencie"("numLicencie") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PossedeHabilitation" ADD CONSTRAINT "PossedeHabilitation_idHabilitation_fkey" FOREIGN KEY ("idHabilitation") REFERENCES "Habilitation"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PossedeHabilitation" ADD CONSTRAINT "PossedeHabilitation_numLicencie_fkey" FOREIGN KEY ("numLicencie") REFERENCES "Licencie"("numLicencie") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_numLicencie_fkey" FOREIGN KEY ("numLicencie") REFERENCES "Licencie"("numLicencie") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_emailPersonne_fkey" FOREIGN KEY ("emailPersonne") REFERENCES "Personne"("email") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_numAgrement_fkey" FOREIGN KEY ("numAgrement") REFERENCES "Moniteur"("numAgrement") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_numArme_fkey" FOREIGN KEY ("numArme") REFERENCES "Arme"("numSerie") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_creneauHeure_fkey" FOREIGN KEY ("creneauHeure") REFERENCES "Creneau"("heure") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_pasId_fkey" FOREIGN KEY ("pasId") REFERENCES "Pas"("num") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pas" ADD CONSTRAINT "Pas_idStand_fkey" FOREIGN KEY ("idStand") REFERENCES "Stand"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
