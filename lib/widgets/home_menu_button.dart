import 'package:flutter/material.dart';

import '../constants.dart';

class MenuButton extends StatelessWidget {
  final Color color;
  final Widget icon;
  final double size;
  final VoidCallback onClick;
  final String text;
  final Widget child;

  const MenuButton(
      {Key key,
      this.color,
      this.icon,
      this.onClick,
      this.size,
      this.child,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            onTap: onClick,
            child: CircleAvatar(
              radius: size ?? 40,
              backgroundColor: color,
              child: child ??
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      SizedBox(height: 10,),
                      Text(
                        text,
                        style: TextStyle(color: white, fontSize: 12),
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
