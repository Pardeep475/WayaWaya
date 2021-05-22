import 'package:flutter/material.dart';

const Color appLightColor = Color(0xff6CD1D9);
const Color appDarkColor = Color(0xff397C85);
Color bgColor = Colors.grey[100];
const Color white = Colors.white;
const Color hintColor = Color(0xff939393);
const Color black = Colors.black;

void printY(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printR(String text) {
  print('\x1B[31m$text\x1B[0m');
}
