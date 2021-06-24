import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/shop/bloc/shop_bloc.dart';
import 'package:wayawaya/app/shop/model/retail_with_category.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/dimens.dart';

import 'item_retail_unit_listing.dart';

class ShopListingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopListingScreenState();
}

class _ShopListingScreenState extends State<ShopListingScreen> {
  ShopBloc _shopBloc;

  @override
  void initState() {
    _shopBloc = ShopBloc();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _shopBloc.fetchOrderedCategoryListing();
    });
  }

  Widget customCard(int index, RetailWithCategory retailWithCategory) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (_) => ShopRestDetails(
        //       title: exampleList[index],
        //       subtitle:
        //       'ABSA is one of South Africa\'s largest banks, serving personal, commercial and corporate.',
        //       liked: _isLiked[index],
        //     ),
        //   ),
        // );
      },
      child: Container(
        height: Dimens.oneEightyFive,
        margin: EdgeInsets.only(top: Dimens.six, left: Dimens.two),
        child: Card(
          margin: EdgeInsets.only(left: Dimens.four),
          color: Color(0xffFAFAFA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.four),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: Dimens.twoForty,
                width: Dimens.six,
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.orange : Colors.blue[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimens.four),
                    bottomLeft: Radius.circular(Dimens.four),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: Dimens.oneTwenty,
                            width: Dimens.oneTwenty,
                            color: AppColor.white,
                            margin: EdgeInsets.only(right: Dimens.four),
                            child: Image.network(
                              index % 2 == 0
                                  ? 'https://www.cbia.com/wp-content/uploads/2020/05/Social-Distancing.png'
                                  : 'https://www.cdc.gov/handwashing/images/twitter-cards/poster-handwashing.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: Dimens.oneTwenty,
                              color: AppColor.white,
                              padding: EdgeInsets.only(
                                  left: Dimens.five,
                                  top: Dimens.eight,
                                  right: Dimens.four),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'exampleList[index]',
                                    style:
                                        GoogleFonts.ubuntuCondensed().copyWith(
                                      color: AppColor.black.withOpacity(0.7),
                                      fontSize: Dimens.nineteen,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.8,
                                    ),
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height: Dimens.seven,
                                  ),
                                  Text(
                                    'ABSA is one of South Africa\'s largest banks, serving personal, commercial and corporate.',
                                    style: GoogleFonts.ubuntu().copyWith(
                                      color: AppColor.black.withOpacity(0.8),
                                      fontSize: Dimens.thrteen,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.8,
                                    ),
                                    overflow: TextOverflow.clip,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: Dimens.sixty,
                        padding: EdgeInsets.only(bottom: Dimens.two),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Dimens.four),
                            bottomRight: Radius.circular(Dimens.four),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Dimens.oneTwenty,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    height: Dimens.three,
                                  ),
                                  Text(
                                    'OPEN',
                                    style: TextStyle(
                                      fontSize: Dimens.ten,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //BUTTONS
                            Expanded(
                              child: Container(
                                width: Dimens.oneFifty,
                                margin: EdgeInsets.only(right: Dimens.twenty),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      // onTap: () => Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //       builder: (_) => OffersList()),
                                      // ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.local_offer,
                                            color: AppColor.black,
                                          ),
                                          SizedBox(
                                            height: Dimens.six,
                                          ),
                                          Text(
                                            'Offers'.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: Dimens.eleven,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimens.ten,
                                    ),
                                    InkWell(
                                      // onTap: () => Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //       builder: (_) => MapScreen()),
                                      // ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: AppColor.black,
                                          ),
                                          SizedBox(
                                            height: Dimens.six,
                                          ),
                                          Text(
                                            'Locate'.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: Dimens.eleven,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimens.ten,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   _isLiked[index] = !_isLiked[index];
                                        //   _favs.removeAt(index);
                                        // });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.thumb_up,
                                            color: AppColor.black,
                                          ),
                                          SizedBox(
                                            height: Dimens.six,
                                          ),
                                          Text(
                                            'Like'.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: Dimens.ten,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimens.ten,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        StreamBuilder<List<RetailWithCategory>>(
            initialData: [],
            stream: _shopBloc.orderListingStream,
            builder: (context, snapshot) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
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
                      },
                    );
                  },
                  childCount: snapshot.data.length,
                ),
              );
            }),
      ],
    );
  }
}
