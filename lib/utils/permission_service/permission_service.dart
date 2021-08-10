import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final PermissionService _appColor = PermissionService._internal();

  factory PermissionService() {
    return _appColor;
  }

  PermissionService._internal();

  static Future<bool> checkSystemOverlayPermission() async {
    return await Permission.systemAlertWindow.status.isGranted;
  }

  static Future<bool> checkLocationPermission() async {
    return await Permission.locationAlways.status.isGranted;
  }


  static Future<bool> requestSystemOverLayPermission() async {
    PermissionStatus status = await Permission.systemAlertWindow.request();
    return status.isGranted;
  }

  static Future<bool> requestLocationPermission() async {
    var status = await Permission.locationAlways.request();
    if (status.isGranted) {
      return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      // openAppSettings();
    } else if (status.isRestricted) {
      // openAppSettings();
    } else {
      // await requestLocationPermission();
    }
    return true;
  }
}
