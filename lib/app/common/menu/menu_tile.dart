import 'package:flutter/material.dart';
import 'package:wayawaya/utils/app_color.dart';

import 'rhombus_menu.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 600),
            reverseTransitionDuration: Duration(milliseconds: 600),
            opaque: false,
            barrierDismissible: true,
            fullscreenDialog: true,
            barrierColor: Colors.black54,
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return RhombusMenu(enabled: true);
            }),
      ),
      child: Container(
        margin: EdgeInsets.all(4.0),
        height: 50,
        width: 50,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppColor.primary),
        child: RhombusMenu(
          enabled: false,
        ),
      ),
    );
  }
}
