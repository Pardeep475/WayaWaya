import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/network/local/database_helper.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_new.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_response.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_temp.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class SyncService {
  // make it singleton class
  static final SyncService _syncService = SyncService._internal();

  factory SyncService() {
    return _syncService;
  }

  SyncService._internal();

  static final _repository = ApiRepository();

  static String lastUpdate;

  static fetchAllSyncData() async{
    await setSyncDateQuery();
    await fetchUpdateData(1);
  }

  static setSyncDateQuery() async {
    String syncDate = await SessionManager.getSyncDate();
    if (syncDate != null) {
      lastUpdate = syncDate;
    } else {
      lastUpdate = Utils.getStringFromDate(Utils.firstDate(), AppString.DATE_FORMAT);
    }
  }

  static fetchUpdateData(int page) {
    Utils.checkConnectivity().then((value) {
      if (value != null && value) {
        dynamic data = _repository.getSyncStatus(lastUpdate, page);
      }
    });
  }

  static syncAllMallData() async {
    List<MallProfileModel> _allMallData =
        await SuperAdminDatabaseHelper.getAllVenueProfile();
    _allMallData.forEach((element) async {
      debugPrint('All_Mall_Data:-  ${element.name}');
      await DataBaseHelperCommon.insertAllMalls(element.toJson());
    });

    int _allMallsCount = await DataBaseHelperCommon.getAllMallsLength();
    debugPrint('all_malls_count:-   $_allMallsCount');
  }

  static syncRetailUnit() async {
    // DataBaseHelperCommon.getRetailUnitLength();
    // String defaultMall = await SessionManager.getDefaultMall();
    // debugPrint('retail_unit_common_count:-   $defaultMall');
    // List<RetailWithCategory> _retailWithCategoryList =
    //     await ProfileDatabaseHelper.getRetailWithCategory(
    //         databasePath: defaultMall,
    //         isShop: true,
    //         searchQuery: '',
    //         categoryId: '',
    //         favourite: 0);

    // debugPrint(
    //     'retail_unit_common_count:-   ${_retailWithCategoryList.length}');

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

  static syncCampaign() async {}
}
