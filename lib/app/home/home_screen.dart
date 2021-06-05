import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/screens/login.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/widgets/slidable.dart';

import '../../config.dart';
import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
                    SliverToBoxAdapter(
                      child: Container(
                        height: 3 * App.height(context) / 5,
                        color: appDarkColor,
                        child: Slide(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 2 * App.height(context) / 6,
                        color: Colors.redAccent,
                        child: Image.network(
                          'https://why5research.com/wp-content/uploads/2018/11/Untitled-design-1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),

                ///GESTURES GUIDE
                // Visibility(
                //   visible: true,
                //   child: InkWell(
                //     onTap: () {
                //     },
                //     child: Container(
                //       height: App.height(context),
                //       width: App.width(context),
                //       padding: const EdgeInsets.all(20),
                //       decoration: BoxDecoration(
                //         color: Colors.black.withOpacity(0.66),
                //       ),
                //       child: Stack(
                //         children: [
                //           Positioned(
                //             left: 0,
                //             child: gestureV(text: 'Menu'),
                //           ),
                //           Align(
                //             alignment: Alignment.topCenter,
                //             child: Padding(
                //               padding: const EdgeInsets.only(
                //                   top: 0, bottom: 20, left: 20),
                //               child: gestureH(text: 'Change Mall'),
                //             ),
                //           ),
                //           Positioned(
                //             right: 0,
                //             child: gestureV(text: 'Account Details'),
                //           ),
                //           Positioned(
                //             right: 0,
                //             top: 160,
                //             child: gestureV(text: 'Swipe to view more offers'),
                //           ),
                //           Positioned(
                //             right: 0,
                //             top: 300,
                //             child: gestureV(text: 'Swipe to view more events'),
                //           ),
                //           Align(
                //             alignment: Alignment.bottomCenter,
                //             child: Padding(
                //               padding: const EdgeInsets.only(bottom: 10),
                //               child: gestureV(text: 'Swipe to view more ads'),
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
