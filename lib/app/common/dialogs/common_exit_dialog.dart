import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';

// ignore: must_be_immutable
class CommonExitDialog extends StatelessWidget {
  final Function(bool) onPressed;

  CommonExitDialog({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(''),
      content: Container(
        child: Text(
          AppString.exit_content,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            TextButton(
              child: Text(
                AppString.cancel.toUpperCase(),
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                onPressed(false);
              },
            ),
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
                onPressed(true);
              },
            ),
          ],
        ),
      ],
    );
  }
}
