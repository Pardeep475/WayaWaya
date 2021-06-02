import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';

class CustomRaiseButton extends StatelessWidget {
  CustomRaiseButton(
      {this.backgroundColor,
      this.title,
      this.borderRadius,
      this.onPressed,
      this.width});

  final Color backgroundColor;
  final String title;
  final double borderRadius;
  final double width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: RaisedButton(
        elevation: Dimens.one,
        padding: EdgeInsets.only(top: Dimens.twenty, bottom: Dimens.seventeen),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        child: textWidget(),
        color: backgroundColor,
        focusColor: backgroundColor,
        disabledColor: backgroundColor,
        onPressed: onPressed,
      ),
    );
  }

  Widget textWidget() {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Dimens.sixteen,
          letterSpacing: 1.5,
          // fontFamily: AppString.font_family_Roboto,
          color: AppColor.secondaryBlack),
    );
  }
}
