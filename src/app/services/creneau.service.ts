import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Personne} from "../models/Personne";
import {Creneau} from "../models/Creneau";

@Injectable({
  providedIn: 'root'
})
export class CreneauService {

  constructor(private httpClient: HttpClient) { }

  getCreneaux(): Observable<Creneau[]> {
    return this.httpClient.get<Creneau[]>('http://localhost:3000/creneau');
  }
}
