/*@JS('navigator.geolocation') // navigator.geolocation namespace
library jslocation; // library name can be whatever you want

import 'package:geolocator/geolocator.dart';
import "package:js/js.dart";

@JS('getCurrentPosition') // Accessing method getCurrentPosition from       Geolocation API
external void getCurrentPositionWeb(Function success(GeolocationPosition pos));

@JS()
@anonymous
class GeolocationCoordinates {
  external double get latitude;
  external double get longitude;
  external double get altitude;
  external double get accuracy;
  external double get altitudeAccuracy;
  external double get heading;
  external double get speed;

  external factory GeolocationCoordinates(
      {double latitude,
        double longitude,
        double altitude,
        double accuracy,
        double altitudeAccuracy,
        double heading,
        double speed});
}

@JS()
@anonymous
class GeolocationPosition {
  external GeolocationCoordinates get coords;

  external factory GeolocationPosition({GeolocationCoordinates coords});

  Position mapToPosition() {
    return new Position(longitude: coords.longitude, latitude: coords.latitude);
  }
}*/