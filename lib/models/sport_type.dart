enum SportType {
  courseAPied,
  natation,
  cyclisme,
  tennis,
  football,
  basketball,
  musculation,
  yoga,
  marathon,
  triathlon,
  escalade,
  danse,
  boxe,
  rugby,
  juJitsu,
  mma,
  grappling,
  handball,
  autre,
  aucun;

  // Conversion de l'enum vers la chaîne stockée en BDD
  String toDbValue() {
    switch (this) {
      case SportType.courseAPied:
        return 'course à pied';
      case SportType.natation:
        return 'natation';
      case SportType.cyclisme:
        return 'cyclisme';
      case SportType.tennis:
        return 'tennis';
      case SportType.football:
        return 'football';
      case SportType.basketball:
        return 'basketball';
      case SportType.musculation:
        return 'musculation';
      case SportType.yoga:
        return 'yoga';
      case SportType.marathon:
        return 'marathon';
      case SportType.triathlon:
        return 'triathlon';
      case SportType.escalade:
        return 'escalade';
      case SportType.danse:
        return 'danse';
      case SportType.boxe:
        return 'boxe';
      case SportType.rugby:
        return 'rugby';
      case SportType.juJitsu:
        return 'ju-jitsu';
      case SportType.mma:
        return 'mma';
      case SportType.grappling:
        return 'grappling';
      case SportType.handball:
        return 'handball';
      case SportType.autre:
        return 'autre';
      case SportType.aucun:
        return 'aucun';
      default:
        throw ArgumentError('Sport type invalide: $this');
    }
  }

  // Conversion de la chaîne BDD vers l'enum
  static SportType fromDbValue(String value) {
    switch (value) {
      case 'course à pied':
        return SportType.courseAPied;
      case 'natation':
        return SportType.natation;
      case 'cyclisme':
        return SportType.cyclisme;
      case 'tennis':
        return SportType.tennis;
      case 'football':
        return SportType.football;
      case 'basketball':
        return SportType.basketball;
      case 'musculation':
        return SportType.musculation;
      case 'yoga':
        return SportType.yoga;
      case 'marathon':
        return SportType.marathon;
      case 'triathlon':
        return SportType.triathlon;
      case 'escalade':
        return SportType.escalade;
      case 'danse':
        return SportType.danse;
      case 'boxe':
        return SportType.boxe;
      case 'rugby':
        return SportType.rugby;
      case 'ju-jitsu':
        return SportType.juJitsu;
      case 'mma':
        return SportType.mma;
      case 'grappling':
        return SportType.grappling;
      case 'handball':
        return SportType.handball;
      case 'autre':
        return SportType.autre;
      case 'aucun':
        return SportType.aucun;
      default:
        throw ArgumentError('Sport type invalide: $value');
    }
  }
}
