import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/shop/bloc/shop_bloc.dart';
import 'package:wayawaya/app/shop/view/shop_category.dart';
import 'package:wayawaya/app/shop/view/shop_favourate.dart';
import 'package:wayawaya/app/shop/view/shop_listing.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/widgets/expandable_fab.dart';

import '../../constants.dart';

class ShopScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  ShopBloc _shopBloc;
  bool isLogin = false;

  @override
  void initState() {
    _checkIfLogin();
    _shopBloc = ShopBloc();
    super.initState();
  }

  _checkIfLogin() async {
    isLogin = await SessionManager.isLogin();
    setState(() {

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                            itemCount: isLogin != null && isLogin ? 3 : 2,
                            onPageChanged: (index) {},
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return ShopListingScreen();
                              } else if (index == 1) {
                                return ShopCategoryScreen();
                              } else {
                                return ShopFavouriteScreen();
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
          toggleButtonColor: AppColor.primary,
          toggleButtonMargin: 0,
          pageController: _pageController,
          toggleButtonAnimatedIconData: AnimatedIcons.menu_close,
          toggleButtonPadding: Dimens.twelve,
          toggleButtonSize: Dimens.forty,
          radius: 95,
          items: [
            CircularMenuItem(
              padding: 18,
              icon: Icons.sort_by_alpha,
              onTap: () {
                debugPrint('click on short by alpha');

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
                debugPrint('click on icon list ');
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
                debugPrint('click on favourte ');
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


