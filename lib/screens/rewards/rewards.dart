import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/config.dart';
import 'package:wayawaya/constants.dart';
import 'package:wayawaya/screens/rewards/menu.dart';
import 'package:wayawaya/screens/rewards/qr_code_scanner.dart';
import 'package:wayawaya/utils/app_images.dart';

import 'menunew.dart';

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  bool ontap = false;
  List<Icon> iconsList = [Icon(Icons.local_offer), Icon(Icons.phone_android)];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: MenuNew(
          title: 'REWARDS',
          children: [
            SliverToBoxAdapter(
              child: Container(
                height: App.height(context) / 3,
                width: App.width(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          width: App.width(context),
                          child: Image.asset(
                            AppImages.rewards,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Rewards Rules',
                                        textAlign: TextAlign.left,
                                      ),
                                      content: Container(
                                        width: double.maxFinite,
                                        child: Scrollbar(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Expanded(
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: 5,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  width: 1),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                (index == 0)
                                                                    ? 'Open the APP'
                                                                    : (index ==
                                                                            1)
                                                                        ? 'View a Promotion'
                                                                        : (index ==
                                                                                2)
                                                                            ? 'View Ads or Offers'
                                                                            : (index == 3)
                                                                                ? 'Visit a Store'
                                                                                : 'Visit the Mall',
                                                                style: GoogleFonts
                                                                        .spartan()
                                                                    .copyWith(
                                                                  letterSpacing:
                                                                      0.25,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                  "-More than 1 times a week and earn 5 points",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey,
                                                                  )),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                  "-More than 1 times a week and earn 5 points",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    color: Colors
                                                                        .grey,
                                                                  )),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                  "-More than 1 times a week and earn 5 points",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    color: Colors
                                                                        .grey,
                                                                  )),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                "Points can only be earned once per day",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.0,
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                )
                                              ]),
                                        ),
                                      ),
                                      actions: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Ok ",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )),
                                                )),
                                            height: 30,
                                            width: App.width(context),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.info_outline,
                              size: 30,
                            ),
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey[300], width: 1),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4, right: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Membership",
                                  style: GoogleFonts.ubuntuCondensed().copyWith(
                                    color: black.withOpacity(0.7),
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                Text(
                                  "0",
                                  style: GoogleFonts.ubuntu().copyWith(
                                    color: black.withOpacity(0.5),
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => QRScanner()),
                          ),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[400], width: 1),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.qrcode,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Scan QR Code for earning points",
                                      style: GoogleFonts.ubuntuCondensed()
                                          .copyWith(
                                        color: black.withOpacity(0.6),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.8,
                                      ),
                                      overflow: TextOverflow.clip,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
