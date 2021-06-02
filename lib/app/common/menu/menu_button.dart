import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Color color;
  final Widget icon;
  final String label;
  final bool enabled;
  final Cubic cubic;
  final Function onPressed;
  final double widgetSize;

  MenuButton(
      {this.color,
      this.icon,
      this.label,
      this.enabled,
      this.cubic,
      this.onPressed,
      this.widgetSize});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: label,
      // flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {

      // } ,
      // createRectTween: (begin, end) {
      // return CustomRectTween(begin: begin, end: end, cubic: Curves.easeInOutQuart);
      // },
      // transitionOnUserGestures: true,
      child: GestureDetector(
        onTap: enabled ? () => onPressed() : null,
        child: Container(
          height: widgetSize,
          width: widgetSize,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: enabled
              ? Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      icon,
                      label.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                label,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
