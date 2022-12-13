import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Pas} from "../models/Pas";

@Injectable({
  providedIn: 'root'
})
export class PasService {

  constructor(private httpClient: HttpClient) { }

  getPas(): Observable<Pas[]> {
    return this.httpClient.get<Pas[]>('http://localhost:3000/pas');
  }
}
