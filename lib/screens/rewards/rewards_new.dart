import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/config.dart';
import 'package:wayawaya/constants.dart';
import 'package:wayawaya/screens/rewards/details.dart';
import 'menunew.dart';
import 'rewards_slider.dart';

class RewardsBrowser extends StatefulWidget {
  const RewardsBrowser({Key key}) : super(key: key);

  @override
  _RewardsBrowserState createState() => _RewardsBrowserState();
}

class _RewardsBrowserState extends State<RewardsBrowser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          height: App.height(context),
          width: App.width(context),
          child: Stack(
            children: [
              MenuNew(
                title: 'Rewards',
                centerTitle: true,
                padding: EdgeInsets.only(right: 40, top: 20),
                titleSize: 16,
                children: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 50,
                      width: App.width(context),
                      color: Colors.grey[300],
                      padding: EdgeInsets.only(left: 22, right: 30, top: 7),
                      child: Text(
                        'See if you qualify for a Reward\nVoucher',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: RewardsSlider(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => InkWell(
                        onTap: () => App.pushTo(
                            context: context, screen: RewardsDetails()),
                        child: Container(
                          height: 250,
                          width: App.width(context),
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color(0xffF1BD80),
                                width: 3,
                              ),
                              left: BorderSide(
                                color: Color(0xffF1BD80),
                                width: 3,
                              ),
                              right: BorderSide(
                                color: Color(0xffF1BD80),
                                width: 3,
                              ),
                              bottom: index % 2 == 0
                                  ? BorderSide.none
                                  : BorderSide(
                                      color: Color(0xffF1BD80),
                                      width: 3,
                                    ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Image.asset(
                                    'assets/rewards.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                height: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Image.asset(
                                      'assets/red_fist_bump.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      '50 Points',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      childCount: 2,
                    ),
                  ),
                ],
              ),

              ///GESTURES GUIDE
              Visibility(
                visible: App.prefs.getBool('rewardGestures') ?? true,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      App.prefs.setBool('rewardGestures', false);
                    });
                  },
                  child: Container(
                    height: App.height(context),
                    width: App.width(context),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 150,
                          left: 0,
                          child: gestureH(text: 'Slide & Click'),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: gestureH(text: 'Show Detail'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: gestureV(text: 'Slide'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                  'assets/touch_u.png',
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
