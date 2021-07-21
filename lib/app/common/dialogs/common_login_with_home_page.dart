import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';

// ignore: must_be_immutable
class CommonLoginWithHomePageDialog extends StatelessWidget {
  Icon icon;
  String title;
  String content;

  CommonLoginWithHomePageDialog({this.icon, this.title, this.content});

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text(
                AppString.home_page,
                style: const TextStyle(
                  color: AppColor.black,
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, AppString.HOME_SCREEN_ROUTE, (route) => false);
              },
            ),
            TextButton(
              child: const Text(
                AppString.sign_up,
                style: const TextStyle(
                  color: AppColor.black,
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, AppString.SIGN_UP_SCREEN_ROUTE);
              },
            ),
            TextButton(
              child: Text(
                AppString.login.toUpperCase(),
                style: const TextStyle(
                  color: AppColor.black,
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, AppString.LOGIN_SCREEN_ROUTE, (route) => false);
              },
            ),
          ],
        ),
      ],
    );
  }
}
