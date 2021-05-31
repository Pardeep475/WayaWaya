import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/screens/shops_and_rest_list.dart';
import 'package:wayawaya/widgets/custom_app_bar.dart';
import 'package:wayawaya/widgets/expandable_fab.dart';

import '../config.dart';
import '../constants.dart';
import 'map/mall_map.dart';
import 'offers_list.dart';
import 'search_page.dart';
import 'shops_and_rest_details.dart';
import 'shops_rest_fav.dart';

class ShopRestCategory extends StatefulWidget {
  final String title;

  const ShopRestCategory({Key key, this.title}) : super(key: key);
  @override
  _ShopRestCategoryState createState() => _ShopRestCategoryState();
}

class _ShopRestCategoryState extends State<ShopRestCategory> {
  bool showSearch = false;
  bool _fab = false;
  TextEditingController _searchController = TextEditingController();

  searchBar() {
    return Container(
      height: 50,
      color: white,
      width: App.width(context),
      child: Row(
        children: [
          ///Back Button
          InkWell(
            onTap: () {
              setState(() {
                showSearch = false;
              });
              FocusScope.of(context).unfocus();
              _searchController.clear();
            },
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.grey[700],
                  ),
                  CircleAvatar(
                    backgroundColor: white,
                    radius: 20,
                    foregroundImage: AssetImage(
                      'assets/menu_app_ic.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 100,
              child: TextField(
                autofocus: true,
                onSubmitted: (val) {
                  setState(() {
                    showSearch = false;
                  });
                  FocusScope.of(context).unfocus();
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => SearchPage(
                            searchTerm: _searchController.text,
                          ),
                        ),
                      )
                      .whenComplete(() => _searchController.clear());
                },
                controller: _searchController,
                cursorHeight: 25,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => _searchController.clear(),
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF0F0F0),
        body: Stack(
          children: [
            IgnorePointer(
              ignoring: _fab,
              child: CustomScrollView(
                slivers: [
                  MyAppBar(
                    title: '${widget.title} /\nCATEGORY',
                    padding: EdgeInsets.only(left: 0, top: 13),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ExpandableCards(
                          index: index,
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                ],
              ),
            ),

            ///SEARCH
            Align(
              alignment: Alignment.topCenter,
              child: Visibility(
                visible: showSearch,
                child: searchBar(),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CircularMenu(
          alignment: Alignment.bottomCenter,
          startingAngleInRadian: 1.05 * pi,
          endingAngleInRadian: 1.96 * pi,
          reverseCurve: Curves.bounceIn,
          toggleButtonColor: appLightColor,
          toggleButtonMargin: 0,
          toggleButtonPadding: 12,
          toggleButtonSize: 40,
          radius: 95,
          items: [
            CircularMenuItem(
              padding: 18,
              icon: Icons.sort_by_alpha,
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => ShopRestList(
                            title: widget.title,
                          ))),
              color: appLightColor,
              iconColor: Colors.white,
            ),
            CircularMenuItem(
              padding: 18,
              icon: Icons.list,
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => ShopRestCategory(
                            title: widget.title,
                          ))),
              color: appLightColor,
              iconColor: Colors.white,
            ),
            CircularMenuItem(
              padding: 18,
              icon: Icons.thumb_up,
              onTap: () => App.pushTo(
                  context: context,
                  screen: ShopRestFav(
                    title: widget.title,
                  )),
              color: appLightColor,
              iconColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

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
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ShopRestDetails(
            title: title,
            subtitle:
                'ABSA is one of South Africa\'s largest banks, serving personal, commercial and corporate.',
            liked: true,
          ),
        ),
      ),
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
                            color: white,
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
                              color: white,
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
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => OffersList()),
                                      ),
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
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => MapScreen()),
                                      ),
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
                                          // _isLiked[index] = !_isLiked[index];
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.thumb_up,
                                            color: true ? appLightColor : black,
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
