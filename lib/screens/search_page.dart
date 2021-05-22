import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import 'package:wayawaya/screens/rewards/qr_code_scanner.dart';
import 'shops_and_rest_list.dart';
import '../widgets/search_all.dart';
import '../widgets/search_events.dart';
import '../widgets/search_offers.dart';
import '../widgets/search_restaurants.dart';
import '../widgets/search_shops.dart';
import '../config.dart';
import '../constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/home_menu_button.dart';
import 'home.dart';
import './rewards/rewards_new.dart';
import 'events_list.dart';
import 'mall_servies.dart';
import 'map/mall_map.dart';
import 'offers_list.dart';

class SearchPage extends StatefulWidget {
  final String searchTerm;
  const SearchPage({this.searchTerm});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  bool showMenuIcon = true;
  bool showMalls = false;
  bool backDrop = false;
  bool showDiamond = false;
  bool menuVisible = true;
  bool showSearch = false;

  ScrollController _scrollController;
  AnimationController animationController;
  Animation degHTranslationAnimation,
      degOTranslationAnimation,
      degETranslationAnimation,
      degSTranslationAnimation,
      degSCTranslationAnimation,
      degRTranslationAnimation,
      degRWTranslationAnimation,
      degTMTranslationAnimation,
      degMMTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    _scrollController = new ScrollController();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    degHTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 5.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 5.0),
    ]).animate(animationController);
    degOTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 10.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 15.0)
    ]).animate(animationController);
    degETranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 5.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 25.0)
    ]).animate(animationController);
    degSTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 5.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 35.0)
    ]).animate(animationController);
    degRTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 10.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 45.0)
    ]).animate(animationController);
    degRWTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 15.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 55.0)
    ]).animate(animationController);
    degTMTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 20.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0)
    ]).animate(animationController);
    degMMTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 25.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 75.0)
    ]).animate(animationController);
    rotationAnimation =
        Tween<double>(begin: 180.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInBack,
    ));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF0F0F0),
        body: Stack(
          children: [
            DefaultTabController(
              length: 5,
              child: CustomScrollView(
                controller: _scrollController,
                physics: NeverScrollableScrollPhysics(),
                slivers: [
                  MyAppBar(
                    title: 'HOME /\nSEARCH-${widget.searchTerm}'.toUpperCase(),
                    padding: EdgeInsets.only(left: 70, top: 5),
                    pinned: true,
                    onSnowTap: () {
                      setState(() {
                        showMalls = true;
                      });
                    },
                    lastIcon: IconButton(
                      icon: Icon(
                        Icons.youtube_searched_for_outlined,
                        size: 26,
                        color: appLightColor,
                      ),
                      onPressed: () {},
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(58),
                      child: Container(
                        color: white,
                        padding: EdgeInsets.only(
                          top: 1,
                        ),
                        height: 54,
                        child: Container(
                          color: Color(0xff57BABF),
                          padding: EdgeInsets.only(
                            bottom: 4,
                          ),
                          margin: EdgeInsets.only(top: 3),
                          height: 53,
                          child: TabBar(
                            labelColor: Color(0xff57BABF),
                            isScrollable: true,
                            labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            unselectedLabelColor: white,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              color: white,
                            ),
                            tabs: [
                              Text('ALL'),
                              Text('OFFERS'),
                              Text('EVENTS'),
                              Text('SHOPS'),
                              Text('RESTAURANT'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: TabBarView(
                      children: [
                        SearchAll(),
                        SearchOffers(),
                        SearchEvents(),
                        SearchShops(),
                        SearchRestaurants(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///MENU OPTIONS
            // MenuNew()
          ],
        ),
      ),
    );
  }
}
