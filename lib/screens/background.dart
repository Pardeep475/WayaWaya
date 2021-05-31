import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'home.dart';
import '../config.dart';
import 'login.dart';
import '../constants.dart';

class BackgroundScreen extends StatefulWidget {
  final bool showOnlyLocType;

  const BackgroundScreen({Key key, this.showOnlyLocType = false})
      : super(key: key);

  @override
  _BackgroundScreenState createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  String _callStatus = 'DENIED';
  String _locationStatus = 'DENIED';
  String _locTypeStatus = 'NOT SET';
  bool visible = true;
  BuildContext callContext;
  BuildContext locContext;

  _askLocAlways() async {
    await Future.delayed(Duration.zero, () => Navigator.of(context).pop())
        .whenComplete(() async {
      var status2 = await Permission.locationAlways.request();
      if (status2.isGranted) {
        print('Always');
        setState(() {
          _locTypeStatus = 'ALWAYS';
        });
      } else if (status2.isPermanentlyDenied) {
        print('Only while using');
        setState(() {
          _locTypeStatus = 'PERM IN USE';
        });
      } else {
        print('Only while using');
        setState(() {
          _locTypeStatus = 'IN USE';
        });
      }
      App.prefs.setString('locType', _locTypeStatus);
      App.prefs.setBool('bgScreen', true);
      printY(App.prefs.getBool('bgScreen').toString());
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Login()));
    });
  }

  _callPermissionDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext cont) {
          callContext = cont;
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: Container(
                height: 190,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'For Video Calling, please allow the app to Appear on Top so that incoming video calls can be prioritized.',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'You can also give the permission manually Tap (Settings > Apps > WayaWaya > Advanced > Draw over other apps)',
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'CLOSE',
                    style: TextStyle(
                      color: black,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () async {
                    await Future.delayed(
                            Duration.zero, () => Navigator.pop(callContext))
                        .whenComplete(() => Navigator.of(context).pop());
                    SystemNavigator.pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'ALLOW',
                    style: TextStyle(
                      color: black,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () async {
                    var status = await Permission.systemAlertWindow.request();
                    if (status.isGranted) {
                      setState(() {
                        _callStatus = 'GRANTED';
                      });
                      Navigator.of(context).pop();
                      _locationPermissionDialog();
                      printY('CALL GRANTED');
                    } else if (status.isDenied) {
                      setState(() {
                        _callStatus = 'DENIED';
                      });
                      Navigator.pop(context);
                      printR('DENIED');
                    }
                    App.prefs.setString('callAccess', _callStatus);
                  },
                ),
              ],
            ),
          );
        });
  }

  _locationPermissionDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext conx) {
          locContext = conx;
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      color: Color(0xff56A9D3),
                      size: 55,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        'Please allow us to Use your phone Background Location permission',
                        style: GoogleFonts.spartan().copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: black.withOpacity(0.97),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 6, right: 5),
                      child: Column(
                        children: [
                          Text(
                            'This app collects location data to enable Connect Waya-Waya® Rewards. Presence detection at our Shopping Malls even when the app is closed or not in use.',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            ' - We use your presence to our malls, to Welcome you and present you with our latest Rewards and other offerings.',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            ' - We usse your presence in Shops to award you points.',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Please visit the Rewards section for more details.',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Refere to our Privacy Policy for any concerns.',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'DON\'T ALLOW',
                    style: TextStyle(
                      color: black,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () async {
                    await Future.delayed(
                            Duration.zero, () => Navigator.pop(locContext))
                        .whenComplete(() => Navigator.of(context).pop());
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                        (route) => false);
                  },
                ),
                TextButton(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: black,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () async {
                    await Future.delayed(
                            Duration.zero, () => Navigator.of(context).pop())
                        .whenComplete(() async {
                      var status = await Permission.location.request();
                      if (status.isGranted) {
                        setState(() {
                          _locationStatus = 'GRANTED';
                        });
                        printY('LOC GRANTED');
                      } else if (status.isDenied) {
                        setState(() {
                          _locationStatus = 'DENIED';
                        });
                        printR('LOC DENIED');
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => Login()));
                      }
                      App.prefs.setString('locAccess', _locationStatus);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  _confirmLocAlways() async {
    Future.delayed(Duration.zero, () {
      Navigator.pop(callContext);
      Navigator.pop(locContext);
    }).whenComplete(() async {
      var status2 = await Permission.locationAlways.request();
      if (status2.isGranted) {
        print('Always');
        setState(() {
          _locTypeStatus = 'ALWAYS';
        });
      } else if (status2.isPermanentlyDenied) {
        print('Only while using');
        setState(() {
          _locTypeStatus = 'PERM IN USE';
        });
      } else {
        print('Only while using');
        setState(() {
          _locTypeStatus = 'IN USE';
        });
      }
      App.prefs.setString('locType', _locTypeStatus);
      App.prefs.setBool('bgScreen', true);
      printY(App.prefs.getBool('bgScreen').toString());
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.showOnlyLocType == false
        ? Future.delayed(Duration(milliseconds: 10), () {
            if (_callStatus == 'DENIED') {
              if (Platform.isIOS) {
                setState(() {
                  _callStatus = 'GRANTED';
                });
                App.prefs.setString('callAccess', _callStatus);
              } else
                _callPermissionDialog();
            } else {
              _locationStatus == 'DENIED'
                  ? _locationPermissionDialog()
                  : _locTypeStatus == 'NOT SET'
                      ? _askLocAlways()
                      : print('done');
            }
          })
        : _confirmLocAlways();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
      ),
    );
  }
}
