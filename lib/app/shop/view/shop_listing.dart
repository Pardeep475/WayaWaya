import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/shop/bloc/shop_bloc.dart';
import 'package:wayawaya/app/shop/model/retail_with_category.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';

import 'item_retail_unit_listing.dart';

class ShopListingScreen extends StatefulWidget {
  final bool isRestaurant;

  ShopListingScreen({this.isRestaurant});

  @override
  State<StatefulWidget> createState() => _ShopListingScreenState();
}

class _ShopListingScreenState extends State<ShopListingScreen> {
  ShopBloc _shopBloc;
  List<String> alphabet = [];
  ScrollController _alphaController;

  @override
  void initState() {
    setUpAlphabetList();
    _shopBloc = ShopBloc();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _shopBloc.fetchOrderedCategoryListing(isRestaurant: widget.isRestaurant);
    });
  }

  setUpAlphabetList() {
    alphabet = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RetailWithCategory>>(
        initialData: null,
        stream: _shopBloc.orderListingStream,
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
                    padding: EdgeInsets.symmetric(vertical: 30),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      AppString.no_record_found,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntuCondensed().copyWith(
                        color: AppColor.black.withOpacity(0.7),
                        fontSize: 19,
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
                itemBuilder: (context, index) {
                  return ItemRetailUnitListing(
                    index: index,
                    retailWithCategory: snapshot.data[index],
                    onLikePressed: () {
                      debugPrint('onLikePressed');
                    },
                    onLocationPressed: () {
                      debugPrint('onLocationPressed');
                    },
                    onOfferPressed: () {
                      debugPrint('onOfferPressed');
                      try {
                        Navigator.pushNamed(
                            context, AppString.OFFER_SCREEN_ROUTE,
                            arguments: snapshot.data[index].id);
                      } catch (e) {
                        Navigator.pushNamed(
                          context,
                          AppString.OFFER_SCREEN_ROUTE,
                        );
                      }
                    },
                  );
                });
          }
        });
  }
}
