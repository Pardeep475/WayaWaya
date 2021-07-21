import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/network/local/database_helper_two.dart';
import 'package:wayawaya/network/local/table/categories_table.dart';
import 'package:wayawaya/network/local/table/retail_unit_table.dart';
import 'package:wayawaya/network/local/table/trigger_zone_table.dart';
import 'package:wayawaya/network/local/table/venue_profile_table.dart';
import 'package:wayawaya/network/model/campaign/campaign_api_response.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

import 'database_helper.dart';
import 'profile_database_helper.dart';
import 'table/campaign_table.dart';

class SyncService {
  // make it singleton class
  static final SyncService _syncService = SyncService._internal();

  factory SyncService() {
    return _syncService;
  }

  SyncService._internal();

  static final _repository = ApiRepository();

  static String lastUpdate;

  static Future fetchAllSyncData() async {
    // await setSyncDateQuery();
    // return await fetchCampaignData(1);
    // return await fetchUpdateData(1);
  }

  static setSyncDateQuery() async {
    String syncDate = await SessionManager.getSyncDate();
    if (syncDate != null) {
      lastUpdate = syncDate;
    } else {
      lastUpdate =
          Utils.getStringFromDate(Utils.firstDate(), AppString.DATE_FORMAT);
    }
    return null;
  }

  // start campaign data
  static Future fetchCampaignData(int page) async {
    int count = await DataBaseHelperCommon.getCampaignLength();
    debugPrint('CountOfCampaign:-  $count');
    if (count == 0 || count < 0) {
      await syncCampaignDataFromDatabase();
      Utils.checkConnectivity().then((value) async {
        if (value != null && value) {
          return await syncCampaignDataFromNetwork(page);
        } else {
          return;
        }
      });
    } else {
      Utils.checkConnectivity().then((value) async {
        if (value != null && value) {
          return await syncCampaignDataFromNetwork(page);
        }
      });
    }
  }

  static syncCampaignDataFromNetwork(int page) async {
    try {
      dynamic data = await _repository.fetchCampaignApiRepository(
          lastUpdate: lastUpdate, nextPage: page);
      if (data == null) {
        return;
      }
      if (data.data == null) {
        return;
      }
      CampaignApiResponse _campaignApiResponse =
          CampaignApiResponse.fromJson(data.data);
      if (_campaignApiResponse.items != null &&
          _campaignApiResponse.items.isNotEmpty) {
        debugPrint('campaign_count:-  ${_campaignApiResponse.items.length}');
        await Future.forEach(_campaignApiResponse.items,
            (Campaign element) async {
          debugPrint('CampaignId:-  ${element.id}');
          await DataBaseHelperCommon.insertCampaign(
              element.toJson(), element.id);
        });
      }
      if (_campaignApiResponse.links != null &&
          _campaignApiResponse.links.next != null) {
        syncCampaignDataFromNetwork(page + 1);
      } else {
        return;
      }
    } catch (e) {
      debugPrint('campaign_exception:- $e');
      return;
    }
  }

  static syncCampaignDataFromDatabase() async {
    String defaultMall = await SessionManager.getDefaultMall();
    debugPrint('checking_mall:- syncCampaignDataFromDatabase  $defaultMall');
    List<Campaign> campaignList =
        await ProfileDatabaseHelper.getLauncherCampaignData(
            databasePath: defaultMall,
            limit: 25,
            offset: 0,
            rid: "",
            searchText: "",
            publish_date:
                Utils.getStringFromDate(DateTime.now(), AppString.DATE_FORMAT),
            campaignType: "");

    campaignList.forEach((element) async {
      debugPrint('CampaignId:-  ${element.id}');
      await DataBaseHelperCommon.insertCampaign(element.toJson(), element.id);
    });

    return await DataBaseHelperCommon.getCampaignLength();
  }

// end campaign data

// fetch updated data
  static fetchUpdateData(int page) async {
    Utils.checkConnectivity().then((value) async {
      if (value != null && value) {
        dynamic data = await _repository.getSyncStatus(lastUpdate, page);
        if (data == null) {
          return;
        }
        if (data.data == null) {
          return;
        }
        // convert all response data
        _convertResponseData(data: data.data);
        // check if you need to recall this api
        _checkFetchOtherDataIfValue(data.data, page);
      }
    });
  }

