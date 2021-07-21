import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/common/dialogs/common_login_dialog.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/common/webview/model/custom_web_view_model.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class MenuTile extends StatelessWidget {
  // final List<MainMenuPermission> itemList = [];

  //  const static MenuTile({Key key, List<MainMenuPermission> itemList});
  //
  final List<MainMenuPermission> itemList;

  const MenuTile({Key key, this.itemList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'main_menu_permission_testing:-----  MenuTile ${itemList != null ? itemList.length : 'null'}');
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 600),
            reverseTransitionDuration: Duration(milliseconds: 600),
            opaque: false,
            barrierDismissible: true,
            fullscreenDialog: true,
            barrierColor: Colors.black54,
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return RhombusMenu(
                enabled: true,
                menuPermissionList: itemList,
              );
            }),
      ).then((value) {
        debugPrint('pardeep_testing_animation:-   $value');
        _chooseScreens(context, value);
      }),
      child: Container(
        margin: EdgeInsets.only(left: Dimens.four),
        height: Dimens.fifty,
        width: Dimens.fifty,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: AppColor.primary),
        child: RhombusMenu(
          enabled: false,
          menuPermissionList: itemList,
        ),
      ),
    );
  }

  _showErrorDialog(
      {BuildContext context,
      Icon icon,
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
              child: CommonLoginDialog(
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

  _chooseScreens(BuildContext context, String title) async {
    if (title == null) return;

    bool isLogin = await SessionManager.isLogin();

    if (isLogin == null || !isLogin) {
      if (title.toLowerCase() == 'home') {
        _openFurtherScreens(context, AppString.HOME_SCREEN_ROUTE, false);
      } else {
        _showErrorDialog(
          context: context,
          icon: Icon(
            FontAwesomeIcons.exclamationTriangle,
            color: AppColor.orange_500,
          ),
          title: AppString.login.toUpperCase(),
          content: AppString.currently_not_logged_in,
          buttonText: AppString.login.toUpperCase(),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppString.LOGIN_SCREEN_ROUTE);
          },
        );
      }
    } else {
      switch (title.toLowerCase()) {
        case 'home':
          {
            _openFurtherScreens(context, AppString.HOME_SCREEN_ROUTE, true);
          }
          break;
        case 'offers':
          {
            _openFurtherScreens(context, AppString.OFFER_SCREEN_ROUTE, true);
          }
          break;
        case 'events':
          {
            _openFurtherScreens(context, AppString.EVENT_SCREEN_ROUTE, true);
          }
          break;
        case 'rewards':
          {
            _openFurtherScreens(context, AppString.REWARDS_SCREEN_ROUTE, true);
          }
          break;
        case 'shops':
          {
            Future.delayed(Duration(seconds: 1), () {
              debugPrint('pardeep_testing_animation:-   $title');
              Navigator.pushNamed(context, AppString.SHOP_SCREEN_ROUTE,
                  arguments: true);
            });
          }
          break;
        case 'restaurants':
          {
            Future.delayed(Duration(seconds: 1), () {
              debugPrint('pardeep_testing_animation:-   $title');
              Navigator.pushNamed(context, AppString.SHOP_SCREEN_ROUTE,
                  arguments: false);
            });
          }
          break;
        case 'the mall':
          {
            _openFurtherScreens(context, AppString.THE_MALL_SCREEN_ROUTE, true);
          }
          break;
        case 'mall map':
          {
            String defaultMap = await SessionManager.getDefaultMall();
            String mapUrl =
                '${AppString.MAP_URL_LIVE}?map_data_url=$defaultMap';

            debugPrint('mapUrl_testing:-    $mapUrl');

            Navigator.pushNamed(
              context,
              AppString.CUSTOM_WEB_VIEW_SCREEN_ROUTE,
              arguments: CustomWebViewModel(
                  title: title, webViewUrl: mapUrl.replaceAll(" ", "%20")),
            );
          }
          break;
        case 'scanner':
          {
            _openFurtherScreens(
                context, AppString.QR_SCANNER_SCREEN_ROUTE, true);
          }
          break;
      }
    }
  }

  _openFurtherScreens(BuildContext context, String title, bool isBackStack) {
    Future.delayed(Duration(seconds: 1), () {
      debugPrint('pardeep_testing_animation:-   $title');
      if (isBackStack) {
        Navigator.pushNamed(context, title);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, title, (route) => false);
      }
    });
  }
}

