import 'package:flutter/material.dart';
import '../constants.dart';

Widget customText({String text, BuildContext context, Function onTap}) {
  return Padding(
    padding: EdgeInsets.only(top: 8),
    child: InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: appLightColor,
        ),
      ),
    ),
  );
}