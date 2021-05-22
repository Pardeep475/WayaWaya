import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wayawaya/config.dart';
import 'package:wayawaya/providers/auth.dart';
import 'package:wayawaya/screens/my_account.dart';
import 'package:wayawaya/screens/my_device.dart';
import 'package:wayawaya/screens/rewards/menu.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import 'package:wayawaya/screens/select_preferences.dart';
import 'package:wayawaya/screens/shops_rest_fav.dart';
import '../constants.dart';
import 'login.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _tnc = false;
  bool privacyPolicy = false;

  tncDialog() {
    bool tnc;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: Text('Terms and Conditions'),
        insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 70),
        content: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Terms and Conditions: Free WI-FI Service'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),
                Container(
                  height: 270,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'INTRODUCTION',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Text(
                  '1.1    Vulkile Property Fund Limited(herein reffered to as "Vulkile") is the registered owner of various shopping centers within South Africa.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'DISAGREE',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              setState(() {
                tnc = false;
              });
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'AGREE',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              setState(() {
                tnc = true;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ).then((value) {
      if (tnc)
        print('I AM TRUE');
      else
        print('I AM FALSE');
    });
  }

  privacyDialog() {
    Color _dark = Color(0xffC3C0D3);
    Color _light = Color(0xffDEDCE7);
    Color _text = Color(0xff585185);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: Text('Privacy Policy'),
        insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        contentPadding: EdgeInsets.zero,
        content: Container(
          margin: EdgeInsets.only(top: 2),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 130,
                  color: _dark,
                  padding: EdgeInsets.only(left: 45),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/yellow_fist_bump.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Container(
                  color: _light,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VULKILE PRIVACY NOTICE: FREE WI-FI AND SHOPPING APP SERVICE',
                        style: TextStyle(
                          color: _text,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'I. INTRODUCTION',
                        style: TextStyle(
                          color: _text,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'When you use our Connect Waya-Waya® mobile application, you trust us with your personal data. We\'re committed to keeping that trust. That starts with helping you understand our privacy practices.',
                        style: TextStyle(
                          color: _text,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'This notice describes the personal data we collect, how it\'s used and shared, and your choices regarding this data.',
                        style: TextStyle(
                          color: _text,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'II. OVERVIEW',
                        style: TextStyle(
                          color: _text,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'DISAGREE',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              setState(() {
                privacyPolicy = false;
              });
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'AGREE',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              setState(() {
                privacyPolicy = true;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget customCard(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Card(
        elevation: 1.3,
        shadowColor: Colors.grey[300],
        child: Container(
          height: 50,
          width: App.width(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                index == 0
                    ? FontAwesomeIcons.user
                    : index == 1
                        ? FontAwesomeIcons.slidersH
                        : index == 2
                            ? Icons.phone_android
                            : index == 3
                                ? Icons.thumb_up
                                : null,
                size: 16,
                color: Colors.grey[800],
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                index == 0
                    ? 'My Account'
                    : index == 1
                        ? 'Preferences'
                        : index == 2
                            ? 'My Devices'
                            : index == 3
                                ? 'My Favourites'
                                : index == 4
                                    ? 'Privacy Policy'
                                    : 'Terms and Conditions',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[500],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: MenuNew(
          title: 'SETTINGS',
          physics: NeverScrollableScrollPhysics(),
          children: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0)
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => MyAccount()));
                      else if (index == 1)
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => Preferences()));
                      else if (index == 2)
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => MyDevice()));
                      else if (index == 3)
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => ShopRestFav()));
                      else if (index == 4)
                        privacyDialog();
                      else
                        tncDialog();
                    },
                    child: customCard(index),
                  );
                },
                childCount: 6,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.bottomCenter,
          color: bgColor,
          height: 100,
          margin: EdgeInsets.only(bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'App version - v1.1.24',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              InkWell(
                onTap: () {
                  user.logout();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => Login()),
                      (route) => false);
                },
                child: Container(
                  color: white,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.login_outlined,
                        color: Colors.grey[700],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'LOGOUT',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
