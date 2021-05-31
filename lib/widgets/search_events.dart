import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/screens/search_details.dart';
import '../constants.dart';

class SearchEvents extends StatefulWidget {
  const SearchEvents({Key key}) : super(key: key);

  @override
  _SearchEventsState createState() => _SearchEventsState();
}

class _SearchEventsState extends State<SearchEvents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: ListView.builder(
        itemCount: 2,
        key: PageStorageKey('event'),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SearchDetails(
                  title: 'Welcome To Level 1 Bloem Plaza',
                  subtitle:
                      'Jet has got everything you need to get your little one ready for #backtoschool. From school shoes to school bags. head to your',
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
                          Icons.calendar_today_outlined,
                          size: 35,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 3, bottom: 1, left: 5, right: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome To Level 1 Bloem Plaza',
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
