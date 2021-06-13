import 'package:flutter/material.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';

class CommonNoResultToShow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SizedBox(),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          AppString.go_to_home_page,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            AppString.go_to_home_page,
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
      ],
    );
  }

}
