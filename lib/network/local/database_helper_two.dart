import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';

import 'super_admin_database_helper.dart';

class DataBaseHelperTwo {
  // make it singleton class
  DataBaseHelperTwo._privateConstructor();

  static final DataBaseHelperTwo instance =
  DataBaseHelperTwo._privateConstructor();

  static Database _adminDataBase;
  static Database _profileDataBase;

  static fetchAdminDatabase() async{
    _adminDataBase = await SuperAdminDatabaseHelper.database;
  }

  static fetchProfileDatabase() async{
    _profileDataBase = await ProfileDatabaseHelper.database;
  }


  static patchData(String tableName, String columnName, String changedValue, String idColumnName, String recordId, bool isAdmin) async{
    try {
      debugPrint("QueryForPatchData ----->" + " UPDATE " + tableName + " SET " + columnName + " = " + changedValue + " WHERE " + idColumnName + " = " + recordId);
      if (isAdmin) {
        var value = await _adminDataBase.rawQuery(" UPDATE " + tableName + " SET " + columnName + " = " + "" + changedValue + "" + " WHERE " + idColumnName + " = " + "'" + recordId + "'");
        debugPrint("QueryForPatchData ----->   updated value :-  $value");
      } else {
        var value = await _profileDataBase.rawQuery(" UPDATE " + tableName + " SET " + columnName + " = " + "" + changedValue + "" + " WHERE " + idColumnName + " = " + "'" + recordId + "'");
        debugPrint("QueryForPatchData ----->   updated value :-  $value");
      }

    } catch (e) {
      debugPrint('database_error:-   ${e.toString()}');
    } finally {

    }

  }

}