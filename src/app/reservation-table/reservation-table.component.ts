import {Component, OnInit} from '@angular/core';
import {Reservation} from "../models/Reservation";
import {ReservationService} from "../reservation.service";

@Component({
  selector: 'app-reservation-table',
  templateUrl: './reservation-table.component.html',
  styleUrls: ['./reservation-table.component.scss'],
})
export class ReservationTableComponent implements OnInit{
  data: Reservation[] = [];
  columns = ['nom', 'prenom', 'date', 'heure', 'duree', 'stand', 'pas', 'type', 'moniteur'];
  loading = true;

  constructor(private reservationService: ReservationService) {}

  ngOnInit(): void {
    this.reservationService.getReservations().subscribe(value => {
      this.data = value;
      this.columns = Object.keys(this.data[0]);
      this.loading = false;
    });

  }
}
