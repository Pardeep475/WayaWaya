import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wayawaya/app/shop/model/color_codes.dart';
import 'package:wayawaya/app/shop/model/retail_with_category.dart';
import 'package:wayawaya/app/shop/model/sub_locations.dart';
import 'package:wayawaya/models/retail_unit/retail_unit_modal_db.dart';
import 'package:wayawaya/network/live/database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';

import 'profile_database_helper.dart';

class SyncService {
// sync retail unit

// make it singleton class
  SyncService._privateConstructor();

  static final SyncService instance = SyncService._privateConstructor();

  static SyncService _database;

  static syncRetailUnit() async {
    String defaultMall = await SessionManager.getDefaultMall();
    debugPrint('retail_unit_common_count:-   $defaultMall');
    List<RetailWithCategory> _retailWithCategoryList =
        await ProfileDatabaseHelper.getRetailWithCategory(
            databasePath: defaultMall,
            isShop: true,
            searchQuery: '',
            categoryId: '',
            favourite: 0);

    debugPrint(
        'retail_unit_common_count:-   ${_retailWithCategoryList.length}');
    DataBaseHelperCommon.getRetailUnitLength();
    // try {
    //   _retailWithCategoryList.forEach((element) async {
    //     RetailUnitModalDB retailUnitModalDB = RetailUnitModalDB(
    //       retailUnitId: element.id,
    //       retailUnitCategories:
    //       element.retailUnitCategories.toString(),
    //       retailUnitCategoryName: element.categoryName,
    //       retailUnitColor: colorCodesToJson(element.color),
    //       retailUnitDescription: element.description.toString(),
    //       retailUnitFavourite: element.favourite,
    //       retailUnitName: element.name,
    //       retailUnitSubLocation: subLocationsToJson(element.subLocations),
    //     );
    //     await DataBaseHelperCommon.insertRetailUnitLength(
    //         retailUnitModalDB.toJson());
    //   });
    // } catch (e) {
    //   debugPrint('retail_unit_common_count:-   $e');
    // }

    // int _retailUnitCount = await DataBaseHelperCommon.getRetailUnitLength();
    // debugPrint('retail_unit_common_count:-   $_retailUnitCount');
  }
}
