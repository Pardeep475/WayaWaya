import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../config.dart';
import 'wallet.dart';

class RewardsSlider extends StatefulWidget {
  @override
  _RewardsSliderState createState() => _RewardsSliderState();
}

class _RewardsSliderState extends State<RewardsSlider> {
  FixedExtentScrollController _controller = FixedExtentScrollController();
  int _vIndiceWheel = 0;
  double itemWidth = 80.0;

  getCategoryIcon(int index) {
    switch (index) {
      case 0:
        return 'assets/r_all.png';
      case 1:
        return 'assets/r_wallet.png';
      case 2:
        return 'assets/r_food.png';
      case 3:
        return 'assets/r_fashion.png';
      case 4:
        return 'assets/r_grocery.png';
      case 5:
        return 'assets/r_finance.png';
      case 6:
        return 'assets/r_others.png';
      case 7:
        return 'assets/r_health.png';
    }
  }

  getCategoryColor(int index) {
    switch (index) {
      case 0:
        return Color(0xff56B9BD);
      case 1:
        return Color(0xff000000);
      case 2:
        return Color(0xffB83246);
      case 3:
        return Color(0xff8783A2);
      case 4:
        return Color(0xff198D53);
      case 5:
        return Color(0xff248FD2);
      case 6:
        return Color(0xffFDD157);
      case 7:
        return Color(0xff585285);
    }
  }

  Widget categoryOval({int index}) {
    getCategoryIcon(index);
    getCategoryColor(index);
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: _vIndiceWheel == index ? 150 : 60,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: getCategoryColor(index),
          shape: BoxShape.circle,
          image: DecorationImage(
              scale: 0.5, image: AssetImage(getCategoryIcon(index)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: App.width(context),
      margin: EdgeInsets.only(bottom: 10),
      constraints: BoxConstraints(
        maxHeight: 180,
        maxWidth: App.width(context),
      ),
      color: Colors.blueGrey[100],
      child: RotatedBox(
        quarterTurns: -1,
        child: GestureDetector(
          onTap: () {
            if (_vIndiceWheel == null) {
              setState(() {
                _vIndiceWheel = 0;
              });
            }
            if (_vIndiceWheel == 1)
              return App.pushTo(context: context, screen: RewardsWallet());
            else
              print('hi');
          },
          child: ListWheelScrollView.useDelegate(
            itemExtent: itemWidth,
            controller: _controller,
            squeeze: 0.8,
            onSelectedItemChanged: (val) {
              setState(() {
                _vIndiceWheel = val;
              });
            },
            childDelegate: ListWheelChildLoopingListDelegate(
              children: List<Widget>.generate(
                8,
                (index) => Center(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: categoryOval(
                      index: index,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
