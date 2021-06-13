import 'dart:convert';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/search/model/global_app_search.dart';
import 'package:wayawaya/utils/app_color.dart';

class ShopItemView extends StatelessWidget {
  final GlobalAppSearch globalAppSearch;

  ShopItemView({this.globalAppSearch});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // debug
        },
        child: Container(
          height: 85,
          child: Row(
            children: [
              Container(
                width: 75,
                child: Center(
                  child: Icon(
                    CommunityMaterialIcons.shopping_music,
                    size: 35,
                    color: Colors.black54,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(top: 3, bottom: 1, left: 5, right: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        globalAppSearch.heading,
                        style: GoogleFonts.ubuntuCondensed().copyWith(
                          color: AppColor.black.withOpacity(0.7),
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
                        _fetchItemDescription(),
                        style: GoogleFonts.ubuntu().copyWith(
                          color: AppColor.black.withOpacity(0.5),
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
