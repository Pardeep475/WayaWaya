import 'store_visit_loyalty.dart';

class StoreVisitLoyaltyData {
  final List<StoreVisitLoyalty> storeVisitLoyaltyList;
  final String lastDate;
  final List<String> syncDates;
  final List<String> noSyncDates;

  StoreVisitLoyaltyData(
      {this.storeVisitLoyaltyList,
      this.lastDate,
      this.syncDates,
      this.noSyncDates});
}
