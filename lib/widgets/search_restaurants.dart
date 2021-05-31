import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/screens/search_details.dart';
import '../constants.dart';

class SearchRestaurants extends StatefulWidget {
  const SearchRestaurants({Key key}) : super(key: key);

  @override
  _SearchRestaurantsState createState() => _SearchRestaurantsState();
}

class _SearchRestaurantsState extends State<SearchRestaurants> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: ListView.builder(
        itemCount: 2,
        key: PageStorageKey('rest'),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SearchDetails(
                title: 'Die Rool Vingerhead',
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
                          Icons.restaurant_menu,
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
                              'Die Rool Vingerhead',
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

