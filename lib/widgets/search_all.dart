import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/screens/search_details.dart';
import '../constants.dart';

class SearchAll extends StatefulWidget {
  const SearchAll({Key key}) : super(key: key);

  @override
  _SearchAllState createState() => _SearchAllState();
}

class _SearchAllState extends State<SearchAll> {

  getIcon(int index) {
    switch(index) {
      case 0: return Icons.local_offer;
      case 1: return Icons.calendar_today_outlined;
      case 2: return FontAwesomeIcons.play;
      case 3: return Icons.restaurant_menu;
      case 4: return Icons.restaurant_menu;
      case 5: return FontAwesomeIcons.play;
      case 6: return Icons.local_offer;
      case 7: return FontAwesomeIcons.play;
      case 8: return Icons.local_offer;
      case 9: return Icons.calendar_today_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child:
      ListView.builder(
        itemCount: 10,
        key: PageStorageKey('all'),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SearchDetails(
                title: 'Jet',
                subtitle: 'Jet has got everything you need to get your little one ready for #backtoschool. From school shoes to school bags. head to your',
              ),
              ),
            ),
            child: Card(
              child: Container(
                height: 85,
                child: Row(
                  children: [
                    Container(
                      width: 75,
                      child: Center(
                        child: Icon(
                          getIcon(index),
                          size: 35,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 3, bottom: 1, left: 5, right: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jet',
                              style: GoogleFonts.ubuntuCondensed().copyWith(
                                color: black.withOpacity(0.7),
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.8,
                              ),
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Jet has got everything you need to get your little one ready for #backtoschool. From school shoes to school bags. head to your',
                              style: GoogleFonts.ubuntu().copyWith(
                                color: black.withOpacity(0.5),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.8,
                              ),
                              overflow: TextOverflow.clip,
                              maxLines: 3,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
