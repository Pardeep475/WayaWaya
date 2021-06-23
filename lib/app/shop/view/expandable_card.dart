import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/utils/app_color.dart';

class ExpandableCards extends StatefulWidget {
  final int index;
  const ExpandableCards({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  _ExpandableCardsState createState() => _ExpandableCardsState();
}

class _ExpandableCardsState extends State<ExpandableCards> {
  bool _expanded = false;

  Widget customCard(String title) {
    return InkWell(
      // onTap: () => Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (_) => ShopRestDetails(
      //       title: title,
      //       subtitle:
      //       'ABSA is one of South Africa\'s largest banks, serving personal, commercial and corporate.',
      //       liked: true,
      //     ),
      //   ),
      // ),
      child: SizedBox(
        height: 190,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 4),
          color: Color(0xffFAFAFA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            color: AppColor.white,
                            margin: EdgeInsets.only(right: 4),
                            child: Image.network(
                              1 % 2 == 0
                                  ? 'https://www.cbia.com/wp-content/uploads/2020/05/Social-Distancing.png'
                                  : 'https://www.cdc.gov/handwashing/images/twitter-cards/poster-handwashing.jpg',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 120,
                              color: AppColor.white,
                              padding:
                              EdgeInsets.only(left: 5, top: 8, right: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style:
                                    GoogleFonts.ubuntuCondensed().copyWith(
                                       color: AppColor.black.withOpacity(0.7),
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.8,
                                    ),
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    'ABSA is one of South Africa\'s largest banks, serving personal, commercial and corporate.',
                                    style: GoogleFonts.ubuntu().copyWith(
                                      color: AppColor.black.withOpacity(0.8),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.8,
                                    ),
                                    overflow: TextOverflow.clip,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'OPEN',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///BUTTONS
                            Expanded(
                              child: Container(
                                width: 150,
                                margin: EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      // onTap: () => Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //       builder: (_) => OffersList()),
                                      // ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.local_offer,
                                            color: AppColor.black,
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            'Offers'.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      // onTap: () => Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //       builder: (_) => MapScreen()),
                                      // ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: AppColor.black,
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            'Locate'.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          // _isLiked[index] = !_isLiked[index];
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.thumb_up,
                                            color: true ? AppColor.primary : AppColor.primary,
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            'Like'.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ExpansionTile(
        trailing: Icon(
          _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          size: 40,
          color: Colors.grey[700],
        ),
        leading: Icon(
          Icons.shop,
          size: 50,
          color: Colors.grey[700],
        ),
        title: Text(
          "Car Service ${widget.index}",
          style: TextStyle(color: Colors.grey[700]),
        ),
        onExpansionChanged: (value) {
          setState(() {
            _expanded = value;
          });
        },
        backgroundColor: Colors.orange,
        collapsedBackgroundColor: Colors.orange,
        childrenPadding: EdgeInsets.all(4),
        tilePadding: EdgeInsets.all(8),
        children: List.generate(8, (index) => customCard('')),
      ),
    );
  }
}