import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/screens/map/mall_map.dart';
import 'package:wayawaya/screens/rewards/menu.dart';
import '../config.dart';
import '../constants.dart';
import 'rewards/menunew.dart';

class SearchDetails extends StatefulWidget {
  @required
  final String title;
  @required
  final String subtitle;

  const SearchDetails({this.title, this.subtitle});

  @override
  _SearchDetailsState createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
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
              onPressed: () {}),
          IconButton(
              icon: Icon(
                FontAwesomeIcons.phoneAlt,
                color: Colors.grey[700],
              ),
              onPressed: () {}),
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
            'Bloem Plaza Tuition Centre',
            style: GoogleFonts.ubuntuCondensed().copyWith(
              color: black.withOpacity(0.7),
              fontSize: 19,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
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
  Widget build(BuildContext context) {
    return MenuNew(
      title: '',
      padding: EdgeInsets.only(left: 70, top: 5),
      physics: NeverScrollableScrollPhysics(),
      pinned: true,
      children: [
        SliverToBoxAdapter(
          child: Container(
            height: App.height(context) / 3.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://ict-smart.com/wp-content/uploads/2020/08/pexels-photo-936722.jpeg',
                ),
                fit: BoxFit.cover,
              ),
            ),
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
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => MapScreen()))),
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
                      color: white,
                    ),
                    onPressed: () {}),
              ],
            ),
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
