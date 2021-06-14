import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/home/model/whatson_campaign.dart';
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
      _homeBloc.fetchMenuButtons();
      _homeBloc.getAllCampaign();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.primaryDark,
          body: Container(
            height: App.height(context),
            width: App.width(context),
            child: Stack(
              children: [
                StreamBuilder<List<MainMenuPermission>>(
                    initialData: [],
                    stream: _homeBloc.mainMenuPermissionStream,
                    builder: (context, snapshot) {
                      return AnimateAppBar(
                        title: AppString.home.toUpperCase(),
                        isSliver: true,
                        floating: false,
                        pinned: true,
                        snap: false,
                        mainMenuPermissions: snapshot.data,
                        physics: const NeverScrollableScrollPhysics(),
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
                                    child: StreamBuilder<WhatsonCampaign>(
                                        initialData: null,
                                        stream: _homeBloc.topStream,
                                        builder: (context, snapshot) {
                                          if (snapshot.data == null ||
                                              snapshot.data.itemList.isEmpty) {
                                            return Image.asset(
                                              AppImages.icon_placeholder,
                                              fit: BoxFit.cover,
                                            );
                                          }

                                          return ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: (snapshot.data.itemList
                                                          .length /
                                                      2)
                                                  .round(),
                                              itemBuilder: (context, index) {
                                                if (index == 0) {
                                                  return Row(children: [
                                                    Container(
                                                      padding: EdgeInsets.only(left: 20, right: 20),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            height: 130,
                                                            child: Image.asset(
                                                              'assets/menu_app_ic.png',
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Container(
                                                            height: 130,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: white,
                                                            ),
                                                            child: Image.asset(
                                                              'assets/dobsonville.png',
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: MediaQuery.of(context)
                                                          .size
                                                          .height,
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                            CommonImageWidget(
                                                              imgUrl: snapshot
                                                                  .data
                                                                  .itemList
                                                                  .length >
                                                                  (index +
                                                                      index)
                                                                  ? snapshot
                                                                  .data
                                                                  .itemList[
                                                              (index +
                                                                  index)]
                                                                  .imgUrl
                                                                  : null,
                                                              tag: snapshot
                                                                  .data
                                                                  .itemList
                                                                  .length >
                                                                  (index +
                                                                      index)
                                                                  ? snapshot
                                                                  .data
                                                                  .itemList[
                                                              (index +
                                                                  index)]
                                                                  .tag
                                                                  : null,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child:
                                                            CommonImageWidget(
                                                              imgUrl: snapshot
                                                                  .data
                                                                  .itemList
                                                                  .length >
                                                                  (index +
                                                                      index +
                                                                      1)
                                                                  ? snapshot
                                                                  .data
                                                                  .itemList[
                                                              (index +
                                                                  index +
                                                                  1)]
                                                                  .imgUrl
                                                                  : null,
                                                              tag: snapshot
                                                                  .data
                                                                  .itemList
                                                                  .length >
                                                                  (index +
                                                                      index +
                                                                      1)
                                                                  ? snapshot
                                                                  .data
                                                                  .itemList[
                                                              (index +
                                                                  index +
                                                                  1)]
                                                                  .tag
                                                                  : null,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],);
                                                }



                                                return Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            CommonImageWidget(
                                                          imgUrl: snapshot
                                                                      .data
                                                                      .itemList
                                                                      .length >
                                                                  (index +
                                                                      index)
                                                              ? snapshot
                                                                  .data
                                                                  .itemList[
                                                                      (index +
                                                                          index)]
                                                                  .imgUrl
                                                              : null,
                                                          tag: snapshot
                                                                      .data
                                                                      .itemList
                                                                      .length >
                                                                  (index +
                                                                      index)
                                                              ? snapshot
                                                                  .data
                                                                  .itemList[
                                                                      (index +
                                                                          index)]
                                                                  .tag
                                                              : null,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child:
                                                            CommonImageWidget(
                                                          imgUrl: snapshot
                                                                      .data
                                                                      .itemList
                                                                      .length >
                                                                  (index +
                                                                      index +
                                                                      1)
                                                              ? snapshot
                                                                  .data
                                                                  .itemList[
                                                                      (index +
                                                                          index +
                                                                          1)]
                                                                  .imgUrl
                                                              : null,
                                                          tag: snapshot
                                                                      .data
                                                                      .itemList
                                                                      .length >
                                                                  (index +
                                                                      index +
                                                                      1)
                                                              ? snapshot
                                                                  .data
                                                                  .itemList[
                                                                      (index +
                                                                          index +
                                                                          1)]
                                                                  .tag
                                                              : null,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });

                                          // return TransformerPageView(
                                          //     loop: false,
                                          //     viewportFraction: 1.5,
                                          //     itemBuilder:
                                          //         (BuildContext context,
                                          //             int index) {
                                          //       // if (index == 0) {
                                          //       //   return WhatsonWidget(
                                          //       //     topCampaignModelPositionOne:
                                          //       //     snapshot.data.length >
                                          //       //         (index + index + 1)
                                          //       //         ? snapshot.data[
                                          //       //     (index + index + 1)]
                                          //       //         : null,
                                          //       //     topCampaignModelPositionZero:
                                          //       //     snapshot.data.length >
                                          //       //         (index + index)
                                          //       //         ? snapshot.data[
                                          //       //     (index + index)]
                                          //       //         : null,
                                          //       //   );
                                          //       // }
                                          //       return Container(
                                          //         width: 200,
                                          //         child: Column(
                                          //           children: [
                                          //             Expanded(
                                          //               child:
                                          //                   CommonImageWidget(
                                          //                 imgUrl: snapshot.data
                                          //                             .length >
                                          //                         (index +
                                          //                             index)
                                          //                     ? snapshot
                                          //                         .data[(index +
                                          //                             index)]
                                          //                         .imgUrl
                                          //                     : null,
                                          //                 tag: snapshot.data
                                          //                             .length >
                                          //                         (index +
                                          //                             index)
                                          //                     ? snapshot
                                          //                         .data[(index +
                                          //                             index)]
                                          //                         .tag
                                          //                     : null,
                                          //               ),
                                          //             ),
                                          //             Expanded(
                                          //               child:
                                          //                   CommonImageWidget(
                                          //                 imgUrl: snapshot.data
                                          //                             .length >
                                          //                         (index +
                                          //                             index +
                                          //                             1)
                                          //                     ? snapshot
                                          //                         .data[(index +
                                          //                             index +
                                          //                             1)]
                                          //                         .imgUrl
                                          //                     : null,
                                          //                 tag: snapshot.data
                                          //                             .length >
                                          //                         (index +
                                          //                             index +
                                          //                             1)
                                          //                     ? snapshot
                                          //                         .data[(index +
                                          //                             index +
                                          //                             1)]
                                          //                         .tag
                                          //                     : null,
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //       );
                                          //     },
                                          //     itemCount:
                                          //         (snapshot.data.length / 2)
                                          //             .round());
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
                                                  (BuildContext context,
                                                      int index) {
                                                return CommonImageWidget(
                                                    imgUrl:
                                                        snapshot.data[index]);
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
                      );
                    }),
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
