import {Component, OnInit} from '@angular/core';
import {Reservation} from "../models/Reservation";
import {ReservationService} from "../services/reservation.service";

@Component({
  selector: 'app-reservation-table',
  templateUrl: './reservation-table.component.html',
  styleUrls: ['./reservation-table.component.scss', './table.less'],
})
export class ReservationTableComponent implements OnInit {
  data: Reservation[] = [];
  columns = ['nom', 'prenom', 'date', 'heure', 'stand', 'pas', 'type', 'moniteur', 'arme'];
  loading = true;

  constructor(private reservationService: ReservationService) {}

  ngOnInit(): void {
    this.reservationService.getReservations().subscribe(value => {
      this.data = value;
      this.loading = false;
    });

  }
}
