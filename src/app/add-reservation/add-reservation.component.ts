import {Component, OnInit} from '@angular/core';
import {delay, filter, Observable, of, startWith, Subject, switchMap} from "rxjs";
import {FormControl} from "@angular/forms";
import {TUI_DEFAULT_MATCHER} from "@taiga-ui/cdk";
import {PersonneService} from "../services/personne.service";
import {Licencie} from "../models/Personne";

@Component({
  selector: 'app-add-reservation',
  templateUrl: './add-reservation.component.html',
  styleUrls: ['./add-reservation.component.scss']
})
export class AddReservationComponent implements OnInit {

  databaseData: Licencie[] = [];

  constructor(private personneService: PersonneService) {
  }
  ngOnInit(): void {
      this.personneService.getLicencies().subscribe(value => this.databaseData = value);
  }
  readonly search$: Subject<string | null> = new Subject();

  readonly items$: Observable<readonly Licencie[] | null> = this.search$.pipe(
    filter(value => value !== null),
    switchMap(search =>
      this.serverRequest(search).pipe(startWith<readonly Licencie[] | null>(null)),
    ),
    startWith(this.databaseData),
  );

  readonly testValue = new FormControl();

  onSearchChange(searchQuery: string | null): void {
    this.search$.next(searchQuery);
  }

  extractValueFromEvent(event: Event): string | null {
    return (event.target as HTMLInputElement)?.value || null;
  }

  /**
   * Service request emulation
   */
  private serverRequest(searchQuery: string | null): Observable<readonly Licencie[]> {
    const result = this.databaseData.filter(user =>
      TUI_DEFAULT_MATCHER(user, searchQuery || ``),
    );
    this.personneService.getPersonnes()

    return of(result);
  }
}
