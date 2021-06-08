import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/screens/map/mall_map.dart';
import 'package:wayawaya/screens/rewards/qr_code_scanner.dart';
import 'package:wayawaya/utils/app_color.dart';

import '../../config.dart';
import '../events_list.dart';
import '../home.dart';
import '../mall_servies.dart';
import '../offers_list.dart';
import '../shops_and_rest_list.dart';
import 'rewards_new.dart';

class MenuTile extends StatelessWidget {
  List<MainMenuPermission> _itemList = [];

  MenuTile({Key key, List<MainMenuPermission> itemList}) {
    this._itemList = itemList;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'main_menu_permission_testing:-----  MenuTile ${_itemList != null ? _itemList.length : 'null'}');
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
                  menuPermissionList: _itemList,
                );
              })),
      child: Container(
        margin: EdgeInsets.only(left: 4.0),
        height: 50,
        width: 50,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppColor.primary),
        child: RhombusMenu(
          enabled: false,
          menuPermissionList: _itemList,
        ),
      ),
    );
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
                color: Colors.amber,
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 35,
                ),
                label: "Home",
                enabled: enabled,
                cubic: _getCubic("Home"),
                onPressed: () {
                  App.pushTo(
                    context: context,
                    screen: HomeScreen(),
                  );
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuButton(
                color: Colors.blue,
                icon: Icon(
                  Icons.local_offer,
                  color: Colors.white,
                  size: 35,
                ),
                label: "Offers",
                enabled: enabled,
                cubic: _getCubic("Offers"),
                onPressed: () {
                  Navigator.pop(context);
                  App.pushTo(
                    context: context,
                    screen: OffersList(),
                  );
                },
              ),
              MenuButton(
                color: Colors.purple,
                icon: Icon(
                  Icons.event,
                  color: Colors.white,
                  size: 35,
                ),
                label: "Events",
                enabled: enabled,
                cubic: _getCubic("Events"),
                onPressed: () {
                  Navigator.pop(context);
                  App.pushTo(
                    context: context,
                    screen: EventsList(),
                  );
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuButton(
                color: Colors.green,
                icon: Icon(
                  Icons.shop,
                  color: Colors.white,
                  size: 35,
                ),
                label: "Shops",
                enabled: enabled,
                cubic: _getCubic("Shops"),
                onPressed: () {
                  Navigator.pop(context);
                  App.pushTo(
                    context: context,
                    screen: ShopRestList(title: "SHOPS"),
                  );
                },
              ),
              MenuButton(
                color: Colors.white,
                icon: Image.asset(
                  'assets/qr_scan.png',
                  height: 45,
                  width: 45,
                ),
                label: "",
                enabled: enabled,
                cubic: _getCubic("Connect"),
                onPressed: () {
                  Navigator.pop(context);
                  App.pushTo(
                    context: context,
                    screen: QRScanner(),
                  );
                },
              ),
              MenuButton(
                color: Colors.yellow,
                icon: Icon(
                  Icons.restaurant,
                  // getIconUsingPrefix(name: 'fa-cutlery'),
                  color: Colors.white,
                  size: 35,
                ),
                label: "Restaurants",
                enabled: enabled,
                cubic: _getCubic("Restaurants"),
                onPressed: () {
                  Navigator.pop(context);
                  App.pushTo(
                    context: context,
                    screen: ShopRestList(title: "My RESTAURANTS"),
                  );
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuButton(
                color: Colors.red,
                icon: Icon(
                  Icons.local_offer_rounded,
                  color: Colors.white,
                  size: 35,
                ),
                label: "Rewards",
                enabled: enabled,
                cubic: _getCubic("Rewards"),
                onPressed: () {
                  Navigator.pop(context);
                  App.pushTo(
                    context: context,
                    screen: RewardsBrowser(),
                  );
                },
              ),
              MenuButton(
                color: Colors.purple,
                icon: Icon(
                  Icons.panorama_wide_angle,
                  color: Colors.white,
                  size: 35,
                ),
                label: "The Mall",
                enabled: enabled,
                cubic: _getCubic("The Mall"),
                onPressed: () {
                  Navigator.pop(context);
                  App.pushTo(
                    context: context,
                    screen: MallServices(),
                  );
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuButton(
                color: Colors.blue,
                icon: Icon(
                  Icons.map,
                  color: Colors.white,
                  size: 35,
                ),
                label: "Mall Map",
                enabled: enabled,
                cubic: _getCubic("Mall Map"),
                onPressed: () {
                  Navigator.pop(context);
                  App.pushTo(
                    context: context,
                    screen: MapScreen(),
                  );
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
                          const SizedBox(
                            height: 4,
                          ),
                          Center(
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
