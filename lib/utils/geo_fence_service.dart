import 'package:flutter_geofence/geofence.dart';
import 'package:wayawaya/network/local/notification_service.dart';

class GeoFenceService {
  static final GeoFenceService _geoFenceService = GeoFenceService._internal();

  factory GeoFenceService() {
    return _geoFenceService;
  }

  GeoFenceService._internal();

  static requestPermission() {
    Geofence.requestPermissions();
  }

  static initGeofence(){
    Geofence.initialize();
  }

  static getCurrentLocation() {
    Geofence.getCurrentLocation().then((coordinate) {
      print(
          "Your latitude is ${coordinate.latitude} and longitude ${coordinate.longitude}");
      NotificationService.showSimpleNotification(
          "Your latitude is ${coordinate.latitude} and longitude ${coordinate.longitude}");
    });
  }

  static startListeningForLocationChanges() {
    Geofence.startListeningForLocationChanges();
  }

  static listenBackgroundLocation() {
    Geofence.backgroundLocationUpdated.stream.listen((event) {
      print(
          "Your latitude is ${event.latitude} and longitude ${event.longitude}");
      NotificationService.showSimpleNotification(
          "Your latitude is ${event.latitude} and longitude ${event.longitude}");
    }).onError((handleError) {
      NotificationService.showSimpleNotification(handleError.toString());
    });
  }
}
