import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
      // print("WidgetsBinding");
      _openFurtherScreen();
    });

    // _initImages().then((value) {
    //   _openFurtherScreen();
    // });
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('database/'))
        .where((String key) => key.contains('.db'))
        .toList();

    imagePaths.forEach((element) async {
      debugPrint('pardeep_testing_database :--- Database   Name     $element');
      final DataBaseHelper _database = DataBaseHelper.instance;
      await _database.initiateDataBase(dbName: element);
      await _database.queryVenueProfileItem(element);
      await _database.closeDataBase();
    });
  }

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

    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.pushNamed(context, AppString.LOGIN_SCREEN_ROUTE);
    });
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
