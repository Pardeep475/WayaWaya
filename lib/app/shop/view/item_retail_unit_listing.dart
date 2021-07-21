import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/common/webview/model/custom_web_view_model.dart';
import 'package:wayawaya/app/shop/model/retail_with_category.dart';
import 'package:wayawaya/app/shop/model/shop_status.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class ItemRetailUnitListing extends StatelessWidget {
  final RetailWithCategory retailWithCategory;
  final int index;
  final Function() onOfferPressed;
  final Function() onLocationPressed;
  final Function() onLikePressed;

  // ignore: close_sinks
  StreamController _likeColorChangedController = StreamController<String>();

  StreamSink<String> get likeColorSink => _likeColorChangedController.sink;

  Stream<String> get likeColorSinkStream => _likeColorChangedController.stream;

  ItemRetailUnitListing(
      {this.retailWithCategory,
      this.index,
      this.onLocationPressed,
      this.onLikePressed,
      this.onOfferPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppString.SHOP_DETAIL_SCREEN_ROUTE,
            arguments: retailWithCategory);
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
                  color: _getColor(),
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
                            child: CachedNetworkImage(
                              height: Dimens.oneTwenty,
                              width: Dimens.oneTwenty,
                              imageUrl: _getImage(context),
                              fit: BoxFit.contain,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) {
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              AppColor.primaryDark),
                                    ),
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                  AppImages.icon_placeholder,
                                  fit: BoxFit.cover,
                                );
                              },
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
                                    _getName(),
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
                                    _getDescription(context),
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
                        child: FutureBuilder<ShopStatus>(
                          initialData: ShopStatus(
                              color: Colors.green.shade400, txt: "OPEN"),
                          future: _setUpOpenAndCloseStore(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: Dimens.oneTwenty,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: snapshot.data.color,
                                        ),
                                        SizedBox(
                                          height: Dimens.three,
                                        ),
                                        Text(
                                          snapshot.data.txt,
                                          style: TextStyle(
                                            fontSize: Dimens.ten,
                                            color: snapshot.data.color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //BUTTONS
                                  Expanded(
                                    child: Container(
                                      width: Dimens.oneFifty,
                                      margin:
                                          EdgeInsets.only(right: Dimens.twenty),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: onOfferPressed,
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
                                            onTap: () {
                                              _locateOnMap(context);
                                            },
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
                                              likeColorSink.add(
                                                  retailWithCategory
                                                              .favourite ==
                                                          "0"
                                                      ? "1"
                                                      : "0");
                                              onLikePressed();
                                            },
                                            child: StreamBuilder<String>(
                                                initialData: retailWithCategory
                                                    .favourite,
                                                stream: likeColorSinkStream,
                                                builder: (context, snapshot) {
                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Icon(
                                                        Icons.thumb_up,
                                                        color: snapshot.data ==
                                                                '1'
                                                            ? AppColor.primary
                                                            : AppColor.black,
                                                      ),
                                                      SizedBox(
                                                        height: Dimens.six,
                                                      ),
                                                      Text(
                                                        'Like'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: Dimens.ten,
                                                          color: snapshot
                                                                      .data ==
                                                                  '1'
                                                              ? AppColor.primary
                                                              : AppColor.black,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          ),
                                          SizedBox(
                                            width: Dimens.ten,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return SizedBox();
                            }
                          },
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

  String _getName() {
    if (retailWithCategory == null) return "";
    if (retailWithCategory.name == null) return "";
    return retailWithCategory.name;
  }

  _locateOnMap(BuildContext context) async {
    if (retailWithCategory == null) return;
    if (retailWithCategory.subLocations == null) return;
    if (retailWithCategory.subLocations.floorplanId == null) return;
    debugPrint(
        'Here_is_floor_plan_id:-   ${retailWithCategory.subLocations.floorplanId}');
    String defaultMap = await SessionManager.getDefaultMall();
    String mapUrl =
        '${AppString.MAP_URL_LIVE}?retail_unit=${retailWithCategory.subLocations.floorplanId}&map_data_url=$defaultMap';
    Navigator.pushNamed(
      context,
      AppString.CUSTOM_WEB_VIEW_SCREEN_ROUTE,
      arguments: CustomWebViewModel(
          title: _getName(), webViewUrl: mapUrl.replaceAll(" ", "%20")),
    );
  }

  String _getDescription(BuildContext context) {
    if (retailWithCategory == null) return "";
    if (retailWithCategory.description == null) return "";
    return Utils.getTranslatedCode(context, retailWithCategory.description);
  }

  String _getImage(BuildContext context) {
    if (retailWithCategory == null) return "";
    if (retailWithCategory.subLocations == null) return "";
    if (retailWithCategory.subLocations.logoId == null) return "";
    if (retailWithCategory.subLocations.logoId.image == null) return "";
    if (retailWithCategory.subLocations.logoId.image.file == null) return "";
    return retailWithCategory.subLocations.logoId.image.file;
  }

  Color _getColor() {
    if (retailWithCategory == null) return Colors.orange;
    if (retailWithCategory.color == null) return Colors.orange;
    if (retailWithCategory.color.hexCode == null) return Colors.orange;
    return Utils.fromHex(retailWithCategory.color.hexCode);
  }

  Future<ShopStatus> _setUpOpenAndCloseStore() async {
    if (retailWithCategory == null)
      return ShopStatus(color: Colors.green.shade400, txt: "OPEN");
    if (retailWithCategory.subLocations == null)
      return ShopStatus(color: Colors.green.shade400, txt: "OPEN");
    if (retailWithCategory.subLocations.openingTimes == null)
      return ShopStatus(color: Colors.green.shade400, txt: "OPEN");
    if (retailWithCategory.subLocations.openingTimes.openTime == null)
      ShopStatus(color: Colors.green.shade400, txt: "OPEN");
    if (retailWithCategory == null)
      return ShopStatus(color: Colors.green.shade400, txt: "OPEN");
    if (retailWithCategory.subLocations == null)
      return ShopStatus(color: Colors.green.shade400, txt: "OPEN");
    if (retailWithCategory.subLocations.openingTimes == null)
      return ShopStatus(color: Colors.green.shade400, txt: "OPEN");
    if (retailWithCategory.subLocations.openingTimes.closeTime == null)
      return ShopStatus(color: Colors.green.shade400, txt: "OPEN");

    debugPrint(
        'openTime:-   ${retailWithCategory.subLocations.openingTimes.openTime}\n endTime:-  ${retailWithCategory.subLocations.openingTimes.closeTime}');
    DateTime openTime = Utils.getDateOnStringParse(
        retailWithCategory.subLocations.openingTimes.openTime,
        AppString.DATE_FORMAT);
    DateTime closeTime = Utils.getDateOnStringParse(
        retailWithCategory.subLocations.openingTimes.closeTime,
        AppString.DATE_FORMAT);
    bool isStoreOpen =
        Utils.storeStatus(openTime: openTime, closeTime: closeTime);
    if (isStoreOpen) {
      return ShopStatus(color: Colors.green.shade400, txt: "OPEN");
    } else {
      return ShopStatus(color: Colors.red.shade400, txt: "CLOSED");
    }
  }
}
