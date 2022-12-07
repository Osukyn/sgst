export class Personne {
  constructor(readonly prenom: string, readonly nom: string, readonly email: string) {
  }

  toString(): string {
    return `${this.nom} ${this.prenom} ${this.email}`
  }
}

export class Licencie extends Personne {
  constructor(readonly numLicencie: number, override readonly prenom: string, override readonly nom: string, override readonly email: string) {
    super(prenom, nom, email);
  }
}
