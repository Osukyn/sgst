import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable, Observer} from "rxjs";
import {Arme} from "../models/Arme";
import {Creneau} from "../models/Creneau";

@Injectable({
  providedIn: 'root'
})
export class ArmeService {

  constructor(private httpClient: HttpClient) { }

  getArmes(): Observable<Arme[]> {
    return this.httpClient.get<Arme[]>('http://localhost:3000/arme');
  }
}
