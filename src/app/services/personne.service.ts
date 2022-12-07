import { Injectable } from '@angular/core';
import {map, Observable} from "rxjs";
import {Licencie, Personne} from "../models/Personne";
import {HttpClient} from "@angular/common/http";

@Injectable({
  providedIn: 'root'
})
export class PersonneService {

  constructor(private httpClient: HttpClient) { }

  getPersonnes(): Observable<Personne[]> {
    return this.httpClient.get<Personne[]>('http://localhost:3000/personne');
  }

  getLicencies(): Observable<Licencie[]> {
    return this.httpClient.get('http://localhost:3000/licencie').pipe(
      map(value => (value as any[])
        .map(licencie => new Licencie(licencie.numLicencie, licencie.personne.prenom, licencie.personne.nom, licencie.personne.email))));
  }
}
