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
