import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:upgrader/upgrader.dart';
import 'package:wayawaya/app/common/dialogs/common_exit_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/home/model/whatson_campaign.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'dart:ui' as ui;
import '../../config.dart';
import '../../constants.dart';
import 'bloc/home_bloc.dart';
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
      _homeBloc.setUpGestureHome();
      _homeBloc.fetchMenuButtons();
      _homeBloc.getAllCampaign(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Upgrader().clearSavedSettings();
    final appcastURL =
        'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android','ios']);

    return WillPopScope(
      onWillPop: () async {
        _showErrorDialog(
          context: context,
        );
        return false;
      },
      child: UpgradeAlert(
        appcastConfig: cfg,
        debugLogging: true,
        onUpdate: () {
          OpenAppstore.launch(
              androidAppId: "za.co.venueengage.waya", iOSAppId: "1515126975");
          return false;
        },
        child: SafeArea(
          top: false,
          // bottom: false,
          child: Scaffold(
            backgroundColor: AppColor.primaryDark,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: StreamBuilder<WhatsonCampaign>(
                                          initialData: null,
                                          stream: _homeBloc.topStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.data == null ||
                                                snapshot
                                                    .data.itemList.isEmpty) {
                                              return Image.asset(
                                                AppImages.icon_placeholder,
                                                fit: BoxFit.cover,
                                              );
                                            }

                                            return ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: (snapshot.data
                                                            .itemList.length /
                                                        2)
                                                    .round(),
                                                itemBuilder: (context, index) {
                                                  if (index == 0) {
                                                    debugPrint(
                                                        'testing_whatson:-  ${snapshot.data.whatsonList[0]}');
                                                    return Row(
                                                      children: [
                                                        snapshot
                                                                    .data
                                                                    .whatsonList
                                                                    .length >
                                                                0
                                                            ? SizedBox(
                                                                width: 200,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: snapshot
                                                                      .data
                                                                      .whatsonList[0],
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  imageBuilder:
                                                                      (context,
                                                                          imageProvider) {
                                                                    // imageProvider
                                                                    //     .resolve(
                                                                    //     ImageConfiguration()).addListener((_) {});
                                                                    return Container(
                                                                      width:
                                                                          200,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  placeholder:
                                                                      (context,
                                                                          url) {
                                                                    return Container(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              new AlwaysStoppedAnimation<Color>(AppColor.primaryDark),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  errorWidget:
                                                                      (context,
                                                                          url,
                                                                          error) {
                                                                    return Image
                                                                        .asset(
                                                                      AppImages
                                                                          .icon_placeholder,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    );
                                                                  },
                                                                ),
                                                              )
                                                            : SizedBox(),
                                                        Container(
                                                          height: MediaQuery.of(
                                                                  context)
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
                                                                          .itemList[(index +
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
                                                                          .itemList[(index +
                                                                              index)]
                                                                          .tag
                                                                      : null,
                                                                  campaign: snapshot
                                                                              .data
                                                                              .itemList
                                                                              .length >
                                                                          (index +
                                                                              index)
                                                                      ? snapshot
                                                                          .data
                                                                          .itemList[(index +
                                                                              index)]
                                                                          .campaign
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
                                                                          .itemList[(index +
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
                                                                          .itemList[(index +
                                                                              index +
                                                                              1)]
                                                                          .tag
                                                                      : null,
                                                                  campaign: snapshot
                                                                              .data
                                                                              .itemList
                                                                              .length >
                                                                          (index +
                                                                              index +
                                                                              1)
                                                                      ? snapshot
                                                                          .data
                                                                          .itemList[(index +
                                                                              index +
                                                                              1)]
                                                                          .campaign
                                                                      : null,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }

                                                  return Container(
                                                    height:
                                                        MediaQuery.of(context)
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
                                                            campaign: snapshot
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
                                                                    .campaign
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
                                                            campaign: snapshot
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
                                                                    .campaign
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
                                      height:
                                          MediaQuery.of(context).size.height,
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
                                                itemCount:
                                                    snapshot.data.length);
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
                  StreamBuilder<bool>(
                      initialData: false,
                      stream: _homeBloc.gestureHomeStream,
                      builder: (context, snapshot) {
                        if (snapshot.data) {
                          return InkWell(
                            onTap: () async {
                              SessionManager.setGestureHome(false);
                              _homeBloc.gestureHomeSink.add(false);
                            },
                            child: Container(
                              height: App.height(context),
                              width: App.width(context),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.66),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: Dimens.sixtyFive,
                                    left: Dimens.ten,
                                    child: gestureV(text: AppString.menu),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: Dimens.fifty,
                                          left: Dimens.thirty),
                                      child: gestureH(
                                          text: AppString.account_detail),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: Dimens.sixtyFive,
                                    child:
                                        gestureV(text: AppString.change_mall),
                                  ),
                                  Positioned(
                                    right: Dimens.thirty,
                                    top: Dimens.twoHundred,
                                    child: gestureV(
                                        text: AppString
                                            .swipe_to_view_more_offers),
                                  ),
                                  Positioned(
                                    right: Dimens.thirty,
                                    top: MediaQuery.of(context).size.height / 2,
                                    child: gestureV(
                                        text: AppString
                                            .swipe_to_view_more_events),
                                  ),
                                  Positioned(
                                    bottom: Dimens.seventy,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.bottomCenter,
                                      child: gestureV(
                                          text:
                                              AppString.swipe_to_view_more_ads),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return SizedBox();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showErrorDialog({
    BuildContext context,
  }) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonExitDialog(
                onPressed: (value) {
                  if (value) {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  } else {
                    Navigator.pop(context);
                  }
                },
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

  Container gestureV({String text}) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Dimens.fiftyFive,
            width: Dimens.fiftyFive,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.touch_u,
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Container(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.white,
                fontSize: Dimens.twentyTwo,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.white,
              fontSize: Dimens.twentyTwo,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: Dimens.ten,
          ),
          Container(
            height: Dimens.fiftyFive,
            width: Dimens.fiftyFive,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.touch_r,
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
