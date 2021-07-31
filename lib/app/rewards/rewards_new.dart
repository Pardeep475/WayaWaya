import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/dialogs/common_not_at_venue_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/constants.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'bloc/rewards_bloc.dart';
import 'model/rewards_categories.dart';
import 'view/item_category_oval.dart';
import 'view/item_rewards.dart';
import 'view/no_rewards_available.dart';

class RewardsBrowser extends StatefulWidget {
  const RewardsBrowser({Key key}) : super(key: key);

  @override
  _RewardsBrowserState createState() => _RewardsBrowserState();
}

class _RewardsBrowserState extends State<RewardsBrowser> {
  RewardsBloc _rewardsBloc;
  int selectedIndex = 0;
  FixedExtentScrollController _controller = FixedExtentScrollController();
  double itemWidth = 80.0;

  @override
  void initState() {
    _rewardsBloc = RewardsBloc();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _rewardsBloc.setUpGestureRewards();
      _rewardsBloc.fetchMenuButtons();
      _rewardsBloc.fetchRewardsCategory();
      _rewardsBloc.fetchRewardsList();

      _showNotAtVenueDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: bgColor,
          floatingActionButton: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppString.LOYALTY_SCREEN_ROUTE);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.colored_text, shape: BoxShape.circle),
              padding: EdgeInsets.all(Dimens.five),
              child: Image.asset(
                AppImages.r_wallet,
                height: Dimens.thirtyFive,
                width: Dimens.thirtyFive,
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                StreamBuilder<List<MainMenuPermission>>(
                    initialData: [],
                    stream: _rewardsBloc.mainMenuPermissionStream,
                    builder: (context, snapshot) {
                      return AnimateAppBar(
                        title: 'Rewards'.toUpperCase(),
                        isSliver: true,
                        mainMenuPermissions: snapshot.data,
                        physics: ClampingScrollPhysics(),
                        pinned: false,
                        snap: true,
                        floating: true,
                        children: [
                          SliverToBoxAdapter(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xffE0E0E0),
                              padding: EdgeInsets.only(
                                  top: Dimens.fifteen, bottom: Dimens.fifteen),
                              child: Text(
                                AppString.quality_for_rewards,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: Dimens.eighteen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: StreamBuilder<List<RewardsCategory>>(
                                initialData: [],
                                stream: _rewardsBloc.rewardsCategoryStream,
                                builder: (context, snapshot) {
                                  debugPrint(
                                      'rewards_categories_list:-   ${snapshot.data.length}');
                                  return Container(
                                    height: Dimens.oneEightyFive,
                                    width: MediaQuery.of(context).size.width,
                                    constraints: BoxConstraints(
                                      maxHeight: Dimens.oneEightyFive,
                                      maxWidth:
                                          MediaQuery.of(context).size.width,
                                    ),
                                    color: Color(0xFFF0F0F0),
                                    child: ScrollSnapList(
                                      onItemFocus: (int index) {
                                        _rewardsBloc.fetchRewardsListByCategory(
                                            snapshot.data[index].categoryId);

                                        _rewardsBloc
                                            .updateRewardsCategory(index);
                                        _rewardsBloc.titleRewardsCategorySink
                                            .add(snapshot.data[index].name);
                                      },
                                      initialIndex: snapshot.data != null &&
                                              snapshot.data.isNotEmpty
                                          ? snapshot.data.length.toDouble()
                                          : 8.toDouble(),
                                      itemSize: Dimens.oneFifty,
                                      itemBuilder: (context, index) {
                                        return ItemCategoryOval(
                                          index: index,
                                          rewardsCategory:
                                              snapshot.data != null &&
                                                      snapshot.data.isNotEmpty
                                                  ? snapshot.data[index]
                                                  : null,
                                        );
                                      },
                                      reverse: true,
                                      itemCount: snapshot.data != null &&
                                              snapshot.data.isNotEmpty
                                          ? snapshot.data.length
                                          : 8,
                                      dynamicItemSize: true,
                                      // dynamicSizeEquation: customEquation, //optional
                                    ),
                                  );
                                }),
                          ),
                          SliverToBoxAdapter(
                            child: StreamBuilder<String>(
                                initialData: 'All',
                                stream: _rewardsBloc.titleRewardsCategoryStream,
                                builder: (context, snapshot) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                        top: Dimens.fifteen,
                                        bottom: Dimens.fifteen),
                                    child: Text(
                                      snapshot.data ?? "All",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: Dimens.eighteen,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          StreamBuilder<ApiResponse<List<Campaign>>>(
                              stream: _rewardsBloc.rewardsListStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  switch (snapshot.data.status) {
                                    case Status.LOADING:
                                      // Future.delayed(Duration(milliseconds: 200), () {
                                      //   Utils.commonProgressDialog(context);
                                      // });
                                      return SliverFillRemaining(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.transparent,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                        ),
                                      );
                                      break;
                                    case Status.COMPLETED:
                                      {
                                        debugPrint("completed");
                                        // Navigator.pop(context);
                                        if (snapshot.data.data.isEmpty) {
                                          return NoRewardsAvailable();
                                        } else {
                                          return SliverPadding(
                                            padding: EdgeInsets.only(
                                                bottom: Dimens.forty),
                                            sliver: SliverList(
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                                (context, index) => ItemRewards(
                                                  index: index,
                                                  pointShow: true,
                                                  campaign:
                                                      snapshot.data.data[index],
                                                  listOfCampaign:
                                                      snapshot.data.data,
                                                  size:
                                                      snapshot.data.data.length,
                                                ),
                                                childCount:
                                                    snapshot.data.data.length,
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      break;
                                    case Status.ERROR:
                                      {
                                        // Navigator.pop(context);
                                        Future.delayed(
                                            Duration(milliseconds: 100), () {
                                          _showErrorDialog(
                                            icon: Icon(
                                              FontAwesomeIcons
                                                  .exclamationTriangle,
                                              color: AppColor.orange_500,
                                            ),
                                            title:
                                                AppString.login.toUpperCase(),
                                            content: AppString
                                                .check_your_internet_connectivity,
                                            buttonText:
                                                AppString.ok.toUpperCase(),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          );
                                        });
                                      }
                                      break;
                                  }
                                }
                                return SliverToBoxAdapter();
                              }),
                        ],
                      );
                    }),

                //GESTURES GUIDE
                // Visibility(
                //   visible: App.prefs.getBool('rewardGestures') ?? true,
                //   child: InkWell(
                //     onTap: () {
                //       setState(() {
                //         App.prefs.setBool('rewardGestures', false);
                //       });
                //     },
                //     child: Container(
                //       height: App.height(context),
                //       width: App.width(context),
                //       padding: const EdgeInsets.all(20),
                //       decoration: BoxDecoration(
                //         color: Colors.black.withOpacity(0.5),
                //       ),
                //       child: Stack(
                //         children: [
                //           Positioned(
                //             top: 150,
                //             left: 0,
                //             child: gestureH(text: 'Slide & Click'),
                //           ),
                //           Align(
                //             alignment: Alignment.center,
                //             child: Padding(
                //               padding: const EdgeInsets.only(top: 20),
                //               child: gestureH(text: 'Show Detail'),
                //             ),
                //           ),
                //           Align(
                //             alignment: Alignment.bottomCenter,
                //             child: Padding(
                //               padding: const EdgeInsets.only(bottom: 40),
                //               child: gestureV(text: 'Slide'),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        StreamBuilder<bool>(
            initialData: false,
            stream: _rewardsBloc.gestureRewardsStream,
            builder: (context, snapshot) {
              if (snapshot.data) {
                return Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () async {
                      SessionManager.setGestureRewards(false);
                      _rewardsBloc.gestureRewardsSink.add(false);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.66),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: Dimens.twoHundred,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(right: Dimens.oneFifty),
                              child: gestureH(text: AppString.slide_and_click),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  gestureV(text: AppString.show_detail),
                                  SizedBox(
                                    height: Dimens.five,
                                  ),
                                  gestureH(text: AppString.slide)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return SizedBox();
            }),
      ],
    );
  }

  _showNotAtVenueDialog() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonNoAtVenueDialog(
                onPressed: () {
                  Navigator.pop(context);
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

  _showErrorDialog(
      {Icon icon,
      String title,
      String content,
      String buttonText,
      VoidCallback onPressed}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonErrorDialog(
                icon: icon,
                title: title,
                content: content,
                buttonText: buttonText,
                onPressed: onPressed,
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
