export interface Reservation {
  readonly nom: string;
  readonly prenom: string;
  readonly date: Date;
  readonly heure: number;
  readonly duree: number;
  readonly stand: number;
  readonly pas: number;
  type: string;
  readonly moniteur: string;
}
