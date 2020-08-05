
import 'package:geolocator/geolocator.dart';

class Location {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;


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
  getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      print(place.toJson());
      this.houseNumber = place.subThoroughfare;
      this.houseNumber = place.thoroughfare;
      this.zip = place.postalCode;
      this.city = place.locality;
      this.country = place.country;
    } catch (e) {
      print(e);
    }
  }
}