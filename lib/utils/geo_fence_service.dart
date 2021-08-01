import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wayawaya/network/local/notification_service.dart';
import 'package:wayawaya/utils/permission_service/permission_service.dart';

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

  static locationStream() async {
    bool status = await PermissionService.checkLocationPermission();
    if (status) {
      getCurrentLocation();
    } else {
      bool statusLocation = await PermissionService.requestLocationPermission();
      if (statusLocation) {
        getCurrentLocation();
      }
    }
  }

  static getCurrentLocation() async {
    Geolocator.getPositionStream().listen((Position position) {
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
    });

    // Geofence.getCurrentLocation().then((coordinate) {
    //   print(
    //       "Your latitude is ${coordinate.latitude} and longitude ${coordinate.longitude}");
    //   NotificationService.showSimpleNotification(
    //       "Your latitude is ${coordinate.latitude} and longitude ${coordinate.longitude}");
    // }).catchError((onError) {
    //   debugPrint('current_location_error:-   $onError');
    // }).onError((error, stackTrace) {
    //   debugPrint('current_location_error:-   $error');
    // });
  }

  static startListeningForLocationChanges() {
    Geofence.startListeningForLocationChanges();
  }

  static addLatLongToGeofence() async {
    bool status = await PermissionService.checkLocationPermission();
    if (status) {
      addLocationToGeofence();
    } else {
      bool statusLocation = await PermissionService.requestLocationPermission();
      if (statusLocation) {
        addLocationToGeofence();
      }
    }
  }

  static addLocationToGeofence() {
    Geolocation geolocation = Geolocation(
        latitude: 29.5398,
        longitude: 76.9731,
        radius: 1500,
        id: "GeoLocationAdded");
    Geofence.addGeolocation(geolocation, GeolocationEvent.entry)
        .then((onValue) {
      debugPrint("Georegion added Your geofence has been added!");
      NotificationService.showSimpleNotification(
          "Georegion added Your geofence has been added!");
      startListeningForLocationChanges();
      listenForGroundLocation();
      listenBackgroundLocation();
    }).catchError((error) {
      print("failed with $error");
    });
  }

  static listenForGroundLocation() {
    Geofence.startListening(GeolocationEvent.entry, (entry) {
      debugPrint("Entry of a georegion Welcome to: ${entry.id}");
      NotificationService.showSimpleNotification(
          "Entry of a georegion Welcome to: ${entry.id}");
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
        latitude: 29.5398,
        longitude: 76.9731,
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
