import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/screens/offer_details.dart';
import 'package:wayawaya/screens/rewards/menu.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import '../constants.dart';
import 'map/mall_map.dart';

class OffersList extends StatefulWidget {
  const OffersList({Key key}) : super(key: key);

  @override
  _OffersListState createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {
  bool _hasRewards = true;

  Widget offerCard(int index) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => OfferDetails(
                  offerName: 'Nedbank',
                )),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 5, left: 5, right: 5),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(blurRadius: 2, color: Colors.grey, spreadRadius: 2)
          ],
        ),
        child: Wrap(
          children: [
            Container(
              height: 170,
              width: double.infinity,
              child: Image.network(
                'https://www.cbia.com/wp-content/uploads/2020/05/Social-Distancing.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nedbank',
                    style: GoogleFonts.ubuntuCondensed().copyWith(
                      color: black.withOpacity(0.7),
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Text('27-Nov'),
                                ],
                              ),
                              SizedBox(
                                height: 5,
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
                                  Text('04-Oct'),
                                ],
                              ),
                            ],
                          ),
                        ),

                        ///BUTTONS
                        Expanded(
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _hasRewards
                                    ? InkWell(
                                        onTap: () => errorDialog(),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 11),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.gift,
                                                color: black,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Redeem'.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                                InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => MapScreen()),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.mapMarkerAlt,
                                        color: black,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Locate'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 11,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 1,
                                      ),
                                      Icon(
                                        Icons.share,
                                        color: black,
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Text(
                                        'Share'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  errorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Container(
          child: Text(
            'You need to visit the mall to earn points.',
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
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MenuNew(
      title: 'OFFERS',
      children: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return offerCard(index);
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
