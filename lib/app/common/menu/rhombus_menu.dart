import 'package:flutter/material.dart';

import 'menu_button.dart';

class RhombusMenu extends StatelessWidget {
  final bool enabled;
  final Animation<double> animation;

  const RhombusMenu({Key key, @required this.enabled, this.animation})
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
                  size: 30,
                ),
                label: "Home",
                enabled: enabled,
                cubic: _getCubic("Home"),
                onPressed: () {
                  // App.pushTo(
                  //   context: context,
                  //   screen: HomeScreen(),
                  // );
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
                  // App.pushTo(
                  //   context: context,
                  //   screen: OffersList(),
                  // );
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
                  // App.pushTo(
                  //   context: context,
                  //   screen: ShopRestList(title: "SHOPS"),
                  // );
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
                  // App.pushTo(
                  //   context: context,
                  //   screen: QRScanner(),
                  // );
                },
              ),
              MenuButton(
                color: Colors.yellow,
                icon: Icon(
                  Icons.restaurant,
                  color: Colors.white,
                  size: 35,
                ),
                label: "Restaurants",
                enabled: enabled,
                cubic: _getCubic("Restaurants"),
                onPressed: () {
                  Navigator.pop(context);
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
                  // App.pushTo(
                  //   context: context,
                  //   screen: RewardsBrowser(),
                  // );
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