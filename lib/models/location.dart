
class Location {
  String houseNumber = 'N/A';
  String street = 'N/A';
  String zip  = 'N/A';
  String city = 'N/A';
  String country  = 'N/A';
  Location();
  @override
  String toString() {
    String result = '';
    if(this.street != null) result += this.street + ' ';
    if(this.houseNumber != null) result += this.houseNumber + ', ';
    if(this.zip != null) result += this.zip + ' ';
    if(this.city != null) result += this.city + ', ';
    if(this.country != null) result += this.country;
    return result;
  }

}