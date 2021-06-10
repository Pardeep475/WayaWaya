import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/screens/login.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/widgets/slidable.dart';

import '../../config.dart';
import '../../constants.dart';
import 'bloc/home_bloc.dart';

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
                              child: TransformerPageView(
                                  loop: false,
                                  // transformer: new AccordionTransformer(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return new Container(
                                      color: index == 0
                                          ? Colors.teal
                                          : index == 1
                                              ? Colors.yellow
                                              : index == 3
                                                  ? Colors.red
                                                  : Colors.blueGrey,
                                      child: new Center(
                                        child: new Text(
                                          "$index",
                                          style: new TextStyle(
                                              fontSize: 80.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: 3),
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
                                    return TransformerPageView(
                                        loop: false,
                                        // transformer: new AccordionTransformer(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // debugPrint(
                                          //     'Image_activity:-   ${imageData['image_id']}');
                                          return CachedNetworkImage(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            imageUrl: snapshot.data[index],
                                            fit: BoxFit.fill,
                                          );
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
