import 'package:flutter/material.dart';
import '../constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  loadingDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          Future.delayed(Duration(milliseconds: 300), () {
            Navigator.of(context).pop(true);
          }).whenComplete(() => successDialog());
          return AlertDialog(
            content: Container(
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      backgroundColor: appDarkColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Processing data...',
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

  successDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text('Success'),
            content: Container(
              child: Text(
                'Verification email has been sent to registered email address',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  height: 1.2,
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
                  passResetDialog();
                },
              ),
            ],
          );
        });
  }

  passResetDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            title: Text('Password Reset'),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
                      autofocus: false,
                      controller: _codeController,
                      decoration: InputDecoration(
                        hintText: 'Authentication Code',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
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
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey2,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                              autofocus: false,
                              controller: _passController,
                              obscureText: true,
                              validator: (value) =>
                              (value.isEmpty) ? "Enter the password" : null,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
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
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                              autofocus: false,
                              controller: _confirmPassController,
                              obscureText: true,
                              validator: (value) =>
                              (value.isEmpty) ? "Enter the password" : null,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
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
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Row(
                              children: [
                                TextButton(
                                  child: Text(
                                    'REQUEST CODE',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'CANCEL',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
                                  onPressed: () {
                                    if(_formKey2.currentState.validate()) {
                                      Navigator.of(context).pop();
                                      loadingDialog();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
            fontWeight: FontWeight.w400,
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
              color: Colors.grey[300],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 4),
                  child: Text(
                    'Enter your email, phone number or username.',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                    ),
                  ),
                ),
                emailField,
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        loadingDialog();
                      }
                    },
                    child: Card(
                      shadowColor: Colors.grey[400],
                      elevation: 1.3,
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Card(
                      shadowColor: Colors.grey[400],
                      elevation: 1.3,
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
