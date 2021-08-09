import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';

// ignore: must_be_immutable
class CommonNoAtVenueDialog extends StatelessWidget {
  final Function onPressed;

  CommonNoAtVenueDialog({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Error',
        textAlign: TextAlign.center,
      ),
      content: Container(
        child: Text(
          Platform.isAndroid
              ? AppString.not_at_venue_msg_android
              : AppString.not_at_venue_msg_ios,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(child: SizedBox()),
            TextButton(
              child: Text(
                AppString.ok.toUpperCase(),
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                onPressed();
              },
            ),
          ],
        ),
      ],
    );
  }
}
