import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/custom_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/network/local/event_logger_service.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'bloc/search_bloc.dart';
import 'views/search_all.dart';
import 'views/search_events.dart';
import 'views/search_offers.dart';
import 'views/search_restaurants.dart';
import 'views/search_shops.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();

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
      EventLoggerService.eventLogger(
          uuid: EventLoggerService.GlobalSearch,
          action: EventLoggerService.LOG_TYPE_SEARCH,
          type: EventLoggerService.LOG_TYPE_SEARCH,
          group: EventLoggerService.LOG_GROUP_PERFORMED_ACTION,
          data: searchQuery);
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
                        return CustomAppBar(
                          title: 'HOME /\nSEARCH-$searchQuery'.toUpperCase(),
                          padding: EdgeInsets.only(left: Dimens.ten, top: 0),
                          pinned: true,
                          isSliver: false,
                          mainMenuPermissionList: snapshot.data,
                          centerTitle: false,
                          lastIcon: IconButton(
                            icon: Icon(
                              Icons.youtube_searched_for_outlined,
                              size: Dimens.thirtyFour,
                              color: AppColor.colored_text,
                            ),
                            onPressed: () {
                              _searchBloc.searchSink.add(true);
                            },
                          ),
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(Dimens.fiftyEight),
                            child: Container(
                              color: AppColor.white,
                              padding: EdgeInsets.only(
                                top: Dimens.one,
                              ),
                              height: Dimens.fiftyFour,
                              child: Container(
                                color: Color(0xff57BABF),
                                padding: EdgeInsets.only(
                                  bottom: Dimens.four,
                                ),
                                margin: EdgeInsets.only(top: Dimens.three),
                                height: Dimens.fiftyThree,
                                child: TabBar(
                                  labelColor: Color(0xff57BABF),
                                  isScrollable: true,
                                  labelStyle: TextStyle(
                                    fontSize: Dimens.sixteen,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  unselectedLabelColor: AppColor.white,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: BoxDecoration(
                                    color: AppColor.white,
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
            StreamBuilder<bool>(
                initialData: false,
                stream: _searchBloc.searchStream,
                builder: (context, snapshot) {
                  if (snapshot.data) {
                    return searchBar();
                  } else {
                    return SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      height: Dimens.fifty,
      color: AppColor.white,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          ///Back Button
          InkWell(
            onTap: () {
              _searchBloc.searchSink.add(false);
              FocusScope.of(context).unfocus();
              _searchController.clear();
            },
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.grey[700],
                  ),
                  CircleAvatar(
                    backgroundColor: AppColor.white,
                    radius: 20,
                    foregroundImage: AssetImage(
                      AppImages.menu_app_ic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 100,
              child: TextField(
                autofocus: true,
                onSubmitted: (val) {
                  if (_searchController.text.isEmpty) return;
                  _searchBloc.searchSink.add(false);
                  FocusScope.of(context).unfocus();
                  Navigator.pushNamed(context, AppString.SEARCH_SCREEN_ROUTE,
                          arguments: _searchController.text)
                      .whenComplete(() => _searchController.clear());

                  // Navigator.of(context)
                  //     .push(
                  //       MaterialPageRoute(
                  //         builder: (_) => SearchPage(
                  //           searchTerm: _searchController.text,
                  //         ),
                  //       ),
                  //     )
                  //     .whenComplete(() => _searchController.clear());
                },
                controller: _searchController,
                cursorHeight: 25,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => _searchController.clear(),
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
