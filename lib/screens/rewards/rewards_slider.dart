import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wayawaya/screens/rewards/model/rewards_categories.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/dimens.dart';

import '../../config.dart';
import 'wallet.dart';

class RewardsSlider extends StatefulWidget {
  final List<RewardsCategory> rewardsCategoryList;

  RewardsSlider({this.rewardsCategoryList});

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
        return AppImages.r_all;
      case 1:
        return AppImages.r_wallet;
      case 2:
        return AppImages.r_food;
      case 3:
        return AppImages.r_fashion;
      case 4:
        return AppImages.r_grocery;
      case 5:
        return AppImages.r_finance;
      case 6:
        return AppImages.r_others;
      case 7:
        return AppImages.r_health;
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

  getCategoryIconRewards({RewardsCategory rewardsCategory}) {
    if (rewardsCategory == null) return AppImages.r_all;
    if (rewardsCategory.name == null) return AppImages.r_all;
    switch (rewardsCategory.name) {
      case "All":
        return AppImages.r_all;
        break;

      case "Shopping":
      case "Clothing":
      case "Eyewear & Optometrists":
      case "Footwear":
      case "Jewellery & Accessories":
      case "Fashion and Accessories":
        // iconName = "fashion_accessories";
//                        categoriesIconName = R.drawable.ic_fashion_accessories;
        return AppImages.r_fashion;
        break;

      case "Banks, Forex & Financial":
      case "Financial Services":
        // iconName = "financial_services";
//                        categoriesIconName = R.drawable.ic_financial_services;
        return AppImages.r_finance;
        break;

      case "Restaurants":
      case "Wine & Spirits":
      case "Food and Drink":
        // iconName = "food_drink";
//                        categoriesIconName = R.drawable.ic_food_drink;
        return AppImages.r_food;
        break;

      case "Food & Dining":
        // iconName = "food_dining";
        return AppImages.r_food;
        break;

      case "Department Stores":
      case "Groceries":
      case "Groceries / Homeware":
      case "Groceries and Homeware":
        // iconName = "groceries_homeware";
//                        categoriesIconName = R.drawable.ic_groceries_homeware;
        return AppImages.r_grocery;
        break;

      case "Hair, Health & Beauty":
      case "Health and Beauty":
        // iconName = "health_beauty";
//                        categoriesIconName = R.drawable.ic_health_beauty;
        return AppImages.r_health;
        break;

      case "Home & Decor":
      case "Services":
        // iconName = "services";
//                        categoriesIconName = R.drawable.ic_services;
        return AppImages.r_grocery;
        break;

      default:
        // iconName = "other";
//                        categoriesIconName = R.drawable.ic_other;
        return AppImages.r_others;
    }
  }

  Widget categoryOval({int index, RewardsCategory rewardsCategory}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: _vIndiceWheel == index ? Dimens.oneFifty : Dimens.sixty,
      padding: EdgeInsets.all(Dimens.eight),
      decoration: BoxDecoration(
        color: getCategoryColor(index),
        shape: BoxShape.circle,
        image: DecorationImage(
          scale: 1,
          image: AssetImage(
            rewardsCategory == null
                ? getCategoryIcon(index)
                : getCategoryIconRewards(rewardsCategory: rewardsCategory),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.oneEightyFive,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: Dimens.ten),
      constraints: BoxConstraints(
        maxHeight: Dimens.oneEightyFive,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      color: Color(0xFFF0F0F0),
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
            squeeze: 1,
            onSelectedItemChanged: (val) {
              setState(() {
                _vIndiceWheel = val;
              });
            },
            childDelegate: ListWheelChildLoopingListDelegate(
              children: List<Widget>.generate(
                widget.rewardsCategoryList != null &&
                        widget.rewardsCategoryList.isNotEmpty
                    ? widget.rewardsCategoryList.length
                    : 8,
                (index) => Center(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: categoryOval(
                      index: index,
                      rewardsCategory: widget.rewardsCategoryList != null &&
                              widget.rewardsCategoryList.isNotEmpty
                          ? widget.rewardsCategoryList[index]
                          : null,
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
