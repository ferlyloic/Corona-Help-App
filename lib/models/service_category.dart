class ServiceCategory {
  final String name;
  final String description;
  static List<ServiceCategory> _categoryList = [
    ServiceCategory('Kranken- und Altenbesuch'),
    ServiceCategory('Unterstützung beim Einkauf'),
    ServiceCategory('Begleitung zu Bank, Arzt, Behörden'),
    ServiceCategory('Hilfe bei Telefonaten'),
    ServiceCategory('Vorlesen / Gespräche / Zuhören'),
    ServiceCategory('Kleinere Reparaturen im Haushalt'),
    ServiceCategory('Spaziergänge / Ausflüge'),
    ServiceCategory('Kurzfristige Kinderbetreuung'),
    ServiceCategory('Hilfe beim Ausfüllen von Formularen'),
    ServiceCategory('Begleitung zu einem Gottesdienst'),
  ];

  ServiceCategory(this.name, {this.description = ''});
  static all(){
    return _categoryList;
  }
}
