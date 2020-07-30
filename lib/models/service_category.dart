class ServiceCategory {
  final String name;
  final String description;
  static List<ServiceCategory> _categoryList = [
    ServiceCategory('Test 01'),
    ServiceCategory('Test 02'),
    ServiceCategory('Test 03'),
    ServiceCategory('Test 04'),
    ServiceCategory('Test 05'),
  ];

  ServiceCategory(this.name, {this.description = ''});
  static all(){
    return _categoryList;
  }
}
