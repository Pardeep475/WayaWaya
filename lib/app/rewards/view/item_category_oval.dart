import 'package:flutter/cupertino.dart';
import 'package:wayawaya/app/rewards/model/rewards_categories.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/dimens.dart';

class ItemCategoryOval extends StatelessWidget {
  final int index;
  final RewardsCategory rewardsCategory;

  ItemCategoryOval({this.index, this.rewardsCategory});

  @override
  Widget build(BuildContext context) {
    if (rewardsCategory != null)
      return Container(
        width: Dimens.oneFifty,
        height: Dimens.oneFifty,
        padding: EdgeInsets.all(Dimens.eight),
        decoration: BoxDecoration(
          color: _getCategoryColor(index),
          shape: BoxShape.circle,
          image: DecorationImage(
            scale: 1,
            image: AssetImage(
              rewardsCategory == null
                  ? _getCategoryIcon(index)
                  : _getCategoryIconRewards(rewardsCategory: rewardsCategory),
            ),
          ),
        ),
      );
  }

  String getName({RewardsCategory rewardsCategory}) {
    if (rewardsCategory == null) return '';
    if (rewardsCategory.name == null) return '';
    return rewardsCategory.name;
  }

  Color _getCategoryColor(int index) {
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
      default:
        return Color(0xff198D53);
    }
  }

  String _getCategoryIcon(int index) {
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
      default:
        return AppImages.r_health;
    }
  }

  String _getCategoryIconRewards({RewardsCategory rewardsCategory}) {
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
      case "Beauty & Health":
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
}
