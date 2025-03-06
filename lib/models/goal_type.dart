enum GoalType {
  perdrePoids,
  prendreMasse,
  recomposition,
  mangerSain,
  competition;

  // Conversion de l'enum vers la chaîne stockée en BDD
  String toDbValue() {
    switch (this) {
      case GoalType.perdrePoids:
        return 'Perdre du poids';
      case GoalType.prendreMasse:
        return 'Prendre de la masse';
      case GoalType.recomposition:
        return 'Gagner du muscle et perdre de la graisse';
      case GoalType.mangerSain:
        return 'Manger plus sainement';
      case GoalType.competition:
        return 'Préparer une compétition';
    }
  }

  // Conversion de la chaîne BDD vers l'enum
  static GoalType fromDbValue(String value) {
    switch (value) {
      case 'Perdre du poids':
        return GoalType.perdrePoids;
      case 'Prendre de la masse':
        return GoalType.prendreMasse;
      case 'Gagner du muscle et perdre de la graisse':
        return GoalType.recomposition;
      case 'Manger plus sainement':
        return GoalType.mangerSain;
      case 'Préparer une compétition':
        return GoalType.competition;
      default:
        throw ArgumentError('Type d\'objectif invalide: $value');
    }
  }
}
