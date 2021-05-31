import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config.dart';
import '../../constants.dart';
import 'menu.dart';
import 'menunew.dart';

class RewardsWallet extends StatefulWidget {
  const RewardsWallet({Key key}) : super(key: key);

  @override
  _RewardsWalletState createState() => _RewardsWalletState();
}

class _RewardsWalletState extends State<RewardsWallet> {
  List<Icon> iconsList = [
    Icon(
      Icons.local_offer,
      size: 40,
      color: Colors.grey[700],
    ),
    Icon(
      Icons.touch_app,
      size: 40,
      color: Colors.grey[700],
    ),
    Icon(
      Icons.location_pin,
      size: 40,
      color: Colors.grey[700],
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MenuNew(
          title: 'Rewards',
          centerTitle: true,
          padding: EdgeInsets.only(right: 40, top: 20),
          titleSize: 16,
          children: [
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                width: App.width(context),
                margin: EdgeInsets.only(bottom: 10),
                constraints: BoxConstraints(
                  maxHeight: 200,
                  maxWidth: App.width(context),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/rewards.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    width: App.width(context),
                    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    child: ExpansionTile(
                      title: Container(
                        height: 70,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 5),
                              child: Text(
                                index == 0
                                    ? "December, 2021"
                                    : "November, 2021",
                                style: GoogleFonts.ubuntu().copyWith(
                                  fontSize: 18,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0, left: 20),
                              child: Text(
                                'V',
                                style: TextStyle(
                                  color: black.withOpacity(0.8),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            "Balance",
                            style: GoogleFonts.ubuntu().copyWith(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "10",
                            style: GoogleFonts.ubuntu().copyWith(
                              fontSize: 26,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      children: [
                        Container(
                          height: index == 0 ? 60 : 180,
                          width: App.width(context),
                          child: ListView.builder(
                            itemCount: index == 0 ? 1 : 3,
                            itemBuilder: (context, ind) {
                              return Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey[100], width: 1),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 35.0,
                                      top: 10.0,
                                      bottom: 2.0),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            iconsList[ind],
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "30, December",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  ind == 0
                                                      ? 'Daily App Open'
                                                      : "View Offer",
                                                  style: GoogleFonts.ubuntu()
                                                      .copyWith(
                                                    fontSize: 15,
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(
                                          "7",
                                          style: GoogleFonts.ubuntu().copyWith(
                                            fontSize: 26,
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 2,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 50,
          color: bgColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding:
                              EdgeInsets.only(bottom: 20, right: 30),
                          titlePadding: EdgeInsets.only(bottom: 20),
                          title: Container(
                            width: double.maxFinite,
                            child: Text(
                              'Rewards Usage',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          content: Container(
                            width: double.maxFinite,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Find Rewards',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 3),
                                    child: Text(
                                      '1.Click on the Rewards menu button\n2.You are presented with ALL the available rewards\n3.You can search for rewards within specific categories such as “ Food andDrink”, selectable by sliding through the category slider and clicking on the category of interest.\n4.You can further reset the filter to “ALL”\n5.You can find your Rewards Wallet by clicking that option.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Earn Points',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 3),
                                    child: Text(
                                      '1.We reward you for using the Connect Waya-Waya App. See Points Awarded section\n2.On entering a participating shop, ask for the QR code, and scan it to earn points.\n3.The QR Code scan option, is located on your middle menu button, click and scan.\n4.Note: You do need to physically be at the mall and inside the shop, to scan for points.\n5.Points scanned are immediately added to your Rewards Wallet, accessible from the Rewards screen.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Redeem Points',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 3),
                                    child: Text(
                                      '1.When you find a Reward you are interested in, you can click the Waya-Waya FISTPUMP icon, to initiate the reward.\n2.A GREEN FISTPUMP will indicate you have sufficient points to redeem the Reward.\n3.A RED FISTPUMP indicates you still need to earn more points.\n4.You can click the Reward and open the Rewards Detail page, and from there redeem the reward.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Rewards Wallet',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 3),
                                    child: Text(
                                      '1.The Rewards wallet, shows you how many points you have, as well as how many points you have redeemed.\n2.You will also see your Monthly totals of points balance.\n3.Click each month to expand it, and examine transaction details.he shop, to scan for points.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Points Awards Rules',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin:
                                              EdgeInsets.only(left: 25, top: 5),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 1),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                (index == 0)
                                                    ? 'Open the APP'
                                                    : (index == 1)
                                                        ? 'View a Promotion'
                                                        : (index == 2)
                                                            ? 'View Ads or Offers'
                                                            : (index == 3)
                                                                ? 'Visit a Store'
                                                                : 'Visit the Mall',
                                                style: GoogleFonts.spartan()
                                                    .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "-More than 1 times a week and earn 5 points",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  )),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "-More than 1 times a week and earn 5 points",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                  "-More than 1 times a week and earn 5 points",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  )),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "Points can only be earned once per day",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.red),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Ok ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.normal,
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
            ],
          ),
        ),
      ),
    );
  }
}
