import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wayawaya/app/common/full_screen_call_permission_dialog.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/network/local/sync_service.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/permission_service/permission_service.dart';
import 'package:wayawaya/utils/session_manager.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkLocationPermission();
    });
  }

  // checkingSystemOverLayPermissions() async {
  //   if (Platform.isIOS) {
  //     await _fetchDataFromDataBase();
  //   } else {
  //     bool statusSystem =
  //         await PermissionService.checkSystemOverlayPermission();
  //     if (statusSystem) {
  //       await _checkLocationPermission();
  //     } else {
  //       Navigator.push(context, FullScreenCallDialogPermission())
  //           .then((value) async {
  //         if (value != null) {
  //           if (value) {
  //             await _checkLocationPermission();
  //           } else {
  //             SystemNavigator.pop();
  //           }
  //         } else {
  //           SystemNavigator.pop();
  //         }
  //       });
  //     }
  //   }
  // }

  _checkLocationPermission() async {
    bool status = await PermissionService.checkLocationPermission();
    if (status) {
      await _fetchDataFromDataBase();
    } else {
      bool locationPermissionStatus =
          await PermissionService.requestLocationPermission();
      if (locationPermissionStatus) {
        await _fetchDataFromDataBase();
      } else {
        SystemNavigator.pop();
      }
    }
  }

  _fetchDataFromDataBase() async {
    try {
      String defaultMall = await SessionManager.getDefaultMall();
      if (defaultMall == null || defaultMall.isEmpty) {
        List<MallProfileModel> _mallList =
            await SuperAdminDatabaseHelper.getDefaultVenueProfile(defaultMall);
        debugPrint('database_testing:-   ${_mallList.length}');
        if (_mallList.length > 0) {
          SessionManager.setDefaultMall(_mallList[0].identifier);
          SessionManager.setAuthHeader(_mallList[0].key);
          SessionManager.setSmallDefaultMallData(_mallList[0].venue_data);
        }
      }
      await ProfileDatabaseHelper.initDataBase(defaultMall);
      await SyncService.fetchAllSyncData();
    } catch (e) {
      debugPrint('splash_database_error:-    $e');
    } finally {
      Future.delayed(Duration(seconds: 3), () {
        _openFurtherScreen();
      });
    }
  }

  _openFurtherScreen() async {
    bool isFirstTime = await SessionManager.getISLoginScreenVisible();
    debugPrint('isFirstTimeSplash:-   $isFirstTime');
    if (!isFirstTime) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppString.LOGIN_SCREEN_ROUTE, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, AppString.HOME_SCREEN_ROUTE, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: const DecorationImage(
              image: const AssetImage(
                AppImages.app_splashscreen,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
