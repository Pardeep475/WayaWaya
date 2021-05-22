import 'package:flutter/material.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _openFurtherScreen();
  }

  _openFurtherScreen() async {
    bool isFirstTime = await SessionManager.isFirstTime();
    if (!isFirstTime) {
      // open mall screen
      SessionManager.setFirstTime(true);
      Navigator.pushNamed(context, AppString.MALL_SCREEN_ROUTE);
    } else {
      // open login screen
      Navigator.pushNamed(context, AppString.LOGIN_SCREEN_ROUTE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/app_splashscreen.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
