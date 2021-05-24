import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';

import '../../../network/local/database_helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openFurtherScreen();
    });
  }
  //
  // Future _initImages() async {
  //   SuperAdminDatabaseHelper _superAdminDatabaseHelper =
  //       SuperAdminDatabaseHelper();
  //   await _superAdminDatabaseHelper.initDataBase();
  //   // await _superAdminDatabaseHelper.getVenueProfile();
  // }

  _openFurtherScreen() async {
    // bool isFirstTime = await SessionManager.isFirstTime();
    // if (!isFirstTime) {
    //   // open mall screen
    //   SessionManager.setFirstTime(true);
    //   Navigator.pushNamed(context, AppString.MALL_SCREEN_ROUTE);
    // } else {
    //   // open login screen
    //   Navigator.pushNamed(context, AppString.LOGIN_SCREEN_ROUTE);
    // }

    Navigator.pushNamed(context, AppString.MALL_SCREEN_ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: const DecorationImage(
            image: const AssetImage(
              'assets/app_splashscreen.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
