import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/widgets/custom_app_bar.dart';
import 'package:wayawaya/widgets/search_all.dart';
import 'package:wayawaya/widgets/search_events.dart';
import 'package:wayawaya/widgets/search_offers.dart';
import 'package:wayawaya/widgets/search_restaurants.dart';
import 'package:wayawaya/widgets/search_shops.dart';

import '../../constants.dart';
import 'bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
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
  SearchBloc _searchBloc;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  String searchQuery = '';

  @override
  void initState() {
    _scrollController = new ScrollController();
    super.initState();
    _searchBloc = SearchBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchBloc.fetchMenuButtons();
      _initAnimation();
    });
  }

  _initAnimation() {
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

    animationController.addListener(() {
      debugPrint('pardeep_testing');
      // setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('pardeep_testing: -  build method called');
    searchQuery = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF0F0F0),
        body: Stack(
          children: [
            DefaultTabController(
              length: 5,
              initialIndex: 0,
              child: CustomScrollView(
                controller: _scrollController,
                physics: NeverScrollableScrollPhysics(),
                slivers: [
                  StreamBuilder<List<MainMenuPermission>>(
                      initialData: [],
                      stream: _searchBloc.mainMenuPermissionStream,
                      builder: (context, snapshot) {
                        return MyAppBar(
                          title: 'HOME /\nSEARCH-$searchQuery'.toUpperCase(),
                          padding: EdgeInsets.only(left: 10, top: 0),
                          pinned: true,
                          mainMenuPermissionList: snapshot.data,
                          centerTitle: false,
                          lastIcon: IconButton(
                            icon: Icon(
                              Icons.youtube_searched_for_outlined,
                              size: 34,
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
                                  onTap: (position) {},
                                  tabs: [
                                    Text(AppString.all),
                                    Text(AppString.offers),
                                    Text(AppString.events),
                                    Text(AppString.shops),
                                    Text(AppString.restaurant),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: TabBarView(
                      children: [
                        SearchAll(
                          searchQuery: searchQuery,
                        ),
                        SearchOffers(
                          searchQuery: searchQuery,
                        ),
                        SearchEvents(
                          searchQuery: searchQuery,
                        ),
                        SearchShops(
                          searchQuery: searchQuery,
                        ),
                        SearchRestaurants(
                          searchQuery: searchQuery,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
