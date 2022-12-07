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