class RhombusMenu extends StatelessWidget {
  final bool enabled;
  final Animation<double> animation;
  final List<MainMenuPermission> menuPermissionList;

  const RhombusMenu(
      {Key key,
      @required this.enabled,
      @required this.menuPermissionList,
      this.animation})
      : super(key: key);

  static Cubic _getCubic(var label) {
    switch (label) {
      case "Home":
//        easeOutExpo
        return Curves.easeOutExpo;
      case "Offers":
//        easeOutQuint
        return Curves.easeOutQuint;
      case "Events":
//        easeOutQuart
        return Curves.easeOutQuart;
      case "Shops":
//        easeOutCubic
        return Curves.easeOutCubic;
      case "connect":
//        easeOutQuad
        return Curves.easeOutQuad;
      case "Restaurants":
//        easeOutExpo
        return Curves.easeOutExpo;
      case "Rewards":
//        easeOutQuint
        return Curves.easeOutQuint;
      case "The Mall":
//        easeOutQuart
        return Curves.easeOutQuart;
      case "Mall Map":
//        easeOutCubic
        return Curves.easeOutCubic;
      default:
        return Curves.easeIn;
    }
  }

//   extension HexColor on Color {
//   /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
//
//
//   /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
//   String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
//       '${alpha.toRadixString(16).padLeft(2, '0')}'
//       '${red.toRadixString(16).padLeft(2, '0')}'
//       '${green.toRadixString(16).padLeft(2, '0')}'
//       '${blue.toRadixString(16).padLeft(2, '0')}';
// }

  IconData fetchIcons(
      MainMenuPermission mainMenuPermission, IconData iconData) {
    if (mainMenuPermission.icon.name.toLowerCase().contains('home')) {
      return Icons.home;
    } else if (mainMenuPermission.icon.name
        .toLowerCase()
        .contains('local_offer')) {
      return Icons.local_offer;
    } else if (mainMenuPermission.icon.name.toLowerCase().contains('event')) {
      return Icons.event;
    } else if (mainMenuPermission.icon.name.toLowerCase().contains('shop')) {
      return Icons.shop;
    } else if (mainMenuPermission.icon.name
        .toLowerCase()
        .contains('local_dining')) {
      return Icons.local_dining;
    } else if (mainMenuPermission.icon.name.toLowerCase().contains('loyalty')) {
      return Icons.loyalty_rounded;
    } else if (mainMenuPermission.icon.name
        .toLowerCase()
        .contains('view_carousel')) {
      return Icons.view_carousel;
    } else if (mainMenuPermission.icon.name.toLowerCase().contains('map')) {
      return Icons.map;
    }

    return iconData;
  }

