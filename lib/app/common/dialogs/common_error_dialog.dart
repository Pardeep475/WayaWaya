import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/utils/app_color.dart';

// ignore: must_be_immutable
class CommonErrorDialog extends StatelessWidget {
  Icon icon;
  String title;
  String content;
  String buttonText;
  VoidCallback onPressed;

  CommonErrorDialog(
      {this.icon, this.title, this.content, this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 10,
            ),
            Text(title ?? ""),
          ],
        ),
      ),
      content: Container(
        child: Text(
          content,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            buttonText,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 15,
            ),
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
