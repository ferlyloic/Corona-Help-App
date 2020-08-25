import 'package:geolocator/geolocator.dart';

class LocationInfo {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  String houseNumber = 'N/A';
  String street = 'N/A';
  String postalCode = 'N/A';
  String city = 'N/A';
  String country = 'N/A';

  LocationInfo();

  @override
  String toString() {
    String result = '';
    if (this.street != null) result += this.street + ' ';
    if (this.houseNumber != null) result += this.houseNumber + ', ';
    if (this.postalCode != null) result += this.postalCode + ' ';
    if (this.city != null) result += this.city + ', ';
    if (this.country != null) result += this.country;
    return result;
  }

  getCurrentLocation() async {
    Placemark p = await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((Position position) {
      _currentPosition = position;
      return _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
    return p;
  }

  Future<Placemark> _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      print(place.toJson());
      this.houseNumber = place.subThoroughfare;
      this.street = place.thoroughfare;
      this.postalCode = place.postalCode;
      this.city = place.locality;
      this.country = place.country;
      print(this);
      return p[0];
    } catch (e) {
      print(e);
      return null;
    }
  }

  Map<String, String> toJson() {
    return {
      'house_number': this.houseNumber,
      'street': this.street,
      'postal_code': this.postalCode,
      'city': this.city,
      'country': this.country,
    };
  }

  void fromJson(data) {
    this.houseNumber = data['house_number'];
    this.street = data['street'];
    this.postalCode = data['postal_code'];
    this.city = data['city'];
    this.country = data['country'];
  }
}
