import 'package:flutter/material.dart';

import '../constants.dart';

Widget customTextField({
  TextEditingController controller,
  TextInputType keyboard,
  Function validator,
  Function onTap,
  bool autoValidate,
  bool showHint = true,
  bool showLabel = false,
  bool obscure,
  String hint,
  }) {

  double labelSize = 16;
  double hintSize = 15;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: TextFormField(
      autofocus: false,
      style: TextStyle(
        fontSize: 14,
      ),
      controller: controller,
      //autovalidate: autoValidate ?? false,
      validator: validator ?? null,
      obscureText: obscure ?? false,
      onTap: () => onTap(),
      onEditingComplete: () => labelSize = 14,
      keyboardType: keyboard ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: showHint == true ? hint : null,
        labelText: showLabel == true ? hint : null,
        alignLabelWithHint: true,
        hintStyle: TextStyle(
          fontSize: showHint == true ? hintSize : labelSize,
          color: hintColor,
          fontWeight: FontWeight.w600,
        ),
        errorStyle: TextStyle(
          fontSize: 11,
        ),
        // labelStyle: TextStyle(
        //   fontSize: showHint == true ? hintSize : labelSize,
        //   color: hintColor,
        //   fontWeight: FontWeight.w600,
        // ),
        contentPadding: EdgeInsets.only(left: 8, top: 17, bottom: 8),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: appLightColor,
            width: 2.0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[350],
          ),
        ),
      ),
    ),
  );
}
