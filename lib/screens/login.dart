import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'select_preferences.dart';
import '../constants.dart';
import '../providers/auth.dart';
import 'forgot_pass.dart';
import 'home.dart';
import 'register.dart';
import '../config.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget forgotLabel() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: InkWell(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ForgotPassword())),
              child: Text(
                "Forgot password?",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: appLightColor,
                ),
              ),
            ),
          ),
        ],
      );

  Widget createAccLabel() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 8, top: 7),
            child: InkWell(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Register())),
              child: Text(
                "No account yet? Create one",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: appLightColor,
                ),
              ),
            ),
          ),
        ],
      );

  errorDialog() {
    printR('HELLO');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Container(
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.exclamationCircle,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Sorry'),
            ],
          ),
        ),
        content: Container(
          child: Text(
            'Invalid Credentials. Check username and password.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  authDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            content: Container(
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Signing in.....',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context, listen: true);

    final emailField = Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        autofocus: false,
        controller: _emailController,
        validator: (value) =>
            (value.isEmpty) ? "Enter valid email address" : null,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.only(left: 8, top: 17, bottom: 0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: appLightColor,
              width: 2.0,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );

    final passwordField = Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        controller: _passwordController,
        validator: (value) => value.isEmpty ? "Enter valid password" : null,
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.only(left: 8, top: 17, bottom: 0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: appLightColor,
              width: 2.0,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        height: App.height(context) / 1.95,
                        child: Image.asset('assets/dobsonville.png'),
                      ),
                      emailField,
                      SizedBox(
                        height: 20,
                      ),
                      passwordField,
                      SizedBox(
                        height: 110,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              printY(user.loggedInStatus.toString());
                              user
                                  .login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              )
                                  .then((val) async {
                                bool check = await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) {
                                      Future.delayed(Duration(seconds: 1), () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return AlertDialog(
                                        content: Container(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Signing in.....',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                if (check) {
                                  switch (val) {
                                    case Status.Authenticating:
                                      return authDialog();
                                    case Status.LoggedIn:
                                      return App.prefs.setBool('homeGestures', true).whenComplete(() => App.pushTo(
                                        context: context, screen: HomeScreen(),
                                      ));

                                    case Status.NotLoggedIn:
                                      return errorDialog();
                                    // ignore: unnecessary_statements
                                    default:
                                      null;
                                  }
                                }
                              });
                              printR(user.loggedInStatus.toString());
                              App.prefs.setBool('login', true);
                            }
                          },
                          child: Card(
                            shadowColor: Colors.grey[200],
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'LOGIN',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      forgotLabel(),
                      createAccLabel(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Preferences())),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        color: appLightColor,
                        fontSize: 16,
                      ),
                    ),
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
