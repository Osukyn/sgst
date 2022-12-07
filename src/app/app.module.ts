import {
  TuiButtonModule,
  TuiFormatNumberPipeModule, TuiLinkModule, TuiLoaderModule,
  TuiModeModule,
  TuiRootModule,
  TuiThemeNightModule
} from "@taiga-ui/core";
import { BrowserAnimationsModule } from "@angular/platform-browser/animations";
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import {RouterModule, Routes} from "@angular/router";
import { MenuComponent } from './menu/menu.component';
import { ReservationTableComponent } from './reservation-table/reservation-table.component';
import {TuiCheckboxModule, TuiTagModule} from "@taiga-ui/kit";
import {ReactiveFormsModule} from "@angular/forms";
import {TuiTableModule} from "@taiga-ui/addon-table";
import {TuiLetModule} from "@taiga-ui/cdk";
import { ReservationsPageComponent } from './reservations-page/reservations-page.component';

const appRoutes: Routes = [
  { path: 'reservations', component: ReservationsPageComponent },
  { path: '**', redirectTo: 'reservations'}
];

@NgModule({
  declarations: [
    AppComponent,
    MenuComponent,
    ReservationTableComponent,
    ReservationsPageComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    TuiRootModule,
    TuiThemeNightModule,
    TuiModeModule,
    RouterModule.forRoot(appRoutes),
    TuiCheckboxModule,
    ReactiveFormsModule,
    TuiTableModule,
    TuiFormatNumberPipeModule,
    TuiButtonModule,
    TuiTagModule,
    TuiLetModule,
    TuiLinkModule,
    TuiLoaderModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
