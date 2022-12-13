import {Injectable} from '@angular/core';
import {map, Observable} from "rxjs";
import {PersistReservation, Reservation} from "../models/Reservation";
import {HttpClient} from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class ReservationService {

  constructor(private httpClient: HttpClient) {
  }

  getReservations(): Observable<Reservation[]> {
    return this.httpClient.get('http://localhost:3000/reservation').pipe(
      map(value => (value as any[])
        .map(reservation => new Reservation(
          reservation.num,
          reservation.personne ? reservation.personne.nom : reservation.licencie.personne.nom,
          reservation.personne ? reservation.personne.prenom : reservation.licencie.personne.prenom,
          reservation.date,
          reservation.creneauHeure,
          reservation.Pas.stand.distance,
          reservation.Pas.num,
          reservation.personne ? 'Initiation' : 'Standard',
          reservation.moniteur ? `${reservation.moniteur.personne.prenom} ${reservation.moniteur.personne.nom}` : 'Pas de moniteur',
          reservation.arme.nom))));
  }

  createReservation(reservation: PersistReservation): Observable<any> {
    return this.httpClient.post('http://localhost:3000/reservation', reservation);
  }
}
