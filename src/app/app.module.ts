import {
  TuiButtonModule, TuiDataListModule,
  TuiFormatNumberPipeModule, TuiLinkModule, TuiLoaderModule,
  TuiModeModule,
  TuiRootModule, TuiTextfieldControllerModule,
  TuiThemeNightModule
} from "@taiga-ui/core";
import { BrowserAnimationsModule } from "@angular/platform-browser/animations";
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import {RouterModule, Routes} from "@angular/router";
import { MenuComponent } from './menu/menu.component';
import { ReservationTableComponent } from './reservation-table/reservation-table.component';
import {
    TuiCheckboxModule, TuiComboBoxModule,
    TuiDataListWrapperModule, TuiInputDateModule,
    TuiInputModule, TuiInputNumberModule, TuiInputTimeModule,
    TuiSelectModule,
    TuiTagModule
} from "@taiga-ui/kit";
import {ReactiveFormsModule} from "@angular/forms";
import {TuiTableModule} from "@taiga-ui/addon-table";
import {TuiLetModule} from "@taiga-ui/cdk";
import { ReservationsPageComponent } from './reservations-page/reservations-page.component';
import { AddReservationComponent } from './add-reservation/add-reservation.component';
import {of} from "rxjs";
import {TUI_FRENCH_LANGUAGE, TUI_LANGUAGE} from "@taiga-ui/i18n";
import {HttpClientModule} from "@angular/common/http";

const appRoutes: Routes = [
  { path: 'reservations', component: ReservationsPageComponent },
  { path: 'nouvelle-reservation', component: AddReservationComponent},
  { path: '**', redirectTo: 'reservations'}
];

@NgModule({
  declarations: [
    AppComponent,
    MenuComponent,
    ReservationTableComponent,
    ReservationsPageComponent,
    AddReservationComponent
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
        TuiLoaderModule,
        TuiSelectModule,
        TuiDataListModule,
        TuiInputModule,
        TuiTextfieldControllerModule,
        TuiDataListWrapperModule,
        TuiComboBoxModule,
        HttpClientModule,
        TuiInputDateModule,
        TuiInputTimeModule,
        TuiInputNumberModule
    ],
  providers: [
    {
      provide: TUI_LANGUAGE,
      useValue: of(TUI_FRENCH_LANGUAGE),
    },
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
