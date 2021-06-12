import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/home/view/whatson_widget.dart';
import 'package:wayawaya/screens/login.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';

import '../../config.dart';
import '../../constants.dart';
import 'bloc/home_bloc.dart';
import 'model/top_campaign_model.dart';
import 'view/common_image_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeBloc.getAllCampaign();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Container(
            height: App.height(context),
            width: App.width(context),
            child: Stack(
              children: [
                AnimateAppBar(
                  title: AppString.home.toUpperCase(),
                  isSliver: true,
                  floating: false,
                  pinned: true,
                  snap: false,
                  onSnowTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Login()),
                  ),
                  children: [
                    SliverFillRemaining(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: StreamBuilder<List<TopCampaignModel>>(
                                  initialData: [],
                                  stream: _homeBloc.topStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.data.isEmpty) {
                                      return Image.asset(
                                        AppImages.icon_placeholder,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    int size = snapshot.data.length % 2 == 0
                                        ? (snapshot.data.length / 2).round()
                                        : ((snapshot.data.length / 2) + 1)
                                            .round();
                                    debugPrint(
                                        "TransformerPageView_debugPrintSize  ${snapshot.data.length}  ${snapshot.data.length % 2 == 0}     ${(snapshot.data.length / 2).round()}    ${((snapshot.data.length / 2) + 1).round()}");

                                    return TransformerPageView(
                                        loop: false,
                                        viewportFraction: 1.5,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // if (index == 0) {
                                          //   return WhatsonWidget(
                                          //     topCampaignModelPositionOne:
                                          //     snapshot.data.length >
                                          //         (index + index + 1)
                                          //         ? snapshot.data[
                                          //     (index + index + 1)]
                                          //         : null,
                                          //     topCampaignModelPositionZero:
                                          //     snapshot.data.length >
                                          //         (index + index)
                                          //         ? snapshot.data[
                                          //     (index + index)]
                                          //         : null,
                                          //   );
                                          // }
                                          return Container(
                                            width:200,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: CommonImageWidget(
                                                    imgUrl: snapshot
                                                                .data.length >
                                                            (index + index)
                                                        ? snapshot
                                                            .data[
                                                                (index + index)]
                                                            .imgUrl
                                                        : null,
                                                    tag: snapshot.data.length >
                                                            (index + index)
                                                        ? snapshot
                                                            .data[
                                                                (index + index)]
                                                            .tag
                                                        : null,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CommonImageWidget(
                                                    imgUrl: snapshot
                                                                .data.length >
                                                            (index + index + 1)
                                                        ? snapshot
                                                            .data[(index +
                                                                index +
                                                                1)]
                                                            .imgUrl
                                                        : null,
                                                    tag: snapshot.data.length >
                                                            (index + index + 1)
                                                        ? snapshot
                                                            .data[(index +
                                                                index +
                                                                1)]
                                                            .tag
                                                        : null,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        itemCount:
                                            (snapshot.data.length / 2).round());
                                  }),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: StreamBuilder<List<String>>(
                                  initialData: [],
                                  stream: _homeBloc.activityStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.data.isEmpty) {
                                      return Image.asset(
                                        AppImages.icon_placeholder,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    return TransformerPageView(
                                        loop: false,
                                        // transformer: new AccordionTransformer(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return CommonImageWidget(
                                              imgUrl: snapshot.data[index]);
                                        },
                                        itemCount: snapshot.data.length);
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // SliverToBoxAdapter(
                    //   child: Container(
                    //     height: 3 * App.height(context) / 5,
                    //     color: appDarkColor,
                    //     child: Slide(),
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: Container(
                    //     height: 2 * App.height(context) / 6,
                    //     color: Colors.redAccent,
                    //     child: Image.network(
                    //       'https://why5research.com/wp-content/uploads/2018/11/Untitled-design-1.png',
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container gestureV({String text}) {
    return Container(
      height: 100,
      width: text == 'Menu' ? 60 : 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/touch_u.png',
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Container(
            height: 50,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container gestureH({String text}) {
    return Container(
      height: 50,
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 50,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/touch_r.png',
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
