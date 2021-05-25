import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_strings.dart';
import 'dimens.dart';

class Utils {
  static final Utils _utils = Utils._internal();

  factory Utils() {
    return _utils;
  }

  Utils._internal();

  static Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        return true;
      } else {
        debugPrint('not connected');
        return false;
      }
    } on SocketException catch (_) {
      debugPrint('SocketException not connected');
      return false;
    }
  }

  static showSnackBar(String message, BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      message: message,
      backgroundColor: AppColor.primary,
      flushbarStyle: FlushbarStyle.GROUNDED,
      duration: Duration(seconds: 3),
      messageText: Text(
        message,
        // textAlign: TextAlign.center,
        style: TextStyle(fontSize: Dimens.twenty, color: AppColor.white),
      ),
    )..show(context);
  }

  static bool checkNullOrEmpty(String value) {
    if (value == null || value.isEmpty) return true;
    return false;
  }

  static bool emailValidation(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  static commonProgressDialog(BuildContext context) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.1),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              content: Container(
                height: Dimens.forty,
                child: Row(
                  children: [
                    SizedBox(
                      height: Dimens.thirty,
                      width: Dimens.thirty,
                      child: CircularProgressIndicator(
                        strokeWidth: Dimens.two,
                        backgroundColor: AppColor.primaryDark,
                      ),
                    ),
                    SizedBox(
                      width: Dimens.ten,
                    ),
                    Text(
                      AppString.processing_data,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: Dimens.forteen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {},
    );
  }

  static commonErrorDialog({BuildContext context,String icon,String ti}) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.1),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              content: Container(
                height: Dimens.forty,
                child: Row(
                  children: [
                    SizedBox(
                      height: Dimens.thirty,
                      width: Dimens.thirty,
                      child: CircularProgressIndicator(
                        strokeWidth: Dimens.two,
                        backgroundColor: AppColor.primaryDark,
                      ),
                    ),
                    SizedBox(
                      width: Dimens.ten,
                    ),
                    Text(
                      AppString.processing_data,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: Dimens.forteen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {},
    );
  }

}
