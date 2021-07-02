import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/search/model/global_app_search.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/dimens.dart';

class RestaurantItemView extends StatelessWidget {
  final GlobalAppSearch globalAppSearch;

  RestaurantItemView({this.globalAppSearch});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // debug
        },
        child: Container(
          height: Dimens.eightyFive,
          child: Row(
            children: [
              Container(
                width: Dimens.seventyFive,
                child: Center(
                  child: Icon(
                    Icons.restaurant_menu,
                    size: Dimens.thirtyFive,
                    color: Colors.black54,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimens.three,
                      bottom: Dimens.one,
                      left: Dimens.five,
                      right: Dimens.three),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        globalAppSearch.heading,
                        style: GoogleFonts.ubuntuCondensed().copyWith(
                          color: AppColor.black.withOpacity(0.7),
                          fontSize: Dimens.nineteen,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.8,
                        ),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: Dimens.ten,
                      ),
                      Text(
                        _fetchItemDescription(),
                        style: GoogleFonts.ubuntu().copyWith(
                          color: AppColor.black.withOpacity(0.5),
                          fontSize: Dimens.twelve,
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
  }

  String _fetchItemDescription() {
    String description = '';
    try {
      dynamic value = jsonDecode(globalAppSearch.description);
      if (value == null) return '';
      value.forEach((element) {
        if (element['language'] == 'en_US') {
          description = element['text'];
          return;
        }
      });
      return description;
    } catch (e) {}
    return description;
  }
}
