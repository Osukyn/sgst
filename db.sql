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

CREATE OR REPLACE FUNCTION verifier_reservation()
RETURNS TRIGGER AS $$
BEGIN
    -- Si la réservation contient un licencié
    IF NEW."numLicencie" IS NOT NULL THEN
        -- S'assurer que personneEmail et numAgrement sont NULL
        IF NEW."emailPersonne" IS NOT NULL OR NEW."numAgrement" IS NOT NULL THEN
            RAISE EXCEPTION 'Une réservation ne peut contenir un licencié et une personne + un moniteur en même temps.';
        END IF;
    ELSE
        -- S'assurer que personneEmail et numAgrement ne sont pas NULL
        IF NEW."emailPersonne" IS NULL OR NEW."numAgrement" IS NULL THEN
            RAISE EXCEPTION 'Une réservation doit contenir un licencié ou une personne + un moniteur.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verifier_reservation
BEFORE INSERT OR UPDATE ON "Reservation"
FOR EACH ROW EXECUTE PROCEDURE verifier_reservation();

CREATE OR REPLACE FUNCTION verifier_location()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier s'il y a déjà une réservation pour cet arme, ce jour et ce créneau
    IF EXISTS (SELECT * FROM "Reservation"
               WHERE "numArme" = NEW."numArme"
               AND date = NEW.date
               AND "creneauHeure" = NEW."creneauHeure"
               AND num <> new.num) THEN
        RAISE EXCEPTION 'Il n''est pas possible de louer la même arme plus d''une fois par créneau horaire.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verifier_location
BEFORE INSERT OR UPDATE ON "Reservation"
FOR EACH ROW EXECUTE PROCEDURE verifier_location();

CREATE OR REPLACE FUNCTION verifier_initiation()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier si l'email de la personne a déjà fait deux initiations cette année
    IF (SELECT COUNT(*) FROM "Reservation"
        WHERE "emailPersonne" = NEW."emailPersonne"
        AND "numLicencie" IS NULL
        AND "numAgrement" IS NOT NULL
        AND date >= date_trunc('year', NOW())) >= 2 THEN
        RAISE EXCEPTION 'Un visiteur ne peut faire que deux initiations maximum par an.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verifier_initiation
BEFORE INSERT OR UPDATE ON "Reservation"
FOR EACH ROW EXECUTE PROCEDURE verifier_initiation();

CREATE OR REPLACE FUNCTION verifier_pas()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier s'il y a déjà une réservation pour ce pas, ce jour et ce créneau
    IF EXISTS (SELECT * FROM "Reservation"
               WHERE "pasId" = NEW."pasId"
               AND date = NEW.date
               AND "creneauHeure" = NEW."creneauHeure"
               AND num <> NEW.num) THEN
        RAISE EXCEPTION 'Un pas ne peut pas être occupé plus d''une fois par jour et par créneau horaire.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verifier_pas
BEFORE INSERT OR UPDATE ON "Reservation"
FOR EACH ROW EXECUTE PROCEDURE verifier_pas();

CREATE OR REPLACE FUNCTION verifier_moniteur()
RETURNS TRIGGER AS $$
BEGIN
    -- Si la réservation est une initiation
    IF NEW."numAgrement" IS NOT NULL THEN
        -- Vérifier s'il y a déjà une réservation pour ce moniteur, ce jour et ce créneau
        IF EXISTS (SELECT * FROM "Reservation"
                   WHERE "numAgrement" = NEW."numAgrement"
                   AND date = NEW.date
                   AND "creneauHeure" = NEW."creneauHeure"
                   AND num <> NEW.num) THEN
            RAISE EXCEPTION 'Un moniteur ne peut pas être assigné à plusieurs initiations à la même date et au même créneau horaire.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verifier_moniteur
BEFORE INSERT OR UPDATE ON "Reservation"
FOR EACH ROW EXECUTE PROCEDURE verifier_moniteur();

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
