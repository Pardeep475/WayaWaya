import 'package:flutter/material.dart';
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

  static initGeofence() {
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

  static addLatLongToGeofence() {
    Geolocation geolocation = Geolocation(
        latitude: 29.548076,
        longitude: 76.910275,
        radius: 1500,
        id: "GeoLocationAdded");
    Geofence.addGeolocation(geolocation, GeolocationEvent.entry)
        .then((onValue) {
      debugPrint("Georegion added Your geofence has been added!");
      NotificationService.showSimpleNotification(
          "Georegion added Your geofence has been added!");
    }).catchError((error) {
      print("failed with $error");
    });
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

  static removeLatLongToGeoFence() {
    Geolocation geolocation = Geolocation(
        latitude: 29.548076,
        longitude: 76.910275,
        radius: 1500,
        id: "GeoLocationAdded");
    Geofence.removeGeolocation(geolocation, GeolocationEvent.entry)
        .then((onValue) {
      debugPrint("Georegion removed Your geofence has been removed!");
      NotificationService.showSimpleNotification(
          "Georegion removed Your geofence has been removed!");
    }).catchError((error) {
      print("failed with $error");
    });
  }
}
