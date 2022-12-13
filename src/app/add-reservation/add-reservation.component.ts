import {Component, OnInit} from '@angular/core';
import {filter, Observable, of, startWith, Subject, switchMap} from "rxjs";
import {FormBuilder, FormControl, FormGroup, Validators} from "@angular/forms";
import {TUI_DEFAULT_MATCHER, TuiDay, TuiTime} from "@taiga-ui/cdk";
import {PersonneService} from "../services/personne.service";
import {Licencie} from "../models/Personne";
import {CreneauService} from "../services/creneau.service";
import {ArmeService} from "../services/arme.service";
import {Arme} from "../models/Arme";
import {StandService} from "../services/stand.service";
import {Stand} from "../models/Stand";
import {Pas} from "../models/Pas";
import {PasService} from "../services/pas.service";
import {ReservationService} from "../services/reservation.service";
import {PersistReservation} from "../models/Reservation";

@Component({
  selector: 'app-add-reservation',
  templateUrl: './add-reservation.component.html',
  styleUrls: ['./add-reservation.component.scss']
})
export class AddReservationComponent implements OnInit {

  databaseData: Licencie[] = [];

  responded = false;
  returnedError = false;
  returnedMessage = "";

  dateResValue = new FormControl(null, Validators.required);
  testValue = new FormControl(null, Validators.required);
  timeValue = new FormControl(null, Validators.required);
  armeValue = new FormControl(null, Validators.required);
  standValue = new FormControl(null, Validators.required);
  pasValue = new FormControl(null, Validators.required);


  armeList: Arme[] = [];
  standList: Stand[] = [];
  allPasList: Pas[] = [];
  pasList: Pas[] = [];

  minDate = TuiDay.currentLocal();
  items2: TuiTime[] = [];
  formGroup: FormGroup;
  creneauxLoaded: boolean = false;

  constructor(private personneService: PersonneService,
              private creneauService: CreneauService,
              private armeService: ArmeService,
              private standService: StandService,
              private pasService: PasService,
              private reservationService: ReservationService,
              private fb: FormBuilder) {
    this.pasValue.disable();
    this.formGroup = this.fb.group(
      {
        dateResValue: this.dateResValue,
        testValue: this.testValue,
        timeValue: this.timeValue,
        armeValue: this.armeValue,
        standValue: this.standValue,
        pasValue: this.pasValue
      },
    );
  }

  ngOnInit(): void {
    this.creneauService.getCreneaux().subscribe(creneaux => {
      creneaux.forEach(creneau => this.items2.push(new TuiTime(creneau.heure, 0)));
      this.creneauxLoaded = true;
    });
    this.personneService.getLicencies().subscribe(value => this.databaseData = value);
    this.armeService.getArmes().subscribe(armes => this.armeList = armes);
    this.standService.getStands().subscribe(stands => this.standList = stands);
    this.pasService.getPas().subscribe(pas => this.allPasList = pas);

    this.standValue.valueChanges.subscribe(value => {
      if (value) {
        this.pasValue.enable();
        this.pasValue.setValue(null);
        this.pasList = this.allPasList.filter(pas => pas.idStand == (value as Stand).id)
      }
    });

    this.formGroup.valueChanges.subscribe(value => console.log(value));
  }

  readonly search$: Subject<string | null> = new Subject();

  readonly items$: Observable<readonly Licencie[] | null> = this.search$.pipe(
    filter(value => value !== null),
    switchMap(search =>
      this.serverRequest(search).pipe(startWith<readonly Licencie[] | null>(null)),
    ),
    startWith(this.databaseData),
  );

  onSearchChange(searchQuery: string | null): void {
    this.search$.next(searchQuery);
  }

  extractValueFromEvent(event: Event): string | null {
    return (event.target as HTMLInputElement)?.value || null;
  }

  private serverRequest(searchQuery: string | null): Observable<readonly Licencie[]> {
    const result = this.databaseData.filter(user =>
      TUI_DEFAULT_MATCHER(user, searchQuery || ``),
    );
    this.personneService.getPersonnes()

    return of(result);
  }

  clearForm() {
    Object.getOwnPropertyNames(this.formGroup.controls).forEach(name => this.formGroup.controls[name].setValue(null));
  }

  createReservation() {
    let reservation: PersistReservation = new PersistReservation((this.dateResValue.value as unknown as TuiDay).toUtcNativeDate(),
      (this.testValue.value as unknown as Licencie).numLicencie,
      null,
      null,
      (this.armeValue.value as unknown as Arme).numSerie,
      (this.timeValue.value as unknown as TuiTime).hours,
      (this.pasValue.value as unknown as Pas).num);
    console.log(reservation);
    this.reservationService.createReservation(reservation).subscribe(value => {
      console.log(value);
      if (value == null) {
        this.returnedError = false;
        this.responded = true;
        this.returnedMessage = "Nouvelle reservation effectuée!";
        this.clearForm();
        setTimeout(() => this.responded = false, 5000);
      } else {
        this.responded = false;
        this.returnedError = true;
        this.returnedMessage = "Une erreur s'est produite!";
        setTimeout(() => this.returnedError = false, 5000);
      }
    }, error => {
      this.responded = false;
      this.returnedError = true;
      console.log(error);
      setTimeout(() => this.returnedError = false, 5000);
    });
  }
}
