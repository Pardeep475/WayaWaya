import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';

class MallBloc {
  StreamController _mallProfileController =
      StreamController<List<MallProfileModel>>();

  StreamSink<List<MallProfileModel>> get mallProfileSink =>
      _mallProfileController.sink;

  Stream<List<MallProfileModel>> get mallProfileStream =>
      _mallProfileController.stream;

  getMallData() async {
    List<MallProfileModel> _mallList =
        await SuperAdminDatabaseHelper.getAllVenueProfile();
    debugPrint('database_testing:-   ${_mallList.length}');
    mallProfileSink.add(_mallList);
  }
}
