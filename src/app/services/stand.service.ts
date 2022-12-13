import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Stand} from "../models/Stand";

@Injectable({
  providedIn: 'root'
})
export class StandService {

  constructor(private httpClient: HttpClient) { }

  getStands(): Observable<Stand[]> {
    return this.httpClient.get<Stand[]>("http://localhost:3000/stand");
  }
}
