import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'bloc/mall_bloc.dart';

class MallScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MallScreenState();
}

class _MallScreenState extends State<MallScreen> {
  MallBloc _mallBloc;

  @override
  void initState() {
    super.initState();
    _mallBloc = MallBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _mallBloc.getMallData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryDark,
        centerTitle: true,
        title: const Text(
          AppString.select_your_default_mall,
          style: const TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: const DecorationImage(
            image: const AssetImage(
              'assets/SplashScreen_BG.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<List<MallProfileModel>>(
            initialData: [],
            stream: _mallBloc.mallProfileStream,
            builder: (context, snapshot) {
              return ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (_, index) {
                    return Container(
                      height: 6,
                      color: const Color(0xff397C85).withOpacity(0.2),
                    );
                  },
                  itemBuilder: (_, index) {
                    debugPrint(
                        'image_data_testing:-  ${snapshot.data[index].logo_base64}');

                    return InkWell(
                      onTap: () {
                        // App.prefs.setBool('defaultMall', true);
                        // App.prefs.setString('selectedMall', getMallName(index).toString());
                        // printR(App.prefs.getString('selectedMall').toString());
                        // widget.onlyChangeMall ? Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        //   builder: (_) => Splash(),
                        // ), (route) => false) : Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        //   builder: (_) => BackgroundScreen(),
                        // ), (route) => false);
                      },
                      child: Container(
                        height: 125,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xff6CD1D5).withOpacity(0.5),
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 80,
                              width: 90,
                              margin: const EdgeInsets.only(left: 20),
                              child: Image.memory(base64
                                  .decode(snapshot.data[index].logo_base64)),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(right: 2),
                                child: Text(
                                  snapshot.data[index].name ?? "",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }

//  ListView.separated(
//             itemCount: 12,
//             separatorBuilder: (_, index) {
//               return Container(
//                 height: 6,
//                 color: appDarkColor.withOpacity(0.2),
//               );
//             },
//             itemBuilder: (_, index) {
//               return InkWell(
//                 onTap: () {
//                   App.prefs.setBool('defaultMall', true);
//                   App.prefs.setString('selectedMall', getMallName(index).toString());
//                   printR(App.prefs.getString('selectedMall').toString());
//                   widget.onlyChangeMall ? Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
//                     builder: (_) => Splash(),
//                   ), (route) => false) : Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
//                     builder: (_) => BackgroundScreen(),
//                   ), (route) => false);
//                 },
//                 child: Container(
//                   height: 125,
//                   width: App.width(context),
//                   color: Color(0xff6CD1D5).withOpacity(0.5),
//                   margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: 80,
//                         width: 90,
//                         margin: EdgeInsets.only(left: 20),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             fit: BoxFit.contain,
//                             image: AssetImage(
//                               getMallLogo(index).toString(),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 30,
//                       ),
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.only(right: 2),
//                           child: Text(
//                             getMallName(index).toString(),
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             })
}
