import 'dart:async';

import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/screens/rewards/model/rewards_categories.dart';
import 'package:wayawaya/utils/session_manager.dart';

class RewardsSliderBloc {
  // ignore: close_sinks
  StreamController _rewardsCategoryController =
      StreamController<List<RewardsCategory>>();

  StreamSink<List<RewardsCategory>> get rewardsCategorySink =>
      _rewardsCategoryController.sink;

  Stream<List<RewardsCategory>> get rewardsCategoryStream =>
      _rewardsCategoryController.stream;

  fetchRewardsCategory() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<RewardsCategory> _rewardsCategoryList =
        await ProfileDatabaseHelper.getRewardsCategories(
      databasePath: defaultMall,
    );
    rewardsCategorySink.add(_rewardsCategoryList);
  }
}
