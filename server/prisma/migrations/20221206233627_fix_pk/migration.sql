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
