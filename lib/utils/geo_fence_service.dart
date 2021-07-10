import 'package:flutter_geofence/geofence.dart';

class GeoFenceService {
  static requestPermission() {
    Geofence.requestPermissions();
  }

  static getCurrentLocation() {
    Geofence.getCurrentLocation().then((coordinate) {
      print(
          "Your latitude is ${coordinate.latitude} and longitude ${coordinate.longitude}");
    });
  }

  static startListeningForLocationChanges(){
    Geofence.startListeningForLocationChanges();
  }

  static listenBackgroundLocation() {
    Geofence.backgroundLocationUpdated.stream.listen((event) {
      print(
          "Your latitude is ${event.latitude} and longitude ${event.longitude}");
    });
  }
}
