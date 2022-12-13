export class Reservation {
  constructor(readonly num: number,
              readonly nom: string,
              readonly prenom: string,
              readonly date: Date,
              readonly heure: number,
              readonly stand: number,
              readonly pas: number,
              readonly type: string,
              readonly moniteur: string,
              readonly arme: string) {
  }
}

export class PersistReservation {
  constructor(readonly date: Date,
              readonly numLicencie: number,
              readonly emailPersonne: string | null,
              readonly numAgrement: number | null,
              readonly numArme: number,
              readonly creneauHeure: number,
              readonly pasId: number) {
  }
}
