import { Injectable } from '@angular/core';
import {Observable} from "rxjs";
import {Reservation} from "./models/Reservation";

@Injectable({
  providedIn: 'root'
})
export class ReservationService {

  constructor() { }

  getReservations(): Observable<Reservation[]> {
    return new Observable<Reservation[]>(subscriber => {
      const reservations: Reservation[] = [
        {
          nom: 'Nicolas',
          prenom: 'Luca',
          date: new Date(),
          heure: 17,
          duree: 1,
          stand: 50,
          pas: 1,
          type: 'Standard',
          moniteur: '',
        },
        {
          nom: 'Goubeur',
          prenom: 'Tibo',
          date: new Date(),
          heure: 17,
          duree: 1,
          stand: 50,
          pas: 1,
          type: 'Standard',
          moniteur: '',
        },
      ];
      setTimeout(() => {
        subscriber.next(reservations);
        subscriber.complete();
      }, 1000);
    });
  }
}
