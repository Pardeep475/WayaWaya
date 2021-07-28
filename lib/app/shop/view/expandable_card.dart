import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/shop/bloc/shop_bloc.dart';
import 'package:wayawaya/app/shop/model/category_based_model.dart';
import 'package:wayawaya/app/shop/view/item_retail_unit_listing.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/utils.dart';

class ExpandableCards extends StatefulWidget {
  final int index;
  final CategoryBasedModel categoryBasedModel;
  final ShopBloc shopBloc;
  final bool isShop;

  const ExpandableCards(
      {Key key,
      this.index,
      this.categoryBasedModel,
      this.shopBloc,
      this.isShop})
      : super(key: key);

  @override
  _ExpandableCardsState createState() => _ExpandableCardsState();
}

class _ExpandableCardsState extends State<ExpandableCards> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ExpansionTile(
        trailing: Icon(
          _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          size: 40,
          color: Colors.grey[700],
        ),
        leading: Icon(
          Icons.shop,
          size: 50,
          color: Colors.grey[700],
        ),
        title: Text(
          widget.categoryBasedModel.title ?? '',
          style: TextStyle(color: Colors.grey[700]),
        ),
        onExpansionChanged: (value) {
          debugPrint(
              'check_list_length  :- ${widget.categoryBasedModel.retailWithCategory.length}');
          setState(() {
            _expanded = value;
          });
        },
        backgroundColor: widget.categoryBasedModel.categoryColor,
        collapsedBackgroundColor: widget.categoryBasedModel.categoryColor,
        childrenPadding: EdgeInsets.all(4),
        tilePadding: EdgeInsets.all(8),
        children: List.generate(
          widget.categoryBasedModel.retailWithCategory.length,
          (index) => ItemRetailUnitListing(
            isShop: widget.isShop,
            retailWithCategory:
                widget.categoryBasedModel.retailWithCategory[index],
            index: index,
            listRetailUnitCategory:
                widget.categoryBasedModel.retailWithCategory,
            onLikePressed: () {
              debugPrint('onLikePressed');
              widget.shopBloc.updateFavourite(
                  retailWithCategory:
                      widget.categoryBasedModel.retailWithCategory[index]);
              widget.shopBloc
                  .fetchCategoryBasedListing(isShop: widget.isShop);
            },
            onLocationPressed: () {
              debugPrint('onLocationPressed');
            },
            onOfferPressed: () {
              debugPrint('onOfferPressed');
              try {
                Navigator.pushNamed(context, AppString.OFFER_SCREEN_ROUTE,
                    arguments:
                        widget.categoryBasedModel.retailWithCategory[index].id);
              } catch (e) {
                Navigator.pushNamed(
                  context,
                  AppString.OFFER_SCREEN_ROUTE,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
