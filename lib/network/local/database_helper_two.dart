import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/table/categories_table.dart';
import 'package:wayawaya/network/local/table/loyalty_table.dart';
import 'package:wayawaya/network/model/category/category_wrapper.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_response.dart';
import 'package:wayawaya/utils/session_manager.dart';

import 'super_admin_database_helper.dart';
import 'table/campaign_table.dart';
import 'table/retail_unit_table.dart';

class DataBaseHelperTwo {
  // make it singleton class
  DataBaseHelperTwo._privateConstructor();

  static final DataBaseHelperTwo instance =
      DataBaseHelperTwo._privateConstructor();

  static Database _adminDataBase;
  static Database _profileDataBase;

  static Future<Database> fetchAdminDatabase() async {
    _adminDataBase = await SuperAdminDatabaseHelper.database;
    return _adminDataBase;
  }

  static Future<Database> fetchProfileDatabase() async {
    _profileDataBase = await ProfileDatabaseHelper.database;
    return _profileDataBase;
  }

  static patchData(String tableName, String columnName, String changedValue,
      String idColumnName, String recordId, bool isAdmin) async {
    if (isAdmin) {
      if (_adminDataBase == null) _adminDataBase = await fetchAdminDatabase();
    } else {
      if (_profileDataBase == null)
        _profileDataBase = await fetchProfileDatabase();
    }

    try {
      debugPrint("QueryForPatchData ----->" +
          " UPDATE " +
          tableName +
          " SET " +
          columnName +
          " = " +
          changedValue +
          " WHERE " +
          idColumnName +
          " = " +
          recordId);
      if (isAdmin) {
        var value = await _adminDataBase.rawQuery(" UPDATE " +
            tableName +
            " SET " +
            columnName +
            " = " +
            "" +
            changedValue +
            "" +
            " WHERE " +
            idColumnName +
            " = " +
            "'" +
            recordId +
            "'");
        debugPrint("QueryForPatchData ----->   updated value :-  $value");
      } else {
        var value = await _profileDataBase.rawQuery(" UPDATE " +
            tableName +
            " SET " +
            columnName +
            " = " +
            "" +
            changedValue +
            "" +
            " WHERE " +
            idColumnName +
            " = " +
            "'" +
            recordId +
            "'");
        debugPrint("QueryForPatchData ----->   updated value :-  $value");
      }
    } catch (e) {
      debugPrint('database_error:-   ${e.toString()}');
    } finally {}
  }

  static deleteRecord(String tableName, String columnName, String recordId,
      bool isAdmin) async {
    if (isAdmin) {
      if (_adminDataBase == null) _adminDataBase = await fetchAdminDatabase();
    } else {
      if (_profileDataBase == null)
        _profileDataBase = await fetchProfileDatabase();
    }
    try {
      if (isAdmin) {
        await _adminDataBase.query("Delete From " +
            tableName +
            " Where " +
            columnName +
            " = " +
            "\'" +
            recordId +
            "\'");
      } else {
        await _profileDataBase.query("Delete From " +
            tableName +
            " Where " +
            columnName +
            " = " +
            "\'" +
            recordId +
            "\'");
      }
      debugPrint("deleteRecord---> Delete From " +
          tableName +
          " Where " +
          columnName +
          " = " +
          "\'" +
          recordId +
          "\'");
    } catch (e) {}
  }

  static setCategoryToDataBase(List<CategoryWrapperItem> list) async {
    try {
      if (_profileDataBase == null)
        _profileDataBase = await fetchProfileDatabase();
      list.forEach((element) async {
        await insertCategoryTable(
            categoryId: element.categoryId, row: element.toJson());
      });
    } catch (e) {}
  }

  static insertCategoryTable(
      {Map<String, dynamic> row, String categoryId}) async {
    String id = row["_id"];
    row..remove("_id");
    row["id"] = id;
    debugPrint('map value is :-  $row');

    try {
      await _profileDataBase.transaction((txn) async {
        if (categoryId == null) {
          await txn.insert(CategoriesTable.CATEGORY_TABLE_NAME, row);
        } else {
          dynamic category = await txn.query(
              CategoriesTable.CATEGORY_TABLE_NAME,
              where: '${CategoriesTable.COLUMN_ID} = ?',
              whereArgs: [categoryId]);
          if (category == null || category.length == 0 || category.length < 0) {
            try {
              return await _profileDataBase.insert(
                  CategoriesTable.CATEGORY_TABLE_NAME, row);
            } catch (e) {
              debugPrint('database_insert:-  $e');
            }
          } else {
            return await _profileDataBase.update(
                CategoriesTable.CATEGORY_TABLE_NAME, row,
                where: '${CategoriesTable.COLUMN_ID} = ?',
                whereArgs: [categoryId]);
          }
        }
      });
    } catch (e) {}
  }

