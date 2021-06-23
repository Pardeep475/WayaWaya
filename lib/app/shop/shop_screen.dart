import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/shop/bloc/shop_bloc.dart';
import 'package:wayawaya/app/shop/view/shop_category.dart';
import 'package:wayawaya/app/shop/view/shop_favourate.dart';
import 'package:wayawaya/app/shop/view/shop_listing.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/widgets/expandable_fab.dart';

import '../../constants.dart';

class ShopScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  ShopBloc _shopBloc;

  @override
  void initState() {
    _shopBloc = ShopBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Outside build method
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF0F0F0),
        body: StreamBuilder<List<MainMenuPermission>>(
            initialData: [],
            stream: _shopBloc.mainMenuPermissionStream,
            builder: (context, snapshot) {
              return AnimateAppBar(
                title: AppString.shops,
                isSliver: true,
                mainMenuPermissions: snapshot.data,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SliverFillRemaining(
                    child: StreamBuilder<int>(
                        initialData: 0,
                        stream: _shopBloc.listTypeStream,
                        builder: (context, snapshot) {
                          debugPrint('testing_index:-  ${snapshot.data}');
                          return PageView.builder(
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            onPageChanged: (index) {},
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                debugPrint('testing_index:-  zero');
                                return ShopListingScreen();
                              } else if (index == 1) {
                                debugPrint('testing_index:-  first');
                                return ShopCategoryScreen();
                                // return Stack(
                                //   children: [
                                //     IgnorePointer(
                                //       ignoring: _fab,
                                //       child: CustomScrollView(
                                //         controller: _alphaController,
                                //         slivers: [
                                //           SliverList(
                                //             delegate:
                                //                 SliverChildBuilderDelegate(
                                //               (BuildContext context,
                                //                   int index) {
                                //                 return _favs[index];
                                //               },
                                //               childCount: _favs.length,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //     Container(
                                //       child: QuickScrollBar(
                                //         nameList: exampleList,
                                //         scrollController: _alphaController,
                                //       ),
                                //     ),
                                //   ],
                                // );
                              } else {
                                debugPrint('testing_index:-  else');
                                return ShopFavouriteScreen();
                                // return Stack(
                                //   children: [
                                //     IgnorePointer(
                                //       ignoring: _fab,
                                //       child: CustomScrollView(
                                //         controller: _alphaController,
                                //         slivers: [
                                //           SliverList(
                                //             delegate:
                                //                 SliverChildBuilderDelegate(
                                //               (BuildContext context,
                                //                   int index) {
                                //                 return _favs[index];
                                //               },
                                //               childCount: _favs.length,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //     Container(
                                //       child: QuickScrollBar(
                                //         nameList: exampleList,
                                //         scrollController: _alphaController,
                                //       ),
                                //     ),
                                //   ],
                                // );
                              }
                            },
                          );
                        }),
                  ),
                ],
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CircularMenu(
          alignment: Alignment.bottomCenter,
          startingAngleInRadian: 1.05 * pi,
          endingAngleInRadian: 1.96 * pi,
          reverseCurve: Curves.bounceIn,
          toggleButtonColor: appLightColor,
          toggleButtonMargin: 0,
          toggleButtonPadding: 12,
          toggleButtonSize: 40,
          radius: 95,
          items: [
            CircularMenuItem(
              padding: 18,
              icon: Icons.sort_by_alpha,
              onTap: () {
                _pageController.animateToPage(
                  0,
                  duration: Duration(microseconds: 100),
                  curve: Curves.easeInOut,
                );
                // _shopBloc.listTypeSink.add(0);
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (_) => ShopRestList(
                //       title: 'Restaurant',
                //     ),
                //   ),
                // );
              },
              color: appLightColor,
              iconColor: Colors.white,
            ),
            CircularMenuItem(
              padding: 18,
              icon: Icons.list,
              onTap: () {
                _pageController.animateToPage(
                  1,
                  duration: Duration(microseconds: 500),
                  curve: Curves.easeInOut,
                );

                // _shopBloc.listTypeSink.add(1);
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (_) => ShopRestCategory(
                //       title: 'Restaurant',
                //     ),
                //   ),
                // );
              },
              color: appLightColor,
              iconColor: Colors.white,
            ),
            CircularMenuItem(
              padding: 18,
              icon: Icons.thumb_up,
              onTap: () {
                _pageController.animateToPage(
                  2,
                  duration: Duration(microseconds: 100),
                  curve: Curves.easeInOut,
                );
                // _shopBloc.listTypeSink.add(2);
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (_) => ShopRestFav(
                //       title: 'Restaurant',
                //     ),
                //   ),
                // );
              },
              color: appLightColor,
              iconColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
