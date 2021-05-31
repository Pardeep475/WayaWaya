import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants.dart';
import 'home.dart';
import '../user_prefs.dart';
import '../config.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String _locTypeStatus;
  Map<String, dynamic> accessData;

  _confirmLocAlways() async {
    printR('I am asking for permission again');
    var status2 = await Permission.locationAlways.request();
    if (status2.isGranted) {
      print('Always');
      setState(() {
        _locTypeStatus = 'ALWAYS';
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Login()));
    } else if (status2.isPermanentlyDenied) {
      print('Only while using');
      setState(() {
        _locTypeStatus = 'PERM IN USE';
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Login()));
    } else {
      print('Only while using');
      setState(() {
        _locTypeStatus = 'IN USE';
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Login()));
    }
    App.prefs.setString('locType', _locTypeStatus);
  }

  getPrefs() {
    accessData = Map<String, dynamic>.from(UserPreferences().getAccessDetails());
    return accessData;
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
    if(accessData['locType'] == 'NOT SET') _confirmLocAlways();
    Timer(new Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    });
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
