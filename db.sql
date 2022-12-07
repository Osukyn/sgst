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

/*
  Warnings:

  - The primary key for the `Arme` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Arme` table. All the data in the column will be lost.
  - The primary key for the `Creneau` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `personneId` on the `Licencie` table. All the data in the column will be lost.
  - You are about to drop the column `personneId` on the `Moniteur` table. All the data in the column will be lost.
  - The primary key for the `Pas` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Pas` table. All the data in the column will be lost.
  - The primary key for the `Personne` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Personne` table. All the data in the column will be lost.
  - You are about to drop the column `idArme` on the `Reservation` table. All the data in the column will be lost.
  - You are about to drop the column `idPersonne` on the `Reservation` table. All the data in the column will be lost.
  - The `creneauHeure` column on the `Reservation` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - A unique constraint covering the columns `[personneEmail]` on the table `Licencie` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[personneEmail]` on the table `Moniteur` will be added. If there are existing duplicate values, this will fail.
  - Changed the type of `heure` on the `Creneau` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `personneEmail` to the `Licencie` table without a default value. This is not possible if the table is not empty.
  - Added the required column `personneEmail` to the `Moniteur` table without a default value. This is not possible if the table is not empty.
  - Added the required column `numArme` to the `Reservation` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Licencie" DROP CONSTRAINT "Licencie_personneId_fkey";

-- DropForeignKey
ALTER TABLE "Moniteur" DROP CONSTRAINT "Moniteur_personneId_fkey";

-- DropForeignKey
ALTER TABLE "Reservation" DROP CONSTRAINT "Reservation_creneauHeure_fkey";

-- DropForeignKey
ALTER TABLE "Reservation" DROP CONSTRAINT "Reservation_idArme_fkey";

-- DropForeignKey
ALTER TABLE "Reservation" DROP CONSTRAINT "Reservation_idPersonne_fkey";

-- DropForeignKey
ALTER TABLE "Reservation" DROP CONSTRAINT "Reservation_pasId_fkey";

-- DropIndex
DROP INDEX "Arme_numSerie_key";

-- DropIndex
DROP INDEX "Licencie_personneId_key";

-- DropIndex
DROP INDEX "Moniteur_personneId_key";

-- AlterTable
ALTER TABLE "Arme" DROP CONSTRAINT "Arme_pkey",
DROP COLUMN "id",
ADD CONSTRAINT "Arme_pkey" PRIMARY KEY ("numSerie");

-- AlterTable
ALTER TABLE "Creneau" DROP CONSTRAINT "Creneau_pkey",
DROP COLUMN "heure",
ADD COLUMN     "heure" INTEGER NOT NULL,
ADD CONSTRAINT "Creneau_pkey" PRIMARY KEY ("heure");

-- AlterTable
ALTER TABLE "Licencie" DROP COLUMN "personneId",
ADD COLUMN     "personneEmail" TEXT NOT NULL,
ALTER COLUMN "numLicencie" DROP DEFAULT;
DROP SEQUENCE "Licencie_numLicencie_seq";

-- AlterTable
ALTER TABLE "Moniteur" DROP COLUMN "personneId",
ADD COLUMN     "personneEmail" TEXT NOT NULL,
ALTER COLUMN "numAgrement" DROP DEFAULT;
DROP SEQUENCE "Moniteur_numAgrement_seq";

-- AlterTable
CREATE SEQUENCE pas_num_seq;
ALTER TABLE "Pas" DROP CONSTRAINT "Pas_pkey",
DROP COLUMN "id",
ALTER COLUMN "num" SET DEFAULT nextval('pas_num_seq'),
ADD CONSTRAINT "Pas_pkey" PRIMARY KEY ("num");
ALTER SEQUENCE pas_num_seq OWNED BY "Pas"."num";

-- AlterTable
ALTER TABLE "Personne" DROP CONSTRAINT "Personne_pkey",
DROP COLUMN "id",
ADD CONSTRAINT "Personne_pkey" PRIMARY KEY ("email");

-- AlterTable
ALTER TABLE "Reservation" DROP COLUMN "idArme",
DROP COLUMN "idPersonne",
ADD COLUMN     "emailPersonne" TEXT,
ADD COLUMN     "numArme" INTEGER NOT NULL,
DROP COLUMN "creneauHeure",
ADD COLUMN     "creneauHeure" INTEGER;

-- CreateIndex
CREATE UNIQUE INDEX "Licencie_personneEmail_key" ON "Licencie"("personneEmail");

-- CreateIndex
CREATE UNIQUE INDEX "Moniteur_personneEmail_key" ON "Moniteur"("personneEmail");

-- AddForeignKey
ALTER TABLE "Moniteur" ADD CONSTRAINT "Moniteur_personneEmail_fkey" FOREIGN KEY ("personneEmail") REFERENCES "Personne"("email") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Licencie" ADD CONSTRAINT "Licencie_personneEmail_fkey" FOREIGN KEY ("personneEmail") REFERENCES "Personne"("email") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_emailPersonne_fkey" FOREIGN KEY ("emailPersonne") REFERENCES "Personne"("email") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_numArme_fkey" FOREIGN KEY ("numArme") REFERENCES "Arme"("numSerie") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_creneauHeure_fkey" FOREIGN KEY ("creneauHeure") REFERENCES "Creneau"("heure") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_pasId_fkey" FOREIGN KEY ("pasId") REFERENCES "Pas"("num") ON DELETE SET NULL ON UPDATE CASCADE;

/*
  Warnings:

  - The primary key for the `AchatMunition` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `AchatMunition` table. All the data in the column will be lost.
  - The primary key for the `PossedeHabilitation` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `PossedeHabilitation` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "AchatMunition" DROP CONSTRAINT "AchatMunition_pkey",
DROP COLUMN "id",
ADD CONSTRAINT "AchatMunition_pkey" PRIMARY KEY ("numLicencie", "idMunition");

-- AlterTable
ALTER TABLE "PossedeHabilitation" DROP CONSTRAINT "PossedeHabilitation_pkey",
DROP COLUMN "id",
ADD CONSTRAINT "PossedeHabilitation_pkey" PRIMARY KEY ("numLicencie", "idHabilitation");

/*
  Warnings:

  - You are about to drop the column `idPas` on the `Reservation` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Reservation" DROP COLUMN "idPas";


insert into "Creneau" (heure)
values (8),
       (9),
       (10),
       (11),
       (12),
       (13),
       (14),
       (15),
       (16),
       (17),
       (18),
       (19);

insert into "Personne" (email, prenom, nom, adresse, ville, cp, telephone, "dateNaissance")
values ('luka@luka.net', 'Luca', 'Nicolas', '52 rue des bulldog', 'Toulon', '83100', '0701010101', '2000-01-01'),
       ('tibo@tibo.fr', 'Thybault', 'Gobert', '3 rue des potiers', 'Hyeres', '83400', '0761365591', '1995-01-01'),
       ('antoiiiiine@xptdr.lol', 'Thybault', 'Gobert', '88 rue des huits', 'Paris', '75002', '0155211456',
        '1970-01-01');

insert into "Moniteur" ("numAgrement", "personneEmail")
values (85698547, 'tibo@tibo.fr');

insert into "Licencie" ("numLicencie", annee, "personneEmail")
values (456821, 0, 'luka@luka.net'),
       (457896, 0, 'tibo@tibo.fr');

insert into "Munition" (id, libelle, "tailleBoite")
values (3, '9x19 PARA', 50),
       (1, '.223 win', 25),
       (2, '7.62x39', 25);

insert into "AchatMunition" (quantite, "numLicencie", "idMunition")
values (1, 456821, 3),
       (2, 456821, 2),
       (1, 457896, 3),
       (5, 457896, 1);

insert into "Habilitation" (id, libelle)
values (1, 'Arme de poing'),
       (2, 'Arme longue');

insert into "Arme" ("numSerie", nom, tarif, "idHabilitation", "idMunition")
values (589651, 'Glock 17', '$10.00', 2, 3),
       (998745, 'AR-15', '$50.00', 2, 1),
       (369547, 'AK-47', '$35.00', 2, 2);

insert into "PossedeHabilitation" ("dateObtention", "numLicencie", "idHabilitation")
values ('2021-01-01', 456821, 1),
       ('2021-01-01', 457896, 1),
       ('2021-01-01', 457896, 2);

insert into "Stand" (id, distance)
values (1, 10),
       (2, 25),
       (3, 50);

insert into "Pas" (num, "idStand")
values (1, 1),
       (2, 1),
       (3, 2),
       (4, 2),
       (5, 2),
       (6, 3),
       (7, 3),
       (8, 3);

insert into "Reservation" (num, date, "numLicencie", "numAgrement", "pasId", "emailPersonne", "numArme", "creneauHeure")
values (2, '2022-01-01', 457896, null, 7, null, 998745, 15),
       (1, '2022-01-01', 456821, null, 6, null, 589651, 10),
       (3, '2022-01-01', null, 85698547, 1, 'antoiiiiine@xptdr.lol', 589651, 19);
