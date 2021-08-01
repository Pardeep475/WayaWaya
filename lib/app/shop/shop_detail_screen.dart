import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/common/webview/model/custom_web_view_model.dart';
import 'package:wayawaya/app/common/zoom_out_page_transformation.dart';
import 'package:wayawaya/app/rewards/view/item_rewards.dart';
import 'package:wayawaya/app/shop/bloc/shop_detail_bloc.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';
import 'model/retail_with_category.dart';
import 'model/shop_detail_model.dart';

class ShopDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  ShopDetailBloc _shopDetailBloc;

  List<RetailWithCategory> _listRetailUnitCategories = [];

  @override
  void initState() {
    _shopDetailBloc = ShopDetailBloc();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _shopDetailBloc.setUpGestureRetailUnit();
      _shopDetailBloc.fetchMenuButtons();
    });
  }

  _getImagesLength(RetailWithCategory retailWithCategory) {
    List<String> _imagesList = [];
    if (retailWithCategory.subLocations == null) return _imagesList;
    if (retailWithCategory.subLocations.carouselInside != null) {
      _imagesList.addAll(retailWithCategory.subLocations.carouselInside);
    }
    if (retailWithCategory.subLocations.carouselOutside != null) {
      _imagesList.addAll(retailWithCategory.subLocations.carouselOutside);
    }

    return _imagesList;
  }

  @override
  Widget build(BuildContext context) {
    ShopDetailModel shopDetailModel = ModalRoute.of(context).settings.arguments;
    _listRetailUnitCategories = shopDetailModel.listRetailUnitCategory;
    return Stack(
      children: [
        StreamBuilder<List<MainMenuPermission>>(
            initialData: [],
            stream: _shopDetailBloc.mainMenuPermissionStream,
            builder: (context, snapshot) {
              return AnimateAppBar(
                // title: _getName(
                //     shopDetailModel.listRetailUnitCategory[shopDetailModel.index]),
                title: shopDetailModel.title.toUpperCase(),
                isSliver: true,
                mainMenuPermissions: snapshot.data,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SliverFillRemaining(
                    child: TransformerPageView(
                        loop: false,
                        transformer: new ZoomOutPageTransformer(),
                        index: shopDetailModel.index,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  CarouselSlider.builder(
                                    itemCount: _getImagesLength(shopDetailModel
                                            .listRetailUnitCategory[index])
                                        .length,
                                    itemBuilder:
                                        (context, position, realIndex) {
                                      return CachedNetworkImage(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        imageUrl: _getImagesLength(
                                            _listRetailUnitCategories[
                                                index])[position],
                                        fit: BoxFit.fill,
                                        imageBuilder:
                                            (context, imageProvider) =>
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
                                                    new AlwaysStoppedAnimation<
                                                            Color>(
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
                                      );
                                    },
                                    options: CarouselOptions(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.3,
                                      viewportFraction: 1.0,
                                      onPageChanged: (index, reason) {
                                        _shopDetailBloc.indicatorSink
                                            .add(index);
                                        debugPrint(
                                            'indexing   $index   ${reason.index}');
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                          _getImagesLength(shopDetailModel
                                                      .listRetailUnitCategory[
                                                  index])
                                              .length, (index) {
                                        return Container(
                                          height: Dimens.ten,
                                          width: Dimens.ten,
                                          margin: EdgeInsets.all(Dimens.four),
                                          decoration: BoxDecoration(
                                            color: snapshot.data == index
                                                ? Colors.grey
                                                : Colors.grey[700],
                                            shape: BoxShape.circle,
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    child: Container(
                                      color: Color(0xff3F000000),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Visibility(
                                            visible: false,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.directions_car,
                                                size: Dimens.thirty,
                                                color: AppColor.white,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.location_on,
                                              size: Dimens.thirty,
                                              color: AppColor.white,
                                            ),
                                            onPressed: () {
                                              _onLocationPressed(shopDetailModel
                                                      .listRetailUnitCategory[
                                                  index]);
                                            },
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.share,
                                                size: Dimens.twentySix,
                                                color: AppColor.white,
                                              ),
                                              onPressed: () {
                                                _shareFiles(
                                                    context,
                                                    shopDetailModel
                                                            .listRetailUnitCategory[
                                                        index]);
                                              }),
                                          IconButton(
                                              icon: Icon(
                                                Icons.thumb_up,
                                                size: Dimens.twentySix,
                                                color: shopDetailModel
                                                            .listRetailUnitCategory[
                                                                index]
                                                            .favourite ==
                                                        "1"
                                                    ? AppColor.primary
                                                    : AppColor.white,
                                              ),
                                              onPressed: () async {
                                                await _shopDetailBloc
                                                    .updateFavourite(
                                                        retailWithCategory:
                                                            _listRetailUnitCategories[
                                                                index]);

                                                RetailWithCategory
                                                    _retailWithCategory =
                                                    _listRetailUnitCategories[
                                                        index];
                                                _retailWithCategory.favourite =
                                                    _retailWithCategory
                                                                .favourite ==
                                                            "0"
                                                        ? "1"
                                                        : "0";

                                                setState(() {});
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    child: SizedBox(
                                      height: Dimens.sixteen,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: 2,
                                        itemBuilder: (context, index) {
                                          print(index);
                                          return Container(
                                            margin: EdgeInsets.all(
                                              Dimens.eight,
                                            ),
                                            height: Dimens.thirty,
                                            width: Dimens.thirty,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: Dimens.five,
                                                  top: Dimens.three),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        Dimens.two,
                                                        Dimens.ten,
                                                        0,
                                                        Dimens.four),
                                                    padding: EdgeInsets.only(
                                                        left: Dimens.ten,
                                                        right: Dimens.eight),
                                                    height: Dimens.fortyFive,
                                                    width: Dimens.fifty,
                                                    child: CachedNetworkImage(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      imageUrl: _getImage(
                                                          context,
                                                          shopDetailModel
                                                                  .listRetailUnitCategory[
                                                              index]),
                                                      fit: BoxFit.fill,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder:
                                                          (context, url) {
                                                        return Container(
                                                          child: Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  new AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      AppColor
                                                                          .primaryDark),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      errorWidget: (context,
                                                          url, error) {
                                                        return Image.asset(
                                                          AppImages
                                                              .icon_placeholder,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .2,
                                                    width: Dimens.fifty,
                                                    child: ListView(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      children: _addIconsListData(
                                                          shopDetailModel
                                                                  .listRetailUnitCategory[
                                                              index]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.only(
                                                    left: Dimens.five,
                                                    right: Dimens.eight,
                                                    top: Dimens.eight),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _getName(shopDetailModel
                                                              .listRetailUnitCategory[
                                                          index]),
                                                      style: GoogleFonts
                                                              .ubuntuCondensed()
                                                          .copyWith(
                                                        color: AppColor.black
                                                            .withOpacity(0.7),
                                                        fontSize:
                                                            Dimens.nineteen,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0.8,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Dimens.eight,
                                                    ),
                                                    Text(
                                                      _getDescription(
                                                          context,
                                                          shopDetailModel
                                                                  .listRetailUnitCategory[
                                                              index]),
                                                      style:
                                                          GoogleFonts.ubuntu()
                                                              .copyWith(
                                                        color: AppColor.black
                                                            .withOpacity(0.5),
                                                        fontSize:
                                                            Dimens.forteen,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0.8,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      _listRetailUnitCategories[index]
                                                  .campaigns ==
                                              null
                                          ? SizedBox(
                                              height: Dimens.twoHundredFifty,
                                            )
                                          : Container(
                                              height: Dimens.twoHundredFifty,
                                              child: Stack(
                                                children: [
                                                  TransformerPageView(
                                                      loop: false,
                                                      transformer:
                                                          new ZoomOutPageTransformer(),
                                                      itemCount: shopDetailModel
                                                          .listRetailUnitCategory[
                                                              index]
                                                          .campaigns
                                                          .length,
                                                      itemBuilder:
                                                          (context, position) {
                                                        return Stack(
                                                          children: [
                                                            Positioned.fill(
                                                              child:
                                                                  ItemRewards(
                                                                isBorder: false,
                                                                pointShow:
                                                                    false,
                                                                index: position,
                                                                campaign: shopDetailModel
                                                                    .listRetailUnitCategory[
                                                                        index]
                                                                    .campaigns[position],
                                                                listOfCampaign:
                                                                    shopDetailModel
                                                                        .listRetailUnitCategory[
                                                                            index]
                                                                        .campaigns,
                                                                size: shopDetailModel
                                                                    .listRetailUnitCategory[
                                                                        index]
                                                                    .campaigns
                                                                    .length,
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: List.generate(
                                                                  shopDetailModel
                                                                      .listRetailUnitCategory[
                                                                          index]
                                                                      .campaigns
                                                                      .length,
                                                                  (index) {
                                                                return Container(
                                                                  height: Dimens
                                                                      .ten,
                                                                  width: Dimens
                                                                      .ten,
                                                                  margin: EdgeInsets
                                                                      .all(Dimens
                                                                          .four),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: index ==
                                                                            position
                                                                        ? Colors
                                                                            .grey
                                                                        : Colors
                                                                            .grey[700],
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: _listRetailUnitCategories.length),
                  ),
                ],
              );
            }),
        StreamBuilder<bool>(
            initialData: false,
            stream: _shopDetailBloc.gestureDetailRetailUnitStream,
            builder: (context, snapshot) {
              if (snapshot.data) {
                return Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () async {
                      SessionManager.setGestureRetailUnit(false);
                      _shopDetailBloc.gestureDetailRetailUnitSink.add(false);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.66),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.5,
                            left: Dimens.ten,
                            child: Column(
                              children: [
                                gestureV(
                                    text: AppString.click_to_view_web_page),
                                gestureV(
                                    text: AppString.click_to_dial_the_number)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return SizedBox();
            }),
      ],
    );
  }

  Container gestureV({String text}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Dimens.fiftyFive,
            width: Dimens.fiftyFive,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.touch_u,
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Container(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.white,
                fontSize: Dimens.twentyTwo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }


  List<Widget> _addIconsListData(RetailWithCategory retailWithCategory) {
    final List<Widget> _iconsList = [];
    if (retailWithCategory == null) _iconsList;
    if (retailWithCategory.subLocations == null) _iconsList;
    if (retailWithCategory.subLocations.contactItem == null) _iconsList;

    retailWithCategory.subLocations.contactItem.forEach((element) {
      switch (element.type) {
        case 'www':
          {
            _iconsList.insert(
              0,
              customIconWidget(
                FontAwesomeIcons.globe,
                () {
                  _websiteOnPressed(
                      _getName(retailWithCategory), element.itemData);
                },
              ),
            );
          }
          break;
        case 'telephone':
          {
            _iconsList.insert(
              retailWithCategory.subLocations.contactItem.length > 1 ? 1 : 0,
              customIconWidget(
                Icons.phone,
                () {
                  _telephoneOnPressed(element.itemData);
                },
              ),
            );
          }
          break;
        case 'mobile':
          {
            _iconsList.add(
              customIconWidget(
                Icons.phone_android,
                () {
                  _telephoneOnPressed(element.itemData);
                },
              ),
            );
          }
          break;
        case 'email':
          {
            _iconsList.add(
              customIconWidget(
                Icons.email,
                _emailOnPressed(retailWithCategory),
              ),
            );
          }
          break;
        case 'facebook':
          {
            _iconsList.add(
              customIconWidget(
                FontAwesomeIcons.facebookF,
                () {
                  _websiteOnPressed(
                      _getName(retailWithCategory), element.itemData);
                },
              ),
            );
          }
          break;
        case 'twitter':
          {
            _iconsList.add(
              customIconWidget(
                FontAwesomeIcons.twitter,
                () {
                  _websiteOnPressed(
                      _getName(retailWithCategory), element.itemData);
                },
              ),
            );
          }
          break;
        case 'instagram':
          {
            _iconsList.add(
              customIconWidget(
                FontAwesomeIcons.instagram,
                () {
                  _websiteOnPressed(
                      _getName(retailWithCategory), element.itemData);
                },
              ),
            );
          }
          break;
        case 'youtube':
          {
            _iconsList.add(
              customIconWidget(
                FontAwesomeIcons.youtube,
                () {
                  _websiteOnPressed(
                      _getName(retailWithCategory), element.itemData);
                },
              ),
            );
          }
          break;
        case 'skype':
          {
            _iconsList.add(
              customIconWidget(
                FontAwesomeIcons.skype,
                () {
                  _websiteOnPressed(
                      _getName(retailWithCategory), element.itemData);
                },
              ),
            );
          }
          break;
        case 'google+':
          {
            _iconsList.add(
              customIconWidget(
                FontAwesomeIcons.googlePlus,
                () {
                  _websiteOnPressed(
                      _getName(retailWithCategory), element.itemData);
                },
              ),
            );
          }
          break;
        case 'fax':
          {
            _iconsList.add(
              customIconWidget(
                FontAwesomeIcons.fax,
                () {
                  _telephoneOnPressed(element.itemData);
                },
              ),
            );
          }
          break;
        case 'cart':
          {
            _iconsList.add(
              customIconWidget(
                FontAwesomeIcons.shoppingCart,
                () {
                  _websiteOnPressed(
                      _getName(retailWithCategory), element.itemData);
                },
              ),
            );
          }
          break;
      }
      debugPrint('check_contact_items:-   ${element.type}');
    });

    return _iconsList;
  }

  _emailOnPressed(RetailWithCategory retailWithCategory) {}

  _telephoneOnPressed(String url) async {
    debugPrint('telephone_click:-   $url');
    try {
      if (url == null || url.trim() == '') {
        _showErrorDialog(
          icon: Icon(
            FontAwesomeIcons.exclamationTriangle,
            color: AppColor.orange_500,
          ),
          title: AppString.error.toUpperCase(),
          content: AppString.no_number,
          buttonText: AppString.ok.toUpperCase(),
          onPressed: () => Navigator.pop(context),
        );
      } else {
        await launch('tel:$url');

        if (await canLaunch(url)) {
          await launch('tel:$url');
        } else {
          debugPrint('telephone_click:-   can not lanuch');
        }
      }
    } catch (e) {
      _showErrorDialog(
        icon: Icon(
          FontAwesomeIcons.exclamationTriangle,
          color: AppColor.orange_500,
        ),
        title: AppString.error.toUpperCase(),
        content: AppString.no_number,
        buttonText: AppString.ok.toUpperCase(),
        onPressed: () => Navigator.pop(context),
      );
    }
  }

  _websiteOnPressed(String name, String url) {
    debugPrint('custom_web_view_model:-   title:- $name   \n   url:-  $url');

    if (url == null || url.trim() == '' || url.trim() == '0') {
      // Some thing went wrong
      _showErrorDialog(
        icon: Icon(
          FontAwesomeIcons.exclamationTriangle,
          color: AppColor.orange_500,
        ),
        title: AppString.error.toUpperCase(),
        content: AppString.no_website,
        buttonText: AppString.ok.toUpperCase(),
        onPressed: () => Navigator.pop(context),
      );
    } else {
      Navigator.pushNamed(
        context,
        AppString.CUSTOM_WEB_VIEW_SCREEN_ROUTE,
        arguments: CustomWebViewModel(
            title: name, webViewUrl: url.replaceAll(" ", "%20")),
      );
    }
  }

  _showErrorDialog(
      {Icon icon,
      String title,
      String content,
      String buttonText,
      VoidCallback onPressed}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonErrorDialog(
                icon: icon,
                title: title,
                content: content,
                buttonText: buttonText,
                onPressed: onPressed,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  Widget customIconWidget(IconData iconData, Function() onPressed) {
    return IconButton(
      icon: Icon(
        iconData,
        color: Colors.grey[700],
      ),
      onPressed: onPressed,
    );
  }

  String _getName(RetailWithCategory retailWithCategory) {
    if (retailWithCategory == null) return "";
    if (retailWithCategory.name == null) return "";
    return retailWithCategory.name;
  }

  String _getDescription(
      BuildContext context, RetailWithCategory retailWithCategory) {
    if (retailWithCategory == null) return "";
    if (retailWithCategory.description == null) return "";
    return Utils.getTranslatedCode(context, retailWithCategory.description);
  }

  String _getImage(
      BuildContext context, RetailWithCategory retailWithCategory) {
    if (retailWithCategory == null) return "";
    if (retailWithCategory.subLocations == null) return "";
    if (retailWithCategory.subLocations.logoId == null) return "";
    if (retailWithCategory.subLocations.logoId.image == null) return "";
    if (retailWithCategory.subLocations.logoId.image.file == null) return "";
    return retailWithCategory.subLocations.logoId.image.file;
  }

  _shareFiles(
      BuildContext buildContext, RetailWithCategory retailWithCategory) {
    try {
      String subject = _getName(retailWithCategory);
      String description = _getDescription(buildContext, retailWithCategory);
      String image = _getImage(buildContext, retailWithCategory);

      // Share.share(description + "\n" + image, subject: subject);
      Utils.shareFunctionality(
          description: description,
          image: image,
          subject: subject);
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _onLocationPressed(RetailWithCategory retailWithCategory) async {
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
          title: _getName(retailWithCategory),
          webViewUrl: mapUrl.replaceAll(" ", "%20")),
    );
  }
}
