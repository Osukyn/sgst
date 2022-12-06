-- CreateTable
CREATE TABLE "Personne" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "prenom" TEXT NOT NULL,
    "nom" TEXT NOT NULL,
    "adresse" TEXT NOT NULL,
    "ville" TEXT NOT NULL,
    "cp" VARCHAR(5) NOT NULL,
    "telephone" VARCHAR(10) NOT NULL,
    "dateNaissance" DATE NOT NULL,

    CONSTRAINT "Personne_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Moniteur" (
    "numAgrement" SERIAL NOT NULL,
    "personneId" INTEGER NOT NULL,

    CONSTRAINT "Moniteur_pkey" PRIMARY KEY ("numAgrement")
);

-- CreateTable
CREATE TABLE "Licencie" (
    "numLicencie" SERIAL NOT NULL,
    "annee" INTEGER NOT NULL,
    "personneId" INTEGER NOT NULL,

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
    "id" SERIAL NOT NULL,
    "numSerie" INTEGER NOT NULL,
    "nom" TEXT NOT NULL,
    "tarif" MONEY NOT NULL,
    "idHabilitation" INTEGER NOT NULL,
    "idMunition" INTEGER NOT NULL,

    CONSTRAINT "Arme_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AchatMunition" (
    "id" SERIAL NOT NULL,
    "quantite" INTEGER NOT NULL,
    "numLicencie" INTEGER NOT NULL,
    "idMunition" INTEGER NOT NULL,

    CONSTRAINT "AchatMunition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PossedeHabilitation" (
    "id" SERIAL NOT NULL,
    "dateObtention" DATE NOT NULL,
    "numLicencie" INTEGER NOT NULL,
    "idHabilitation" INTEGER NOT NULL,

    CONSTRAINT "PossedeHabilitation_pkey" PRIMARY KEY ("id")
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
    "idPersonne" INTEGER,
    "numAgrement" INTEGER,
    "idArme" INTEGER NOT NULL,
    "idPas" INTEGER NOT NULL,
    "creneauHeure" TIME(3),
    "pasId" INTEGER,

    CONSTRAINT "Reservation_pkey" PRIMARY KEY ("num")
);

-- CreateTable
CREATE TABLE "Creneau" (
    "heure" TIME(3) NOT NULL,

    CONSTRAINT "Creneau_pkey" PRIMARY KEY ("heure")
);

-- CreateTable
CREATE TABLE "Pas" (
    "id" SERIAL NOT NULL,
    "num" INTEGER NOT NULL,
    "idStand" INTEGER NOT NULL,

    CONSTRAINT "Pas_pkey" PRIMARY KEY ("id")
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
CREATE UNIQUE INDEX "Moniteur_personneId_key" ON "Moniteur"("personneId");

-- CreateIndex
CREATE UNIQUE INDEX "Licencie_personneId_key" ON "Licencie"("personneId");

-- CreateIndex
CREATE UNIQUE INDEX "Arme_numSerie_key" ON "Arme"("numSerie");

-- AddForeignKey
ALTER TABLE "Moniteur" ADD CONSTRAINT "Moniteur_personneId_fkey" FOREIGN KEY ("personneId") REFERENCES "Personne"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Licencie" ADD CONSTRAINT "Licencie_personneId_fkey" FOREIGN KEY ("personneId") REFERENCES "Personne"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

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
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_idPersonne_fkey" FOREIGN KEY ("idPersonne") REFERENCES "Personne"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_numAgrement_fkey" FOREIGN KEY ("numAgrement") REFERENCES "Moniteur"("numAgrement") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_idArme_fkey" FOREIGN KEY ("idArme") REFERENCES "Arme"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_creneauHeure_fkey" FOREIGN KEY ("creneauHeure") REFERENCES "Creneau"("heure") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_pasId_fkey" FOREIGN KEY ("pasId") REFERENCES "Pas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pas" ADD CONSTRAINT "Pas_idStand_fkey" FOREIGN KEY ("idStand") REFERENCES "Stand"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
