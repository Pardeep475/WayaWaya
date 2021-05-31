import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wayawaya/config.dart';
import 'package:wayawaya/screens/map/mall_map.dart';
import 'package:wayawaya/screens/rewards/redeem.dart';
import '../../constants.dart';
import 'menu.dart';

class RedeemVoucher extends StatefulWidget {
  const RedeemVoucher({Key key}) : super(key: key);

  @override
  _RedeemVoucherState createState() => _RedeemVoucherState();
}

class _RedeemVoucherState extends State<RedeemVoucher> {
  String convertDateTimeDisplay() {
    var displayFormatter = DateTime.parse(DateTime.now().toString());
    String displayDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(displayFormatter);
    return displayDate;
  }

  errorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
        title: Text(
          'Success',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Container(
          child: Column(
            children: [
              Text(
                'You have redeemed 5 points against the purchase The Fix.\nDate: ${convertDateTimeDisplay()}.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'If you have not shown the redemption page to the cashier, you will forfeit your points.',
              ),
              Image.asset(
                'assets/qr.png',
                height: 100,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
              child: Text(
            'OK',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => errorDialog());
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        height: App.height(context),
        width: App.width(context),
        color: white,
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xff3A4D51),
              automaticallyImplyLeading: false,
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                        onTap: () => Navigator.pop(context)),
                    Text(
                      'Offer',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Container(
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xff4C5F64),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: Center(
                        child: Text(
                          'Redeem',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: App.height(context),
                width: App.width(context),
                child: Container(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Container(
                        height: 210,
                        width: App.width(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/rewards.jpg'),
                                    fit: BoxFit.fill,
                                  )
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Text(
                                'Jet',
                                style: GoogleFonts.ubuntuCondensed().copyWith(
                                  color: black.withOpacity(0.7),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('29-Dec'),
                              ],
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text('26-Jun'),
                              ],
                            ),
                          ],
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(FontAwesomeIcons.gift, color: Colors.grey[700]),
                    Text(
                      'REDEEM',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => App.pushTo(context: context, screen: MapScreen()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      color: Colors.grey[700],
                    ),
                    Text(
                      'LOCATE',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      FontAwesomeIcons.share,
                      color: Colors.grey[700],
                    ),
                    Text(
                      'SHARE',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
