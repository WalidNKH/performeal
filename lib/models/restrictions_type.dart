enum RestrictionsType {
  vegetarien,
  vegetalien,
  sansGluten,
  sansSucre,
  halal,
  aucune;

  // Conversion de l'enum vers la chaîne stockée en BDD
  String toDbValue() {
    switch (this) {
      case RestrictionsType.vegetarien:
        return 'Végétarien';
      case RestrictionsType.vegetalien:
        return 'Végétalien';
      case RestrictionsType.sansGluten:
        return 'Sans gluten';
      case RestrictionsType.sansSucre:
        return 'Sans sucre';
      case RestrictionsType.halal:
        return 'Halal';
      case RestrictionsType.aucune:
        return 'Aucune';
    }
  }

  // Conversion de la chaîne BDD vers l'enum
  static RestrictionsType fromDbValue(String value) {
    switch (value) {
      case 'Végétarien':
        return RestrictionsType.vegetarien;
      case 'Végétalien':
        return RestrictionsType.vegetalien;
      case 'Sans gluten':
        return RestrictionsType.sansGluten;
      case 'Sans sucre':
        return RestrictionsType.sansSucre;
      case 'Halal':
        return RestrictionsType.halal;
      case 'Aucune':
        return RestrictionsType.aucune;
      default:
        throw ArgumentError('Type de restriction invalide: $value');
    }
  }

  // Méthode pour obtenir la description de la restriction
  String getDescription() {
    switch (this) {
      case RestrictionsType.vegetarien:
        return 'Pas de viande ni de poisson';
      case RestrictionsType.vegetalien:
        return 'Aucun produit d\'origine animale';
      case RestrictionsType.sansGluten:
        return 'Exclusion de tout aliment contenant du gluten';
      case RestrictionsType.sansSucre:
        return 'Limitation des sucres ajoutés';
      case RestrictionsType.halal:
        return 'Alimentation conforme aux préceptes islamiques';
      case RestrictionsType.aucune:
        return 'Aucune restriction';
    }
  }
}
