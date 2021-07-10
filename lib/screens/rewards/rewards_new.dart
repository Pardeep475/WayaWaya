import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/dialogs/common_not_at_venue_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/constants.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/screens/rewards/bloc/rewards_bloc.dart';
import 'package:wayawaya/screens/rewards/model/rewards_categories.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
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
      _rewardsBloc.fetchMenuButtons();
      _rewardsBloc.fetchRewardsCategory();
      _rewardsBloc.fetchRewardsList();

      _showNotAtVenueDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
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
                                    maxWidth: MediaQuery.of(context).size.width,
                                  ),
                                  color: Color(0xFFF0F0F0),
                                  child: RotatedBox(
                                    quarterTurns: -1,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: ListWheelScrollView.useDelegate(
                                        itemExtent: itemWidth,
                                        controller: _controller,
                                        squeeze: 1,
                                        onSelectedItemChanged: (val) {
                                          _rewardsBloc
                                              .updateRewardsCategory(val);
                                        },
                                        childDelegate:
                                            ListWheelChildLoopingListDelegate(
                                          children: List<Widget>.generate(
                                            snapshot.data != null &&
                                                    snapshot.data.isNotEmpty
                                                ? snapshot.data.length
                                                : 8,
                                            (index) => Center(
                                              child: RotatedBox(
                                                quarterTurns: 1,
                                                child: ItemCategoryOval(
                                                  index: index,
                                                  rewardsCategory:
                                                      snapshot.data != null &&
                                                              snapshot.data
                                                                  .isNotEmpty
                                                          ? snapshot.data[index]
                                                          : null,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
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
                                        height:
                                            MediaQuery.of(context).size.height,
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
                                        return SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) => ItemRewards(
                                              index: index,
                                              campaign:
                                                  snapshot.data.data[index],
                                              size: snapshot.data.data.length,
                                            ),
                                            childCount:
                                                snapshot.data.data.length,
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
                                          title: AppString.login.toUpperCase(),
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
      height: 150,
      width: text == 'Menu' ? 60 : 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 50,
            margin: EdgeInsets.only(bottom: 20),
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
            height: 50,
            child: Text(
              text.toUpperCase(),
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
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            margin: EdgeInsets.only(top: 10, right: 10),
            width: 100,
            alignment: Alignment.centerLeft,
            child: Text(
              text.toUpperCase(),
              textAlign: TextAlign.left,
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
                  AppImages.touch_u,
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
