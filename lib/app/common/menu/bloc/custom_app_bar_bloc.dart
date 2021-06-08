import 'dart:async';

import 'package:wayawaya/common/model/categories_model.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/utils/session_manager.dart';

class CustomAppBarBloc {
  StreamController _profileCategoryController =
      StreamController<List<Category>>();

  StreamSink<List<Category>> get profileCategorySink =>
      _profileCategoryController.sink;

  Stream<List<Category>> get profileCategoryStream =>
      _profileCategoryController.stream;

  StreamController _identifierController = StreamController<String>();

  StreamSink<String> get identifierCategorySink => _identifierController.sink;

  Stream<String> get identifierCategoryStream => _identifierController.stream;

  Future getProfileCategories() async {
    String databasePath = await SessionManager.getDefaultMall();
    // List<Category> categories =
    //     await ProfileDatabaseHelper.getAllCategories(databasePath);
    // profileCategorySink.add(categories);
    identifierCategorySink.add(databasePath);
    // return categories;
  }
}
