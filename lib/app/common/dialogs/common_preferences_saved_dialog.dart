import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';

import 'common_login_with_home_page.dart';

// ignore: must_be_immutable
class CommonPreferencesSavedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SizedBox(),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          AppString.your_preferences_saved_successfully,
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
                Navigator.pushNamedAndRemoveUntil(
                    context, AppString.HOME_SCREEN_ROUTE, (route) => false);
              },
            ),
            TextButton(
              child: Text(
                AppString.settings.toUpperCase(),
                style: const TextStyle(
                  color: AppColor.black,
                  fontSize: 15,
                ),
              ),
              onPressed: () async {
                bool isLogin = await SessionManager.isLogin();
                Navigator.pop(context);
                if (isLogin) {
                  Navigator.pushNamedAndRemoveUntil(context,
                      AppString.SETTINGS_SCREEN_ROUTE, (route) => false);
                } else {
                  _showLoginDialog(
                    context: context,
                    icon: Icon(
                      FontAwesomeIcons.exclamationTriangle,
                      color: AppColor.orange_500,
                    ),
                    title: AppString.login.toUpperCase(),
                    content: AppString.currently_not_logged_in,
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  _showLoginDialog({
    BuildContext context,
    Icon icon,
    String title,
    String content,
  }) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonLoginWithHomePageDialog(
                icon: icon,
                title: title,
                content: content,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
}