  static _convertResponseData({dynamic data}) async {
    try {
      if (data["_items"] == null) return;
      data["_items"].forEach((element) {
        if (element["o"] != null && element["o"].toString().trim() == "POST") {
          // start post request
        } else {
          // update in database
          _updateDataInDb(item: element);
        }
      });
    } catch (e) {}
  }

  static _updateDataInDb({dynamic item}) {
    try {
      var resEndPoint = item["r"].toString().split("/");
      String resourceName = sortEndPoint(resEndPoint);

      if (item["c"] != null) {
        // If resource is appsoftware parameter set method as post since only one data is present
        if (resourceName.toLowerCase() ==
            "appSoftwareParameters".toLowerCase()) {
          debugPrint("getting updateDataInDb 1%s   ${item["o"].toString()}");
          // setHashMap(item.get("i").getAsString(), gson.fromJson(item.get("c").getAsJsonObject(), HashMap.class), "POST", resourceName);
        } else {
          debugPrint(
              "getting updateDataInDb 2 %s ------%s-----   $resourceName   ${item["o"].toString()}");
          // setHashMap(item.get("i").getAsString(), gson.fromJson(item.get("c").getAsJsonObject(), HashMap.class), item.get("o").getAsString(), resourceName);
        }
      }

      if (item["o"] != null && item["o"].toString().trim() == "PATCH") {
        debugPrint("patch data resource end point columName %s");
        _patchDataInDb(data: item);
      } else if (item["o"] != null && item["o"].toString().trim() == "POST") {
        // postNewDataToDb(item);
      } else if (item["o"] != null && item["o"].toString().trim() == "DELETE") {
        // deleteFromDb(item);
      }
    } catch (e) {}
  }

  static _patchDataInDb({dynamic data}) {
    try {
      var resEndPoint = data["r"].toString().split("/");
      String resourceName = sortEndPoint(resEndPoint);

      Map<String, String> map = _getAllColumnNamesForDb(resourceName);
      Set<String> keys = map.keys.toSet();

      switch (resourceName) {
        case "retailUnits":
          {
            keys.forEach((element) {
              try {
                if (data["c"].containsKey(map[element])) {
                  String updatedValue = data["c"][map[element]];
                  DataBaseHelperTwo.patchData(
                      RetailUnitTable.RETAIL_UNIT_TABLE_NAME,
                      map[element],
                      updatedValue,
                      RetailUnitTable.COLUMN_ID,
                      data["i"].toString(),
                      false);
                }
              } catch (e) {}
            });
          }
          break;
        case "guest":
          debugPrint(
              "categories called in patchdataInDb %s  ${data["r"].toString()}");
          break;
        case "categories":
          {
            keys.forEach((element) {
              try {
                if (data["c"].containsKey(map[element])) {
                  String updatedValue = data["c"][map[element]];
                  DataBaseHelperTwo.patchData(
                      CategoriesTable.CATEGORY_TABLE_NAME,
                      map[element],
                      updatedValue,
                      CategoriesTable.COLUMN_ID,
                      data["i"].toString(),
                      false);
                }
              } catch (e) {}
            });
          }
          break;
        case "triggerZones":
          {
            keys.forEach((element) {
              try {
                if (data["c"].containsKey(map[element])) {
                  String updatedValue = data["c"][map[element]];
                  DataBaseHelperTwo.patchData(
                      TriggerZoneTable.TRIGGER_ZONE_TABLE_NAME,
                      map[element],
                      updatedValue,
                      TriggerZoneTable.COLUMN_ID,
                      data["i"].toString(),
                      false);
                }
              } catch (e) {}
            });
          }
          break;
        case "pois":
          {
            debugPrint("Pois patch called");
            // updateMapData();
          }
          break;
      }
    } catch (e) {}
  }

