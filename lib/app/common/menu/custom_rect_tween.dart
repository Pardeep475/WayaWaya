import 'package:flutter/material.dart';

class CustomRectTween extends RectTween {
  Cubic _cubic;

  CustomRectTween({Rect begin, Rect end, Cubic cubic})
      : super(begin: begin, end: end) {
    _cubic = cubic;
  }

  @override
  Rect lerp(double t) {
    double height = end.top - begin.top;
    double width = end.left - begin.left;

    double transformedY = _cubic.transform(t);

    double animatedX = begin.left + (t * width);
    double animatedY = begin.top + (transformedY * height);

    // double startWidthCenter = begin.left + (begin.width / 2);
    // double startHeightCenter = begin.top + (begin.height / 2);

    return Rect.fromLTWH(animatedX, animatedY, width, height);
  }
}
