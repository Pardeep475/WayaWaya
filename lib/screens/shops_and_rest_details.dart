import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/screens/map/mall_map.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';

import '../config.dart';
import '../constants.dart';

class ShopRestDetails extends StatefulWidget {
  @required
  final String title;
  @required
  final String subtitle;
  @required
  final bool liked;

  const ShopRestDetails({this.title, this.subtitle, this.liked});

  @override
  _ShopRestDetailsState createState() => _ShopRestDetailsState();
}

class _ShopRestDetailsState extends State<ShopRestDetails> {
  bool _liked = false;
  int _current = 0;

  Widget listIcons() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Color(0xff0A82B4),
            margin: EdgeInsets.fromLTRB(2, 10, 0, 4),
            padding: EdgeInsets.only(left: 10, right: 8),
            height: 45,
            width: 50,
            child: Center(
              child: Text(
                'The Tropical Bloem Plaza Tuition Centre',
                style: TextStyle(
                  color: white,
                  fontSize: 5,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.globe,
              color: Colors.grey[700],
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.phoneAlt,
              color: Colors.grey[700],
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.facebookF,
              color: Colors.grey[700],
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.twitter,
              color: Colors.grey[700],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget data() {
    return Container(
      width: App.width(context),
      padding: EdgeInsets.only(left: 5, right: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? 'Bloem Plaza Tuition Centre',
            style: GoogleFonts.ubuntuCondensed().copyWith(
              color: black.withOpacity(0.7),
              fontSize: 19,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            widget.subtitle ??
                'The tuition centre at Bloem Plaza offers Cambridge international Education IGCSE, AS and A-level Certificates grades 8 to 12 and post matric. Products offered IGCSE certification, AS and A level certification, High school qualification',
            style: GoogleFonts.ubuntu().copyWith(
              color: black.withOpacity(0.5),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _liked = widget.liked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MenuNew(
      title: widget.title,
      pinned: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              CarouselSlider.builder(
                itemCount: 2,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://ict-smart.com/wp-content/uploads/2020/08/pexels-photo-936722.jpeg'))),
                  );
                },
                options: CarouselOptions(
                  height: App.height(context) / 3.3,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                      print(index + reason.index);
                    });
                  },
                ),
              ),
              Positioned(
                  width: App.width(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (index) {
                      return Container(
                        height: 10,
                        width: 10,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: _current == index
                              ? Colors.grey
                              : Colors.grey[700],
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  )),
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.location_on,
                          size: 30,
                          color: white,
                        ),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => MapScreen()))),
                    IconButton(
                        icon: Icon(
                          Icons.share,
                          size: 26,
                          color: white,
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(
                          Icons.thumb_up,
                          size: 26,
                          color: _liked ? appLightColor : white,
                        ),
                        onPressed: () {
                          setState(() {
                            _liked = !_liked;
                            print(_liked);
                          });
                        }),
                  ],
                ),
              ),
              Positioned(
                  top: 0,
                  child: SizedBox(
                    height: 16,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        print(index);
                        return Container(
                          margin: EdgeInsets.all(8),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
        SliverFillRemaining(
          child: Container(
            height: App.height(context) / 2,
            width: App.width(context),
            padding: EdgeInsets.only(right: 5, top: 3),
            child: Row(
              children: [
                listIcons(),
                Expanded(child: data()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