  static Future<List<Map<String, Map<String, Map<String, String>>>>>
      getObjectHashMap(
          final Map<String, Map<String, Map<String, String>>>
              dataListToGet) async {
    if (_profileDataBase == null)
      _profileDataBase = await fetchProfileDatabase();
    List<Map<String, Map<String, Map<String, String>>>> list = [];
    Map<String, Map<String, Map<String, String>>> returnData = new Map();
    Map<String, Map<String, String>> queryData = new Map();

    dataListToGet.keys.forEach((resource) async {
      if (dataListToGet[resource] != null) {
        dataListToGet[resource].keys.forEach((id) async {
          switch (resource) {
            case "campaigns":
              {
                String query = "SELECT *, '-1' as shop_name FROM " +
                    CampaignTable.CAMPAIGN_TABLE_NAME +
                    " WHERE id = $id LIMIT 1";
                debugPrint("Campaigns on patch %s  $id");
                dynamic c = await _profileDataBase.rawQuery(query);
                if (c != null) {
                  queryData.clear();
                  // queryData.put(id, gson.fromJson(gson.toJson(ProfileDb.CampaignTable.parseCursor(c)), HashMap.class));
                } else {
                  queryData.clear();
                  queryData[id] = dataListToGet[resource][id];
                }
                debugPrint("queryData %s" + queryData.toString());
              }
              break;
            case "retailUnits":
              {
                String query = "SELECT * FROM " +
                    RetailUnitTable.RETAIL_UNIT_TABLE_NAME +
                    " WHERE rid = $id LIMIT 1";
                debugPrint("retailUnits on patch %s  $id");
                dynamic c = await _profileDataBase.rawQuery(query);
                if (c != null) {
                  // queryData.clear();
                  // queryData.put(id, gson.fromJson(gson.toJson(ProfileDb.RetailUnitTable.parseCursor(c)), HashMap.class));
                }
              }
              break;
            case "categories":
              {
                String query = "SELECT * FROM " +
                        CategoriesTable.CATEGORY_TABLE_NAME +
                        " WHERE id = ? LIMIT 1",
                    id;
                debugPrint("retailUnits on patch %s  $id");
                dynamic c = await _profileDataBase.rawQuery(query);
                if (c != null) {
                  // queryData.clear();
                  // queryData.put(id, gson.fromJson(
                  //     gson.toJson(ProfileDb.CategoriesTable.parseCursor(c)),
                  //     HashMap.class));
                }
              }
          }
        });
      }

      returnData.clear();
      returnData[resource] = queryData;
      queryData.clear();
      list.add(returnData);
    });
  }

  // loyalty data implemented
  static setLoyaltyToDataBase(List<LoyaltyData> list) async {
    try {
      if (_profileDataBase == null)
        _profileDataBase = await fetchProfileDatabase();
      list.forEach((element) async {
        await insertLoyaltyTable(loyaltyId: element.id, row: element.toJson());
      });
    } catch (e) {}
  }

  static insertLoyaltyTable(
      {Map<String, dynamic> row, String loyaltyId}) async {
    String timestamp = row["event_timestamp"];
    row..remove("event_timestamp");
    row["timestamp"] = timestamp;
    debugPrint('map value is :-  $row');

    try {
      await _profileDataBase.transaction((txn) async {
        if (loyaltyId == null) {
          await txn.insert(LoyaltyTable.LOYALTY_TABLE_NAME, row);
        } else {
          dynamic category = await txn.query(LoyaltyTable.LOYALTY_TABLE_NAME,
              where: '${LoyaltyTable.COLUMN_ID} = ?', whereArgs: [loyaltyId]);
          if (category == null || category.length == 0 || category.length < 0) {
            try {
              return await txn.insert(LoyaltyTable.LOYALTY_TABLE_NAME, row);
            } catch (e) {
              debugPrint('database_insert:-  $e');
            }
          } else {
            return await txn.update(LoyaltyTable.LOYALTY_TABLE_NAME, row,
                where: '${LoyaltyTable.COLUMN_ID} = ?', whereArgs: [loyaltyId]);
          }
        }
      });
    } catch (e) {}
  }

  static Future<int> loyaltyTableLength() async {
    if (_profileDataBase == null)
      _profileDataBase = await fetchProfileDatabase();
    int count = Sqflite.firstIntValue(await _profileDataBase
        .rawQuery('SELECT COUNT(*) FROM ${LoyaltyTable.LOYALTY_TABLE_NAME}'));
    return count;
  }

  static Future<String> latestLoyalty() async {
    String defaultMall = await SessionManager.getDefaultMall();
    String timeStamp = await ProfileDatabaseHelper.latestLoyalty(
      databasePath: defaultMall,
    );
    return timeStamp;
  }
}
