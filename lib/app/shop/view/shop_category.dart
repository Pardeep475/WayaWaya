import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/shop/bloc/shop_bloc.dart';
import 'package:wayawaya/app/shop/model/category_based_model.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';

import 'expandable_card.dart';

class ShopCategoryScreen extends StatefulWidget {
  final bool isShop;

  ShopCategoryScreen({this.isShop});

  @override
  State<StatefulWidget> createState() => _ShopCategoryScreenState();
}

class _ShopCategoryScreenState extends State<ShopCategoryScreen> {
  ShopBloc _shopBloc;

  @override
  void initState() {
    _shopBloc = ShopBloc();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _shopBloc.fetchCategoryBasedListing(isShop: widget.isShop);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryBasedModel>>(
        initialData: null,
        stream: _shopBloc.categoryBasedStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return SizedBox();
          } else if (snapshot.data.isEmpty) {
            return Wrap(
              children: [
                Card(
                  color: AppColor.white,
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Dimens.thirty),
                    width: double.infinity,
                    child: Text(
                      AppString.no_record_found,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntuCondensed().copyWith(
                        color: AppColor.black.withOpacity(0.7),
                        fontSize: Dimens.nineteen,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                padding: EdgeInsets.only(bottom: Dimens.thirty),
                itemBuilder: (context, index) {
                  return ExpandableCards(
                    index: index,
                    isShop: widget.isShop,
                    shopBloc: _shopBloc,
                    categoryBasedModel: snapshot.data[index],
                  );
                });
          }
        });
  }
}
