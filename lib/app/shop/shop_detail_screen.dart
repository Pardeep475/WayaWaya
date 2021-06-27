import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/common/webview/model/custom_web_view_model.dart';
import 'package:wayawaya/app/shop/bloc/shop_detail_bloc.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/utils.dart';
import 'model/retail_with_category.dart';

class ShopDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  ShopDetailBloc _shopDetailBloc;
  final List<String> _imagesList = [];

  final List<Widget> _iconsList = [];

  @override
  void initState() {
    _shopDetailBloc = ShopDetailBloc();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _shopDetailBloc.fetchMenuButtons();
    });
  }

  _getImagesLength(RetailWithCategory retailWithCategory) {
    if (retailWithCategory.subLocations == null) return 0;
    if (retailWithCategory.subLocations.carouselInside != null) {
      _imagesList.addAll(retailWithCategory.subLocations.carouselInside);
    }
    if (retailWithCategory.subLocations.carouselOutside != null) {
      _imagesList.addAll(retailWithCategory.subLocations.carouselOutside);
    }
  }

  @override
  Widget build(BuildContext context) {
    RetailWithCategory retailWithCategory =
        ModalRoute.of(context).settings.arguments;
    _getImagesLength(retailWithCategory);
    _addIconsListData(retailWithCategory);
    return StreamBuilder<List<MainMenuPermission>>(
        initialData: [],
        stream: _shopDetailBloc.mainMenuPermissionStream,
        builder: (context, snapshot) {
          return AnimateAppBar(
            title: _getName(retailWithCategory),
            isSliver: true,
            mainMenuPermissions: snapshot.data,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount: _imagesList.length,
                      itemBuilder: (context, index, realIndex) {
                        return CachedNetworkImage(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          imageUrl: _imagesList[index],
                          fit: BoxFit.fill,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
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
                        height: MediaQuery.of(context).size.height / 3.3,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          _shopDetailBloc.indicatorSink.add(index);
                          debugPrint('indexing   $index   ${reason.index}');
                        },
                      ),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder<int>(
                          initialData: 0,
                          stream: _shopDetailBloc.indicatorStream,
                          builder: (context, snapshot) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  List.generate(_imagesList.length, (index) {
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
                            );
                          }),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        color: Color(0xff3F000000),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
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
                              onPressed: () {},
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.share,
                                  size: Dimens.twentySix,
                                  color: AppColor.white,
                                ),
                                onPressed: () {
                                  _shareFiles(context, retailWithCategory);
                                }),
                            IconButton(
                                icon: Icon(
                                  Icons.thumb_up,
                                  size: Dimens.twentySix,
                                  color: retailWithCategory.favourite == "1"
                                      ? AppColor.primary
                                      : AppColor.white,
                                ),
                                onPressed: () {}),
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
                                  shape: BoxShape.circle, color: Colors.red),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.only(right: Dimens.five, top: Dimens.three),
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  Dimens.two, Dimens.ten, 0, Dimens.four),
                              padding: EdgeInsets.only(
                                  left: Dimens.ten, right: Dimens.eight),
                              height: Dimens.fortyFive,
                              width: Dimens.fifty,
                              child: CachedNetworkImage(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                imageUrl:
                                    _getImage(context, retailWithCategory),
                                fit: BoxFit.fill,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
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
                            Container(
                              height: MediaQuery.of(context).size.height * .2,
                              width: Dimens.fifty,
                              child: ListView(
                                children: _iconsList,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              left: Dimens.five,
                              right: Dimens.eight,
                              top: Dimens.eight),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getName(retailWithCategory),
                                style: GoogleFonts.ubuntuCondensed().copyWith(
                                  color: AppColor.black.withOpacity(0.7),
                                  fontSize: Dimens.nineteen,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(
                                height: Dimens.eight,
                              ),
                              Text(
                                _getDescription(context, retailWithCategory),
                                style: GoogleFonts.ubuntu().copyWith(
                                  color: AppColor.black.withOpacity(0.5),
                                  fontSize: Dimens.forteen,
                                  fontWeight: FontWeight.w500,
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
              ),
            ],
          );
        });
  }

  _addIconsListData(RetailWithCategory retailWithCategory) {
    if (retailWithCategory == null) return;
    if (retailWithCategory.subLocations == null) return;
    if (retailWithCategory.subLocations.contactItem == null) return;

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
  }

  _cartOnPressed(RetailWithCategory retailWithCategory) {}

  _faxOnPressed(RetailWithCategory retailWithCategory) {}

  _googlePlusOnPressed(RetailWithCategory retailWithCategory) {}

  _skypeOnPressed(RetailWithCategory retailWithCategory) {}

  _youtubeOnPressed(RetailWithCategory retailWithCategory) {}

  _instaOnPressed(RetailWithCategory retailWithCategory) {}

  _twitterOnPressed(RetailWithCategory retailWithCategory) {}

  _faceBookOnPressed(RetailWithCategory retailWithCategory) {}

  _emailOnPressed(RetailWithCategory retailWithCategory) {}

  _mobileOnPressed(RetailWithCategory retailWithCategory) {}

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
        if (await canLaunch(url)) {
          await launch('tel:$url');
        }else{
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
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppString.CUSTOM_WEB_VIEW_SCREEN_ROUTE,
        (route) => false,
        arguments: CustomWebViewModel(title: name, webViewUrl: url),
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

      Share.share(description + "\n" + image, subject: subject);
    } catch (e) {
      debugPrint('$e');
    }
  }
}
