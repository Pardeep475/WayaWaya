import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../../config.dart';
import '../../constants.dart';
import 'bloc/two_d_map_bloc.dart';

class TwoDMapScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TwoDMapScreen();
}

class _TwoDMapScreen extends State<TwoDMapScreen> {
  bool gesturesVisible = true;
  bool shopSearch = false;
  bool showBLO = false;

  TwoDMapBloc _twoDMapBloc;

  WebViewPlusController _controller;
  double _height = 1;

  @override
  void initState() {
    super.initState();
    _twoDMapBloc = TwoDMapBloc();
  }

  @override
  Widget build(BuildContext context) {
    String floorId = ModalRoute.of(context).settings.arguments;
    _twoDMapBloc.getMapUrl(floorId);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Stack(
          children: [
            AnimateAppBar(
              title: 'MAP',
              isSliver: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SliverFillRemaining(
                  child: WebViewPlus(
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (controller) {
                      this._controller = controller;
                      controller
                          .loadUrl('assets/map/twodmap/vectormap/mod.html');
                    },
                    onProgress: (value){

                    },
                    onWebResourceError: (error){
                      debugPrint('error_web_view_is    ${error.errorType}');
                      debugPrint('error_web_view_is    ${error.errorCode}');
                      debugPrint('error_web_view_is    ${error.description}');
                    },
                    onPageFinished: (url) {
                      _controller.getHeight().then((double height) {
                        print("Height:  " + height.toString());
                        setState(() {
                          _height = height;
                        });
                      });
                    },
                    // initialUrl:
                    //     'assets/map/twodmap/vectormap/mod.html',
                  ),
                )

                // SliverToBoxAdapter(
                //   child: Container(
                //     height: App.height(context),
                //     width: App.width(context),
                //     child: Stack(
                //       children: [
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Container(
                //               color: white,
                //               height: App.height(context),
                //               child: PhotoView(
                //                 backgroundDecoration:
                //                     BoxDecoration(color: white),
                //                 imageProvider:
                //                     AssetImage("assets/about_mall.jpg"),
                //               ),
                //             ),
                //           ],
                //         ),
                //         Positioned(
                //           top: 20.0,
                //           left: 15.0,
                //           child: Column(
                //             children: [
                //               Container(
                //                 height: 20,
                //                 width: 20,
                //                 decoration: BoxDecoration(
                //                   color: Colors.black,
                //                   borderRadius: BorderRadius.circular(4.0),
                //                 ),
                //                 child: Center(
                //                   child: Icon(
                //                     Icons.add,
                //                     color: Colors.white,
                //                     size: 16,
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 height: 5,
                //               ),
                //               Container(
                //                 height: 20,
                //                 width: 20,
                //                 decoration: BoxDecoration(
                //                   color: Colors.black,
                //                   borderRadius: BorderRadius.circular(4.0),
                //                 ),
                //                 child: Center(
                //                   child: Container(
                //                     height: 1.5,
                //                     width: 6,
                //                     color: Colors.white,
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //         Align(
                //           alignment: Alignment.center,
                //           child: Container(
                //             height: 100,
                //             margin: EdgeInsets.only(top: 60),
                //             child: Column(
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 Container(
                //                   height: 28,
                //                   width: 90,
                //                   margin: EdgeInsets.only(left: 80),
                //                   decoration: BoxDecoration(
                //                     color: Colors.black87,
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(3)),
                //                   ),
                //                   child: Center(
                //                     child: Text(
                //                       'Fashion World',
                //                       style: TextStyle(
                //                         color: white,
                //                         fontSize: 12,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 Icon(
                //                   Icons.location_pin,
                //                   color: Colors.red[800],
                //                   size: 60,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),

            ///Shop Menu
            // Visibility(
            //   visible: shopSearch,
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Container(
            //         height: 110,
            //         width: App.width(context),
            //         margin: EdgeInsets.only(bottom: 60),
            //         padding: EdgeInsets.only(right: 20),
            //         child: GridView.builder(
            //           itemCount: 8,
            //           shrinkWrap: true,
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 5,
            //             crossAxisSpacing: 0.0,
            //             mainAxisSpacing: 12.0,
            //             childAspectRatio: 1.7,
            //           ),
            //           itemBuilder: (BuildContext context, int index) {
            //             return Container(
            //               height: 20,
            //               width: 10,
            //               margin: EdgeInsets.only(right: 5),
            //               child: CircleAvatar(
            //                 backgroundColor: appLightColor,
            //                 radius: 20,
            //                 child: Image.asset(
            //                   'assets/ic_${index + 1}.png',
            //                   height: 20,
            //                   width: 20,
            //                 ),
            //               ),
            //             );
            //           },
            //         )),
            //   ),
            // ),

            ///Blo Menu
            // Visibility(
            //   visible: showBLO,
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: Container(
            //         height: 170,
            //         width: App.width(context),
            //         padding: EdgeInsets.only(bottom: 50, right: 10),
            //         child: Row(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             Container(
            //               height: 45,
            //               width: 45,
            //               child: CircleAvatar(
            //                 backgroundColor: Color(0xff3949AB),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Icon(
            //                       Icons.image_search_sharp,
            //                       color: Colors.white,
            //                       size: 20,
            //                     ),
            //                     Text(
            //                       "F1",
            //                       style: TextStyle(
            //                         fontSize: 10.0,
            //                         fontWeight: FontWeight.w600,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               width: 15,
            //             ),
            //             Container(
            //               height: 45,
            //               width: 45,
            //               child: CircleAvatar(
            //                 backgroundColor: Color(0xff3949AB),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Icon(
            //                       Icons.image_search_sharp,
            //                       color: Colors.white,
            //                       size: 20,
            //                     ),
            //                     Text(
            //                       "F2",
            //                       style: TextStyle(
            //                         fontSize: 10.0,
            //                         fontWeight: FontWeight.w600,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               width: 15,
            //             ),
            //             Container(
            //               height: 60,
            //               width: 60,
            //               child: CircleAvatar(
            //                 backgroundColor: Color(0xff3949AB),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Icon(
            //                       Icons.food_bank_rounded,
            //                       color: Colors.white,
            //                       size: 26,
            //                     ),
            //                     Text(
            //                       "BLO",
            //                       style: TextStyle(
            //                         fontSize: 10.0,
            //                         fontWeight: FontWeight.w600,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ],
            //         )),
            //   ),
            // ),

            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     color: Color(0xff8E929E),
            //     width: App.width(context),
            //     height: 65,
            //     padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.max,
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: <Widget>[
            //         FloatingActionButton(
            //           heroTag: 'shop',
            //           backgroundColor: Color(0xff3949AB),
            //           onPressed: () {
            //             setState(() {
            //               showBLO = false;
            //               shopSearch = !shopSearch;
            //             });
            //           },
            //           child: Icon(
            //             Icons.image_search_sharp,
            //             color: Colors.white,
            //           ),
            //         ),
            //         FloatingActionButton(
            //           heroTag: 'menu',
            //           backgroundColor: Color(0xff3949AB),
            //           onPressed: () {
            //             setState(() {
            //               shopSearch = false;
            //               showBLO = !showBLO;
            //             });
            //           },
            //           child: Icon(
            //             Icons.food_bank_rounded,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: 20,
            //   left: 75,
            //   child: Visibility(
            //     visible: shopSearch,
            //     child: Container(
            //       height: 30,
            //       width: 70,
            //       decoration: BoxDecoration(
            //         color: Colors.black45,
            //         borderRadius: BorderRadius.all(Radius.circular(4)),
            //       ),
            //       child: Center(
            //         child: Text(
            //           'Category',
            //           style: TextStyle(
            //             color: white,
            //             fontSize: 12,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: 20,
            //   right: 75,
            //   child: Visibility(
            //     visible: showBLO,
            //     child: Container(
            //       height: 30,
            //       width: 70,
            //       decoration: BoxDecoration(
            //         color: Colors.black45,
            //         borderRadius: BorderRadius.all(Radius.circular(4)),
            //       ),
            //       child: Center(
            //         child: Text(
            //           'Menu',
            //           style: TextStyle(
            //             color: white,
            //             fontSize: 12,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            ///GESTURES
            // Visibility(
            //   visible: gesturesVisible,
            //   child: InkWell(
            //     onTap: () {
            //       setState(() {
            //         gesturesVisible = false;
            //       });
            //     },
            //     child: Container(
            //       height: App.height(context),
            //       width: App.width(context),
            //       decoration: BoxDecoration(
            //         color: Colors.black.withOpacity(0.66),
            //       ),
            //       child: Stack(
            //         children: [
            //           Align(
            //             alignment: Alignment.center,
            //             child: Padding(
            //               padding: const EdgeInsets.only(top: 150),
            //               child: gestureV(
            //                   text: 'Swipe and Zoom to find your shop'),
            //             ),
            //           ),
            //           Positioned(
            //             left: 20,
            //             bottom: 0,
            //             child: gestureH(text: 'View Categories or servies'),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Container gestureV({String text}) {
    return Container(
      height: 100,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(top: 6, left: 4),
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
            height: 100,
            margin: EdgeInsets.only(left: 15),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