  static Map<String, String> _getAllColumnNamesForDb(String resourceName) {
    Map<String, String> map = new Map<String, String>();
    if (resourceName == "retailUnits") {
      map["blog_link"] = RetailUnitTable.COLUMN_BLOG_LINK;
      map["cost_centre_code"] = RetailUnitTable.COLUMN_COST_CENTRE_CODE;
      map["sub_locations"] = RetailUnitTable.COLUMN_SUB_LOCATIONS;
      map["ecommerce_details"] = RetailUnitTable.COLUMN_ECOMMERCE_DETAILS;
      map["status"] = RetailUnitTable.COLUMN_STATUS;
      map["name"] = RetailUnitTable.COLUMN_NAME;
      map["description"] = RetailUnitTable.COLUMN_DESCRIPTION;
      map["categories"] = RetailUnitTable.COLUMN_CATEGORIES;
      map["favourite"] = RetailUnitTable.COLUMN_FAVORUITE;
    } else if (resourceName == "categories") {
      map["type"] = CategoriesTable.COLUMN_TYPE;
      map["parent"] = CategoriesTable.COLUMN_PARENT;
      map["category_color"] = CategoriesTable.COLUMN_CATEGORY_COLOR;
      map["name"] = CategoriesTable.COLUMN_NAME;
      map["label"] = CategoriesTable.COLUMN_LABEL;
      map["description"] = CategoriesTable.COLUMN_DESCRIPTION;
      map["icon_id"] = CategoriesTable.COLUMN_ICON_ID;
      map["links"] = CategoriesTable.COLUMN_LINKS;
      map["subscription"] = CategoriesTable.COLUMN_SUBSCRIPTION;
    } else if (resourceName == "triggerZones") {
      map["range"] = TriggerZoneTable.COLUMN_RANGE;
      map["geo_radius"] = TriggerZoneTable.COLUMN_GEO_RADIUS;
      map["cooldown_period"] = TriggerZoneTable.COLUMN_COOLDOWN_PERIOD;
      map["dwell_time"] = TriggerZoneTable.COLUMN_DWELL_TIME;
      map["handler"] = TriggerZoneTable.COLUMN_HANDLER;
      map["type"] = TriggerZoneTable.COLUMN_TYPE;
      map["status"] = TriggerZoneTable.COLUMN_STATUS;
      map["i_beacon"] = TriggerZoneTable.COLUMN_I_BEACON;
      map["start_time"] = TriggerZoneTable.COLUMN_START_TIME;
      map["geo_location"] = TriggerZoneTable.COLUMN_GEO_LOCATION;
      map["direction"] = TriggerZoneTable.COLUMN_DIRECTION;
      map["end_time"] = TriggerZoneTable.COLUMN_END_TIME;
      map["message_url"] = TriggerZoneTable.COLUMN_MESSAGE_URL;
      map["uuid"] = TriggerZoneTable.COLUMN_UUID;
      map["major"] = TriggerZoneTable.COLUMN_MAJOR;
      map["minor"] = TriggerZoneTable.COLUMN_MINOR;
    } else if (resourceName == "campaigns") {
      map["loyalty_offer_timeout"] = CampaignTable.COLUMN_LOYALTY_OFFER_TIMEOUT;
      map["limit_views_per_session"] =
          CampaignTable.COLUMN_LIMIT_VIEWS_PER_SESSION;
      map["campaign_element"] = CampaignTable.COLUMN_CAMPAIGN_ELEMENT;
      map["view_reset_counter"] = CampaignTable.COLUMN_VIEW_RESET_COUNTER;
      map["coupon_value"] = CampaignTable.COLUMN_COUPON_VALUE;
      map["end_time"] = CampaignTable.COLUMN_END_TIME;
      map["loyalty_points"] = CampaignTable.COLUMN_LOYALTY_POINTS;
      map["add_priotity"] = CampaignTable.COLUMN_ADD_PRIORITY;
      map["cost_centre_code"] = CampaignTable.COLUMN_COST_CENTRE_CODE;
      map["add_conversion_limit"] = CampaignTable.COLUMN_ADD_CONVERSION_LIMIT;
      map["add_budget_remaining"] = CampaignTable.COLUMN_ADD_BUDGET_REMAINING;
      map["campaign_channels"] = CampaignTable.COLUMN_CAMPAIGN_CHANNELS;
      map["add_click_limit"] = CampaignTable.COLUMN_ADD_CLICK_LIMIT;
      map["time_period"] = CampaignTable.COLUMN_TIME_PERIOD;
      map["asset_id"] = CampaignTable.COLUMN_ASSET_ID;
      map["trigger_zone_list"] = CampaignTable.COLUMN_TRIGGER_ZONE_LIST;
      map["offer_qr_code"] = CampaignTable.COLUMN_OFFER_QR_CODE;
      map["end_date"] = CampaignTable.COLUMN_END_DATE;
      map["coupon_code"] = CampaignTable.COLUMN_COUPON_CODE;
      map["reviewer_user_id"] = CampaignTable.COLUMN_REVIEWER_USER_ID;
      map["b2x_database_list_id"] = CampaignTable.COLUMN_B2X_DATABASE_LIST_ID;
      map["loyalty_offer_threshold"] =
          CampaignTable.COLUMN_LOYALTY_OFFER_THRESHOLD;
      map["add_budget"] = CampaignTable.COLUMN_ADD_BUDGET;
      map["add_impression_limit"] = CampaignTable.COLUMN_ADD_IMPRESSION_LIMIT;
      map["start_date"] = CampaignTable.COLUMN_START_DATE;
      map["target_list"] = CampaignTable.COLUMN_TARGET_LIST;
      map["status"] = CampaignTable.COLUMN_STATUS;
      map["price_model"] = CampaignTable.COLUMN_PRICE_MODEL;
      map["add_server_script"] = CampaignTable.COLUMN_ADD_SERVER_SCRIPT;
      map["rate_price"] = CampaignTable.COLUMN_RATE_PRICE;
      map["add_server_url"] = CampaignTable.COLUMN_ADD_SERVER_URL;
      map["publish_date"] = CampaignTable.COLUMN_PUBLISH_DATE;
      map["type"] = CampaignTable.COLUMN_TYPE;
      map["start_time"] = CampaignTable.COLUMN_START_TIME;
      map["voucher"] = CampaignTable.COLUMN_VOUCHER;
      map["image_size_id"] = CampaignTable.COLUMN_IMAGE_SIZE_ID;
      map["rid"] = CampaignTable.COLUMN_RID;
      map["floorplan_id"] = CampaignTable.COLUMN_FLOORPLAN_ID;
    } else if (resourceName == "venues") {
      map["name"] = VenueProfileTable.COLUMN_NAME;
      map["geo_location"] = VenueProfileTable.COLUMN_GEOFENCE;
      map["ibeacon_uuid"] = VenueProfileTable.COLUMN_IBEACON_UUID;
      map["active"] = VenueProfileTable.COLUMN_DEFAULT;
      map["venue_data"] = VenueProfileTable.COLUMN_DATA;
      map["key"] = VenueProfileTable.COLUMN_KEY;
    }

    return map;
  }

  static String sortEndPoint(resource) {
    if (resource.length > 1) {
      int i = resource.length - 1;
      return resource[i].trim();
    } else {
      return resource[0];
    }
  }

  static _checkFetchOtherDataIfValue(dynamic data, int page) async {
    if (data['_links'] == null) return;
    if (data['_links']["next"] == null) return;
    await fetchUpdateData(page + 1);
  }
}