  String getDisplayName(MainMenuPermission mainMenuPermission, String title) {
    mainMenuPermission.displayName.forEach((element) {
      if (element.language == 'en_US') {
        return element.text;
      }
    });
    return title;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'main_menu_permission_testing:----- RhombusMenu  ${menuPermissionList != null ? menuPermissionList.length : 'null'}');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: enabled ? 32 : 12, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuButton(
                color:
                    menuPermissionList == null || menuPermissionList.length < 1
                        ? Colors.amber
                        : Utils.fromHex(menuPermissionList[0].color),
                icon: Icon(
                  menuPermissionList == null || menuPermissionList.length < 1
                      ? Icons.home
                      : fetchIcons(menuPermissionList[0], Icons.home),
                  color: Colors.white,
                  size: 35,
                ),
                label:
                    menuPermissionList == null || menuPermissionList.length < 1
                        ? AppString.home_menu
                        : getDisplayName(
                            menuPermissionList[0], AppString.home_menu),
                enabled: enabled,
                cubic: _getCubic(AppString.home_menu),
                onPressed: () {
                  Navigator.pop(context, AppString.home_menu);
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuButton(
                color:
                    menuPermissionList == null || menuPermissionList.length < 2
                        ? Colors.blue
                        : Utils.fromHex(menuPermissionList[1].color),
                icon: Icon(
                  menuPermissionList == null || menuPermissionList.length < 2
                      ? Icons.local_offer
                      : fetchIcons(menuPermissionList[1], Icons.local_offer),
                  color: Colors.white,
                  size: 35,
                ),
                label:
                    menuPermissionList == null || menuPermissionList.length < 2
                        ? AppString.offers_menu
                        : getDisplayName(
                            menuPermissionList[1], AppString.offers_menu),
                enabled: enabled,
                cubic: _getCubic(AppString.offers_menu),
                onPressed: () {
                  Navigator.pop(context, AppString.offers_menu);
                  // App.pushTo(
                  //   context: context,
                  //   screen: OffersList(),
                  // );
                },
              ),
              MenuButton(
                color:
                    menuPermissionList == null || menuPermissionList.length < 3
                        ? Colors.purple
                        : Utils.fromHex(menuPermissionList[2].color),
                icon: Icon(
                  menuPermissionList == null || menuPermissionList.length < 3
                      ? Icons.event
                      : fetchIcons(menuPermissionList[2], Icons.event),
                  color: Colors.white,
                  size: 35,
                ),
                label:
                    menuPermissionList == null || menuPermissionList.length < 3
                        ? AppString.events_menu
                        : getDisplayName(
                            menuPermissionList[2], AppString.events_menu),
                enabled: enabled,
                cubic: _getCubic(AppString.events_menu),
                onPressed: () {
                  Navigator.pop(context, AppString.events_menu);
                  // App.pushTo(
                  //   context: context,
                  //   screen: EventsList(),
                  // );
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuButton(
                color:
                    menuPermissionList == null || menuPermissionList.length < 4
                        ? Colors.green
                        : Utils.fromHex(menuPermissionList[3].color),
                icon: Icon(
                  menuPermissionList == null || menuPermissionList.length < 4
                      ? Icons.shop
                      : fetchIcons(menuPermissionList[3], Icons.shop),
                  color: Colors.white,
                  size: 35,
                ),
                label:
                    menuPermissionList == null || menuPermissionList.length < 4
                        ? AppString.shops_menu
                        : getDisplayName(
                            menuPermissionList[3], AppString.shops_menu),
                enabled: enabled,
                cubic: _getCubic(AppString.shops_menu),
                onPressed: () {
                  Navigator.pop(context, AppString.shops_menu);
                  // App.pushTo(
                  //   context: context,
                  //   screen: ShopRestList(title: "SHOPS"),
                  // );
                },
              ),
              MenuButton(
                color:
                    menuPermissionList == null || menuPermissionList.length < 5
                        ? Colors.white
                        : Colors.white,
                //fromHex(menuPermissionList[4].color),
                icon: Image.asset(
                  AppImages.icon_barcode,
                  height: 45,
                  width: 45,
                ),
                label: "",
                enabled: enabled,
                cubic: _getCubic("Connect"),
                onPressed: () {
                  Navigator.pop(context, 'scanner');
                  // App.pushTo(
                  //   context: context,
                  //   screen: QRScanner(),
                  // );
                },
              ),
              MenuButton(
                color:
                    menuPermissionList == null || menuPermissionList.length < 6
                        ? Colors.yellow
                        : Utils.fromHex(menuPermissionList[5].color),
                icon: Icon(
                  menuPermissionList == null || menuPermissionList.length < 6
                      ? Icons.local_dining
                      : fetchIcons(menuPermissionList[5], Icons.local_dining),
                  color: Colors.white,
                  size: 35,
                ),
                label:
                    menuPermissionList == null || menuPermissionList.length < 6
                        ? AppString.restaurants_menu
                        : getDisplayName(
                            menuPermissionList[5], AppString.restaurants_menu),
                enabled: enabled,
                cubic: _getCubic(AppString.restaurants_menu),
                onPressed: () {
                  Navigator.pop(context, AppString.restaurants_menu);
                  // App.pushTo(
                  //   context: context,
                  //   screen: ShopRestList(title: "My RESTAURANTS"),
                  // );
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuButton(
                color:
                    menuPermissionList == null || menuPermissionList.length < 7
                        ? Colors.red
                        : Utils.fromHex(menuPermissionList[6].color),
                icon: Icon(
                  menuPermissionList == null || menuPermissionList.length < 7
                      ? Icons.loyalty_rounded
                      : fetchIcons(
                          menuPermissionList[6], Icons.loyalty_rounded),
                  color: Colors.white,
                  size: 35,
                ),
                label:
                    menuPermissionList == null || menuPermissionList.length < 7
                        ? AppString.rewards_menu
                        : getDisplayName(
                            menuPermissionList[6], AppString.rewards_menu),
                enabled: enabled,
                cubic: _getCubic(AppString.rewards_menu),
                onPressed: () {
                  Navigator.pop(context, AppString.rewards_menu);
                  // App.pushTo(
                  //   context: context,
                  //   screen: RewardsBrowser(),
                  // );
                },
              ),
              MenuButton(
                color:
                    menuPermissionList == null || menuPermissionList.length < 8
                        ? Colors.purple
                        : Utils.fromHex(menuPermissionList[7].color),
                icon: Icon(
                  menuPermissionList == null || menuPermissionList.length < 8
                      ? Icons.view_carousel
                      : fetchIcons(menuPermissionList[7], Icons.view_carousel),
                  color: Colors.white,
                  size: 35,
                ),
                label:
                    menuPermissionList == null || menuPermissionList.length < 8
                        ? AppString.the_mall_menu
                        : getDisplayName(
                            menuPermissionList[7], AppString.the_mall_menu),
                enabled: enabled,
                cubic: _getCubic(AppString.the_mall_menu),
                onPressed: () {
                  Navigator.pop(context, AppString.the_mall_menu);
                  // App.pushTo(
                  //   context: context,
                  //   screen: MallServices(),
                  // );
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuButton(
                color:
                    menuPermissionList == null || menuPermissionList.length < 9
                        ? Colors.blue
                        : Utils.fromHex(menuPermissionList[8].color),
                icon: Icon(
                  menuPermissionList == null || menuPermissionList.length < 9
                      ? Icons.map
                      : fetchIcons(menuPermissionList[8], Icons.map),
                  color: Colors.white,
                  size: 35,
                ),
                label:
                    menuPermissionList == null || menuPermissionList.length < 8
                        ? AppString.mall_map_menu
                        : getDisplayName(
                            menuPermissionList[8], AppString.mall_map_menu),
                enabled: enabled,
                cubic: _getCubic(AppString.mall_map_menu),
                onPressed: () {
                  Navigator.pop(context, AppString.mall_map_menu);
                  // App.pushTo(
                  //   context: context,
                  //   screen: MapScreen(),
                  // );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatefulWidget {
  final Color color;
  final Widget icon;
  final String label;
  final bool enabled;
  final Cubic cubic;
  final Function onPressed;

  const MenuButton(
      {Key key,
      this.color,
      this.icon,
      this.label,
      this.enabled,
      this.cubic,
      this.onPressed})
      : super(key: key);

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    double size = widget.enabled ? 90 : 6;
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Hero(
          tag: widget.label,
          // flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {

          // } ,
          // createRectTween: (begin, end) {
          //   return CustomRectTween(begin: begin, end: end, cubic: cubic);
          // },
          // transitionOnUserGestures: true,
          child: GestureDetector(
            onTap: widget.enabled ? () => widget.onPressed() : null,
            child: Container(
              height: size,
              width: size,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: widget.color),
              child: widget.enabled
                  ? Center(
                      child: Wrap(
                        children: [
                          Center(child: widget.icon),
                          widget.label.isEmpty
                              ? const SizedBox()
                              : const SizedBox(
                                  height: 4,
                                ),
                          widget.label.isEmpty
                              ? const SizedBox()
                              : Center(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      widget.label,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );

    // Column(
    //   children: [
    //     SizedBox(
    //       height: widget.label.isNotEmpty ? 15 : 0,
    //     ),
    //     Expanded(
    //       flex: 0,
    //       child: Align(
    //           alignment: widget.label.isNotEmpty
    //               ? Alignment.bottomCenter
    //               : Alignment.center,
    //           child: widget.icon),
    //     ),
    //     widget.label.isNotEmpty
    //         ? Expanded(
    //       child: Container(
    //         margin: EdgeInsets.only(top: 5),
    //         child: Material(
    //           color: Colors.transparent,
    //           child: Text(
    //             widget.label,
    //             textAlign: TextAlign.center,
    //             maxLines: 1,
    //             style: TextStyle(
    //                 color: Colors.white, fontSize: 12),
    //             overflow: TextOverflow.ellipsis,
    //             softWrap: false,
    //           ),
    //         ),
    //       ),
    //     )
    //         : Visibility(
    //       visible: widget.label.isNotEmpty,
    //       child: Container(
    //         margin: EdgeInsets.only(top: 5),
    //         child: Text(
    //           widget.label,
    //           textAlign: TextAlign.center,
    //           maxLines: 1,
    //           style: TextStyle(
    //               color: Colors.white, fontSize: 12),
    //           overflow: TextOverflow.ellipsis,
    //           softWrap: false,
    //         ),
    //       ),
    //     )
    //   ],
    // )

    // return ClipOval(
    //   child: Material(
    //     color: Colors.transparent,
    //     child: Hero(
    //       tag: widget.label,
    //       // flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
    //
    //       // } ,
    //       // createRectTween: (begin, end) {
    //       //   return CustomRectTween(begin: begin, end: end, cubic: cubic);
    //       // },
    //       // transitionOnUserGestures: true,
    //       child: GestureDetector(
    //         onTap: widget.enabled ? () => widget.onPressed() : null,
    //         child: Container(
    //           height: size,
    //           width: size,
    //           clipBehavior: Clip.antiAlias,
    //           decoration:
    //           BoxDecoration(shape: BoxShape.circle, color: widget.color),
    //           child: widget.enabled
    //               ? Column(
    //             children: [
    //               SizedBox(
    //                 height: widget.label.isNotEmpty ? 15 : 0,
    //               ),
    //               Expanded(
    //                 flex: 0,
    //                 child: Align(
    //                     alignment: widget.label.isNotEmpty
    //                         ? Alignment.bottomCenter
    //                         : Alignment.center,
    //                     child: widget.icon),
    //               ),
    //               widget.label.isNotEmpty
    //                   ? Expanded(
    //                 child: Container(
    //                   margin: EdgeInsets.only(top: 5),
    //                   child: Material(
    //                     color: Colors.transparent,
    //                     child: Text(
    //                       widget.label,
    //                       textAlign: TextAlign.center,
    //                       maxLines: 1,
    //                       style: TextStyle(
    //                           color: Colors.white, fontSize: 12),
    //                       overflow: TextOverflow.ellipsis,
    //                       softWrap: false,
    //                     ),
    //                   ),
    //                 ),
    //               )
    //                   : Visibility(
    //                 visible: widget.label.isNotEmpty,
    //                 child: Container(
    //                   margin: EdgeInsets.only(top: 5),
    //                   child: Text(
    //                     widget.label,
    //                     textAlign: TextAlign.center,
    //                     maxLines: 1,
    //                     style: TextStyle(
    //                         color: Colors.white, fontSize: 12),
    //                     overflow: TextOverflow.ellipsis,
    //                     softWrap: false,
    //                   ),
    //                 ),
    //               )
    //             ],
    //           )
    //               : SizedBox.shrink(),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class CustomRectTween extends RectTween {
  Cubic _cubic;

  CustomRectTween({Rect begin, Rect end, Cubic cubic})
      : super(begin: begin, end: end) {
    _cubic = cubic;
  }

  @override
  Rect lerp(double t) {
    double height = end.top - begin.top;
    double width = end.left - begin.left;

    double transformedY = _cubic.transform(t);

    double animatedX = begin.left + (t * width);
    double animatedY = begin.top + (transformedY * height);

    // double startWidthCenter = begin.left + (begin.width / 2);
    // double startHeightCenter = begin.top + (begin.height / 2);

    return Rect.fromLTWH(animatedX, animatedY, width, height);
  }
}
