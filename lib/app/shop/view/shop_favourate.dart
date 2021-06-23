import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/widgets/scroll_bar.dart';

import '../../../constants.dart';

class ShopFavouriteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopFavouriteScreenState();
}

class _ShopFavouriteScreenState extends State<ShopFavouriteScreen> {
  bool showDiamond = false;
  bool showSearch = false;
  bool _fab = false;
  List<String> alphabet = [];
  List<bool> _isLiked;
  ScrollController _alphaController;
  List<Widget> _favs = [];
  List exampleList = [];

  @override
  void initState() {
    exampleList = [
      'Anya Ostrem',
      'Burt Hutchison',
      'Chana Sobolik',
      'Chasity Nutt',
      'Deana Tenenbaum',
      'Denae Cornelius',
      'Elisabeth Saner',
      'Eloise Rocca',
      'Eloy Kallas',
      'Esther Hobby',
      'Euna Sulser',
      'Florinda Convery',
      'Franklin Nottage',
      'Gale Nordeen',
      'Garth Vanderlinden',
      'Gracie Schulte',
      'Inocencia Eaglin',
      'Jillian Germano',
      'Jimmy Friddle',
      'Juliann Bigley',
      'Kia Gallaway',
      'Larhonda Ariza',
      'Larissa Reichel',
      'Lavone Beltz',
      'Lazaro Bauder',
      'Len Northup',
      'Leonora Castiglione',
      'Lynell Hanna',
      'Madonna Heisey',
      'Marcie Borel',
      'Margit Krupp',
      'Marvin Papineau',
      'Mckinley Yocom',
      'Melita Briones',
      'Moses Strassburg',
      'Nena Recalde',
      'Norbert Modlin',
      'Onita Sobotka',
      'Raven Ecklund',
      'Robert Waldow',
      'Roxy Lovelace',
      'Rufina Chamness',
      'Saturnina Hux',
      'Shelli Perine',
      'Sherryl Routt',
      'Soila Phegley',
      'Tamera Strelow',
      'Tammy Beringer',
      'Vesta Kidd',
      'Yan Welling'
    ];
    alphabet = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    _isLiked = List.filled(exampleList.length, true, growable: true);
    for (int i = 0; i < 3; i++) {
      setState(() {
        _favs.add(customCard(i));
      });
    }
    printY('FAVS ${_favs.length}');

    super.initState();
  }

  Widget customCard(int index) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (_) => ShopRestDetails(
        //       title: exampleList[index],
        //       subtitle:
        //       'ABSA is one of South Africa\'s largest banks, serving personal, commercial and corporate.',
        //       liked: _isLiked[index],
        //     ),
        //   ),
        // );
      },
      child: Container(
        height: 180,
        margin: EdgeInsets.only(top: 6, left: 2),
        child: Card(
          margin: EdgeInsets.only(left: 4),
          color: Color(0xffFAFAFA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 240,
                width: 6,
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.orange : Colors.blue[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
              ),
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
                            color: white,
                            margin: EdgeInsets.only(right: 4),
                            child: Image.network(
                              index % 2 == 0
                                  ? 'https://www.cbia.com/wp-content/uploads/2020/05/Social-Distancing.png'
                                  : 'https://www.cdc.gov/handwashing/images/twitter-cards/poster-handwashing.jpg',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 120,
                              color: white,
                              padding:
                              EdgeInsets.only(left: 5, top: 8, right: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exampleList[index],
                                    style:
                                    GoogleFonts.ubuntuCondensed().copyWith(
                                      color: black.withOpacity(0.7),
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
                                      color: black.withOpacity(0.8),
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
                                            color: black,
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
                                            color: black,
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
                                          _isLiked[index] = !_isLiked[index];
                                          _favs.removeAt(index);
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.thumb_up,
                                            color: _isLiked[index]
                                                ? appLightColor
                                                : black,
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
    return Stack(
      children: [
        IgnorePointer(
          ignoring: _fab,
          child: CustomScrollView(
            controller: _alphaController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return _favs[index];
                  },
                  childCount: _favs.length,
                ),
              ),
            ],
          ),
        ),
        Container(
          child: QuickScrollBar(
            nameList: exampleList,
            scrollController: _alphaController,
          ),
        ),
      ],
    );
  }
}
