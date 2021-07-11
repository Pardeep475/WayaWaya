import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/rewards/redeem.dart';
import 'package:wayawaya/config.dart';
import 'package:wayawaya/utils/app_images.dart';
import '../../constants.dart';

class RewardsDetails extends StatefulWidget {
  const RewardsDetails({Key key}) : super(key: key);

  @override
  _RewardsDetailsState createState() => _RewardsDetailsState();
}

class _RewardsDetailsState extends State<RewardsDetails> {
  int rewardPoints = 10;
  Widget _dialog;

  redeemDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(''),
        content: Container(
          child: Text(
            'Go to the cashier and redeem the Voucher in front of them”',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              // Navigator.of(context).pop();
              App.pushTo(context: context, screen: RedeemVoucher());
            },
          ),
        ],
      ),
    );
  }

  checkPoints() {
    if (rewardPoints < 5) {
      _dialog = Container(
        height: 200,
        width: 200,
        margin: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(
              flex: 2,
            ),
            Text(
              'You need 5 points.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      printY('OK');
                    },
                  ),
                  TextButton(
                    child: Text(
                      'INFO',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      );
      return _dialog;
    } else {
      _dialog = Container(
        height: 200,
        width: 200,
        margin: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(
              flex: 2,
            ),
            Text(
              'Go to the cashier and redeem the Voucher in front of them.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  printY('OK');
                  App.pushTo(context: context, screen: RedeemVoucher());
                },
              ),
            ),
          ],
        ),
      );
      return _dialog;
    }
  }

  @override
  void initState() {
    super.initState();
    checkPoints();
  }

  @override
  Widget build(BuildContext context) {
    checkPoints();
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        height: App.height(context),
        width: App.width(context),
        color: white,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xff3A4D51),
              automaticallyImplyLeading: false,
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              size: 16,
                            ),
                            Text(
                              'Offer',
                              style:
                              TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                          ],
                        ),
                        onTap: () => Navigator.pop(context)),
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      'Reward',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        width: App.width(context),
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffF1BD80),
                            width: 3,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                child: Image.asset(
                                  AppImages.rewards,
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
                                    AppImages.red_fist_bump,
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
                      _dialog ?? Container(),
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
                onTap: () => checkPoints(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      FontAwesomeIcons.gift,
                      color: rewardPoints < 5
                          ? Colors.grey[700]
                          : Colors.green[900],
                    ),
                    Text(
                      'REDEEM',
                      style: TextStyle(
                        color: rewardPoints < 5
                            ? Colors.grey[600]
                            : Colors.green[900],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                // onTap: () => App.pushTo(context: context, screen: MapScreen()),
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
