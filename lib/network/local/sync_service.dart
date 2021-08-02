import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/full_screen_not_an_vanue_dialog.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/models/omni_channel_item_model/omni_channel_item_model.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/network/local/database_helper_two.dart';
import 'package:wayawaya/network/local/table/categories_table.dart';
import 'package:wayawaya/network/local/table/retail_unit_table.dart';
import 'package:wayawaya/network/local/table/trigger_zone_table.dart';
import 'package:wayawaya/network/local/table/venue_profile_table.dart';
import 'package:wayawaya/network/model/campaign/campaign_api_response.dart';
import 'package:wayawaya/network/model/category/category_wrapper.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_new.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_response.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';
import 'database_helper.dart';
import 'profile_database_helper.dart';
import 'table/campaign_table.dart';
import 'table/loyalty_table.dart';

class SyncService {
  // make it singleton class
  static final SyncService _syncService = SyncService._internal();

  factory SyncService() {
    return _syncService;
  }

  SyncService._internal();

  static final _repository = ApiRepository();

  static String lastUpdate;

  static Map<String, Map<String, Map<String, Map<String, dynamic>>>>
      hashmapToUpdate = new Map();

  static List<String> toRemove = [];

  BuildContext context;

  static Future fetchAllSyncData() async {
    await setSyncDateQuery();
    await fetchCampaignData(1);
    await syncLoyalty();
    // await fetchUpdateData(1);
    // SessionManager.setSyncDate(Utils.getStringFromDate(Utils.firstDate(), AppString.DATE_FORMAT));
  }

  static setSyncDateQuery() async {
    String syncDate = await SessionManager.getSyncDate();
    if (syncDate != null) {
      lastUpdate = syncDate;
    } else {
      lastUpdate =
          Utils.getStringFromDate(Utils.firstDate(), AppString.DATE_FORMAT);
    }
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
        await _convertResponseData(data: data.data);
        // check if you need to recall this api
        await _checkFetchOtherDataIfValue(data.data, page);
      }
    });
  }

  static _convertResponseData({dynamic data}) async {
    try {
      bool startPost = false;
      if (data["_items"] == null) return;
      data["_items"].forEach((element) async {
        if (element["o"] != null && element["o"].toString().trim() == "POST") {
          // start post request
          startPost = true;
        } else {
          // update in database
          await _updateDataInDb(item: element);
        }
      });
      await iterateUpdatedHashMaps(hashmapToUpdate);

      if (startPost) {
        debugPrint("ConvertResponseData called startPost true");
        await startPostRequests();
      }
    } catch (e) {}
  }

  static _updateDataInDb({dynamic item}) async {
    try {
      var resEndPoint = item["r"].toString().split("/");
      String resourceName = sortEndPoint(resEndPoint);

      if (item["c"] != null) {
        // If resource is appsoftware parameter set method as post since only one data is present
        if (resourceName.toLowerCase() ==
            "appSoftwareParameters".toLowerCase()) {
          await setHashMap(
              item["i"].toString(), item["c"], "POST", resourceName);
        } else {
          await setHashMap(item["i"].toString(), item["c"],
              item["o"].toString(), resourceName);
        }
      }

      if (item["o"] != null && item["o"].toString().trim() == "PATCH") {
        debugPrint("patch data resource end point columName %s");
        await _patchDataInDb(data: item);
      } else if (item["o"] != null && item["o"].toString().trim() == "POST") {
        await _postNewDataToDb(data: item);
      } else if (item["o"] != null && item["o"].toString().trim() == "DELETE") {
        await _deleteFromDb(data: item);
      }
    } catch (e) {
      debugPrint("error_in:-   $e");
    }
  }

  static setHashMap(String id, Map<String, dynamic> dataHashMap, String method,
      String resourceName) async {
    try {
      Map<String, Map<String, dynamic>> newDataHashMap = new Map();
      newDataHashMap[id] = dataHashMap;

      debugPrint(
          "Data in setHashMap %s -- %s -- %s" + id + method + resourceName);

      Map<String, Map<String, Map<String, dynamic>>> resourceHashMap =
          new Map();

      resourceHashMap[method] = newDataHashMap;

      setMasterHashMap(resourceName, method, resourceHashMap, id);
    } catch (e) {
      debugPrint("error_map:-  hashmap:-  $e");
    }
  }

  static setMasterHashMap(String resource, String method,
      Map<String, Map<String, Map<String, dynamic>>> resourceData, String id) {
    if (hashmapToUpdate[resource] != null) {
      if (hashmapToUpdate[resource][method] != null &&
          hashmapToUpdate[resource][method][id] != null) {
        debugPrint("Data in setHashMap method and id exists %s -- %s -- %s" +
            id +
            method +
            resource);
        hashmapToUpdate[resource][method][id] = mergeHashMap(
            hashmapToUpdate[resource][method][id], resourceData[method][id]);
      } else if (hashmapToUpdate[resource][method] != null) {
        debugPrint("Data in setHashMap method exists %s -- %s -- %s" +
            id +
            method +
            resource);
        hashmapToUpdate[resource][method][id] = resourceData[method][id];
      } else {
        debugPrint(
            "Data in setHashMap method and id not exists %s -- %s -- %s" +
                id +
                method +
                resource);
        hashmapToUpdate[resource][method] = resourceData[method];
      }
    } else {
      debugPrint(
          "Data in setHashMap in else %s -- %s -- %s" + id + method + resource);
      hashmapToUpdate[resource] = resourceData;
    }
  }

  static Map<String, String> mergeHashMap(
      Map<String, dynamic> targetHashMap, Map<String, dynamic> updatedHashMap) {
    targetHashMap.addAll(updatedHashMap);
    return targetHashMap;
  }

  static _patchDataInDb({dynamic data}) async {
    try {
      var resEndPoint = data["r"].toString().split("/");
      String resourceName = sortEndPoint(resEndPoint);

      Map<String, String> map = _getAllColumnNamesForDb(resourceName);
      Set<String> keys = map.keys.toSet();

      switch (resourceName) {
        case "retailUnits":
          {
            keys.forEach((element) async {
              try {
                if (data["c"].containsKey(map[element])) {
                  String updatedValue = data["c"][map[element]];
                  await DataBaseHelperTwo.patchData(
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
            keys.forEach((element) async {
              try {
                if (data["c"].containsKey(map[element])) {
                  String updatedValue = data["c"][map[element]];
                  await DataBaseHelperTwo.patchData(
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
            keys.forEach((element) async {
              try {
                if (data["c"].containsKey(map[element])) {
                  String updatedValue = data["c"][map[element]];
                  await DataBaseHelperTwo.patchData(
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
    } catch (e) {
      debugPrint("error_e:-   patch:-  $e");
    }
  }

  static _postNewDataToDb({dynamic data}) async {
    try {
      var resEndPoint = data["r"].toString().split("/");
      String resourceName = sortEndPoint(resEndPoint);

      Map<String, String> map = _getAllColumnNamesForDb(resourceName);
      Set<String> keys = map.keys.toSet();
      switch (resourceName) {
        case "retailUnits":
//                updateMapData();

          // Constant.retail_SyncService = true;
//                loadRetailUnit(jObject.get("i").getAsString());
          break;

        case "venues":
          // Constant.venue_SyncService = true;
          break;

        case "categories":
          // updateMapData();
          // Constant.category_SyncService = true;
          break;

        case "cinema":
          // Constant.cinema_SyncService = true;
          break;

        case "pois":
//                updateMapData();
          break;
      }
    } catch (e) {
      debugPrint("error_e:-   post:-  $e");
    }
  }

  static _deleteFromDb({dynamic data}) async {
    try {
      var resEndPoint = data["r"].toString().split("/");
      String resourceName = sortEndPoint(resEndPoint);

      Map<String, String> map = _getAllColumnNamesForDb(resourceName);
      Set<String> keys = map.keys.toSet();

      switch (resourceName) {
        case "loyaltyTransactions":
          await DataBaseHelperTwo.deleteRecord(LoyaltyTable.LOYALTY_TABLE_NAME,
              LoyaltyTable.COLUMN_ID, data["i"].toString(), false);
          break;
        case "categories":
          await DataBaseHelperTwo.deleteRecord(
              CategoriesTable.CATEGORY_TABLE_NAME,
              CategoriesTable.COLUMN_ID,
              data["i"].toString(),
              false);
          break;
        case "venue":
          await DataBaseHelperTwo.deleteRecord(
              VenueProfileTable.TABLE_NAME_VENUE_PROFILE,
              VenueProfileTable.COLUMN_IDENTIFIER,
              data["i"].toString(),
              true);
          break;
        case "retailUnits":
          // updateMapData();
          await DataBaseHelperTwo.deleteRecord(
              RetailUnitTable.RETAIL_UNIT_TABLE_NAME,
              RetailUnitTable.COLUMN_ID,
              data["i"].toString(),
              false);
          break;
        case "campaigns":
          break;
        case "triggerZones":
          await DataBaseHelperTwo.deleteRecord(
              CampaignTable.CAMPAIGN_TABLE_NAME,
              CampaignTable.COLUMN_ID,
              data["i"].toString(),
              false);
          break;
        case "pois":
//                updateMapData();
          break;
      }
    } catch (e) {
      debugPrint("error_e:-  delete db:-  $e");
    }
  }

  static iterateUpdatedHashMaps(
      Map<String, Map<String, Map<String, Map<String, dynamic>>>>
          dataToUpdate) async {
    Map<String, Map<String, Map<String, dynamic>>> listOfDataToPatch =
        new Map();
    debugPrint("iterateUpdatedHashMaps %s" + dataToUpdate.toString());
    dataToUpdate.keys.forEach((element) {
      // if (element == "retailUnits") {
      //   debugPrint("Update map data in iterated data %s" + element);
      // }
      if (dataToUpdate[element].keys.contains("PATCH")) {
        dataToUpdate[element]["PATCH"].keys.forEach((id) {
          if (dataToUpdate[element]["POST"] != null &&
              dataToUpdate[element]["POST"].keys.contains(id)) {
            debugPrint("Multiple data for id exits %s" + id);
            hashmapToUpdate[element]["POST"][id] = mergeHashMap(
                dataToUpdate[element]["POST"][id],
                dataToUpdate[element]["PATCH"][id]);
          }
          listOfDataToPatch[element] = hashmapToUpdate[element]["PATCH"];
        });
      }
    });

    if (listOfDataToPatch.isEmpty) {
      debugPrint("Data has been updated %s" + dataToUpdate.toString());
      await patchMergedData(hashmapToUpdate);
    } else {
      debugPrint("List of data is not empty.");
      await getDataForUpdate(listOfDataToPatch);
    }
  }

  static getDataForUpdate(
      final Map<String, Map<String, Map<String, dynamic>>>
          apiDataHashMap) async {
    List<Map<String, Map<String, Map<String, dynamic>>>> list =
        await DataBaseHelperTwo.getObjectHashMap(apiDataHashMap);

    list.forEach((existingData) {
      existingData.keys.forEach((resource) {
        existingData[resource].keys.forEach((id) {
          if (existingData[resource][id] != null) {
            hashmapToUpdate[resource]["PATCH"][id] = mergeHashMap(
                existingData[resource][id],
                hashmapToUpdate[resource]["PATCH"][id]);
          } else {
            toRemove.add(id);
          }
        });
      });
    });

    debugPrint("On Completed for getDataForUpdate %s  ${toRemove.length}");

    toRemove.forEach((id) {
      debugPrint("On Completed for Master data %s" +
          hashmapToUpdate["campaigns"]["PATCH"][id].toString());
      hashmapToUpdate["campaigns"]["PATCH"].remove(id);
    });

    debugPrint("List of ids to remove %s" + toRemove.length.toString());
    if (toRemove.isNotEmpty) {
      campaignListDataToGet(toRemove);
    }
    toRemove.clear();
    patchMergedData(hashmapToUpdate);
  }

  static patchMergedData(
      Map<String, Map<String, Map<String, Map<String, dynamic>>>>
          mergeDataHashMap) async {
    await DataBaseHelperTwo.updateData(mergeDataHashMap);
    hashmapToUpdate.clear();

    // if (!retailUnitsToDelete.isEmpty()) {
    //   for (String retailUnitId : retailUnitsToDelete) {
    //     mDataManager.mDatabaseHelper.deleteRecord(ProfileDb.RetailUnitTable.TABLE_NAME, ProfileDb.RetailUnitTable.COLUMN_ID, retailUnitId, false);
    //   }
    // }
    // campaignsToDelete.clear();
    // retailUnitsToDelete.clear();

  }

  static startPostRequests() async {
    await setCategory(1);
  }

  static setCategory(int page) async {
    try {
      String authorization = await SessionManager.getAuthHeader();
      Map<String, String> map = new Map();
      map["page"] = '1';
      map["sort"] = "-_updated";
      map["where"] = "{\"_updated\":{\"\$gt\": \"" + lastUpdate + "\"}}";

      Utils.checkConnectivity().then((value) async {
        if (value != null && value) {
          dynamic data = await _repository.categoryApiRepository(
              authorization: authorization, map: map);
          debugPrint('data_category:-    $data');
          CategoryWrapper categoryWrapper = CategoryWrapper.fromJson(data.data);
          debugPrint('data_category:-    ${categoryWrapper.items.length}');
          await DataBaseHelperTwo.setCategoryToDataBase(categoryWrapper.items);

          if (categoryWrapper.links != null &&
              categoryWrapper.links.next != null) {
            setCategory(page + 1);
          }
        }
      });
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

  static campaignListDataToGet(List<String> campaignsToGet) async {
    try {
      String authorization = await SessionManager.getAuthHeader();
      OmniChannelItemModel _omniChannelItemModel =
          await ProfileDatabaseHelper.getActiveOmniChannel(
        databasePath: authorization,
      );
      String oid = _omniChannelItemModel.oid;

      Map<String, String> campaignQuery = new Map();
      campaignQuery["page"] = "1";
      campaignQuery["sort"] = "-_updated";
      campaignQuery["where"] = "{\"_updated\":{\"\$gt\":\"" +
          lastUpdate +
          "\"},\"campaign_channels.omni_channel_id\":{\"\$elemMatch\":{\"\$eq\":\"" +
          oid +
          "\"}}}";
      if (campaignsToGet != null) {
        campaignQuery["_id"] = "{\"\$in\":" + campaignsToGet.toString() + "}";
      }
      campaignQuery["enable"] = true.toString();
      Utils.checkConnectivity().then((value) async {
        if (value != null && value) {
          dynamic data = await _repository.syncCampaignWithIdApiRepository(
              authorization: authorization, map: campaignQuery);
          debugPrint('data_category:-    $data');
          CampaignApiResponse campaignApiResponse =
              CampaignApiResponse.fromJson(data.data);
          debugPrint('data_category:-    ${campaignApiResponse.items.length}');
        }
      });
    } catch (e) {}
  }

  static _checkFetchOtherDataIfValue(dynamic data, int page) async {
    if (data['_links'] == null) return;
    if (data['_links']["next"] == null) return;
    await fetchUpdateData(page + 1);
  }

  // sync loyalty
  static syncLoyalty() {
    Utils.checkConnectivity().then((value) async {
      if (value != null && value) {
        try {
          String authToken = await SessionManager.getJWTToken();
          String userData = await SessionManager.getUserData();
          if (userData == null) {
            return;
          }
          UserDataResponse _response = userDataResponseFromJson(userData);
          if (_response == null) {
            return;
          }
          String userId = _response.userId;
          fetchLoyaltyFromNetwork(
              page: 1, userID: userId, authToken: authToken);
        } catch (e) {}
      } else {}
    });
  }

  static fetchLoyaltyFromNetwork(
      {int page, String authToken, String userID}) async {
    try {
      String where = "";
      String latestLoyalty = await DataBaseHelperTwo.latestLoyalty();
      debugPrint('latest_loyalty_is:-   $latestLoyalty');
      if (latestLoyalty == null) {
        where = "{\"points\":{\"\$gt\":0},\"user_id\":\"" + userID + "\"}";
      } else {
        where = "{\"event_timestamp\":{\"\$gt\": \"" +
            latestLoyalty +
            "\"},\"points\":{\"\$gt\":0},\"user_id\":\"" +
            userID +
            "\"}";
      }

      Map<String, dynamic> loyaltyQuery = {
        "page": page.toString(),
        "sort": "-event_timestamp",
        "enable": true,
        "where": where,
      };

      dynamic _loyaltyData = await _repository.loyaltyApiRepository(
          authorization: authToken, map: loyaltyQuery);
      debugPrint("testing__:-  success $_loyaltyData");
      if (_loyaltyData is DioError) {
        if (_loyaltyData.response.statusCode == 401) {
          // refresh token
          bool returnValue = await updateRefreshToken();
          if (returnValue) {
            syncLoyalty();
          }
        }
      } else {
        LoyaltyResponse _loyaltyResponse =
            LoyaltyResponse.fromJson(_loyaltyData.data);
        debugPrint("testing__:-  success ${_loyaltyResponse.items.length}");

        // set data to database
        await DataBaseHelperTwo.setLoyaltyToDataBase(_loyaltyResponse.items);

        if (_loyaltyResponse.links != null) {
          if (_loyaltyResponse.links.next != null) {
            fetchLoyaltyFromNetwork(
                page: page + 1, userID: userID, authToken: authToken);
          }
        }
      }
    } catch (e) {
      debugPrint("loyalty_error:-  $e");
    }
  }

  static Future<bool> updateRefreshToken() async {
    Utils.checkConnectivity().then((value) async {
      try {
        if (value != null && value) {
          dynamic _refreshTokenApiResponse =
              await _repository.refreshTokenApiRepository();
          if (_refreshTokenApiResponse is DioError) {
            // logout button functionality
            return false;
          } else {
            SessionManager.setJWTToken(
                _refreshTokenApiResponse.data['access_token']);
            SessionManager.setRefreshToken(
                _refreshTokenApiResponse.data['refresh_token']);
            return true;
          }
        } else {
          return false;
        }
      } catch (e) {
        // logout button functionality
        return false;
      }
    });
  }

  static Future checkUser() async {
    try {
      String userData = await SessionManager.getUserData();
      UserDataResponse _response = userDataResponseFromJson(userData);
      if (_response == null) return null;
      Utils.checkConnectivity().then((value) async {
        if (value != null && value) {
          dynamic checkUser = await _repository.checkUserApiRepository(
              userId: _response.username);
          if (checkUser is DioError) {
            // logout button functionality
            return false;
          } else {
            UserDataResponse userDataResponse = UserDataResponse(
              accessToken: _response.accessToken,
              lastName: checkUser.data['last_name'] ?? _response.lastName,
              username: checkUser.data['user_name'] ?? _response.username,
              userId: checkUser.data['_id'] ?? _response.userId,
              gender: checkUser.data['title'] ?? _response.gender,
              dob: checkUser.data['date_of_birth'] ?? _response.dob,
              firstName: checkUser.data['first_name'] ?? _response.firstName,
              cellnumber: checkUser.data['cell_number_list'] == null
                  ? _response.cellnumber
                  : json.encode(checkUser.data['cell_number_list']),
              isLogin: true,
              isTester: checkUser.data['tester_flag'] ?? _response.isTester,
              email: checkUser.data['email_list'] == null
                  ? _response.email
                  : json.encode(checkUser.data['email_list']),
              clientApi: checkUser.data['social_media'] == null
                  ? _response.clientApi
                  : json.encode(checkUser.data['social_media']),
              loginType: checkUser.data['social_media'] == null
                  ? _response.loginType
                  : json.encode(checkUser.data['social_media']),
              loyaltyStatus: checkUser.data['loyalty_status'] == null
                  ? _response.loyaltyStatus
                  : json.encode(checkUser.data['loyalty_status']),
              categories: checkUser.data['preferences'] == null
                  ? _response.categories
                  : checkUser.data['preferences']['categories'] == null
                      ? _response.categories
                      : checkUser.data['preferences']['categories'],
              notification: checkUser.data['preferences'] == null
                  ? _response.notification
                  : checkUser.data['preferences']['notification'] == null
                      ? _response.notification
                      : checkUser.data['preferences']['notification']
                          .toString(),
              favouriteMall: checkUser.data['preferences'] == null
                  ? _response.favouriteMall
                  : checkUser.data['preferences']['favorite_malls'] == null
                      ? _response.favouriteMall
                      : checkUser.data['preferences']['favorite_malls']
                          .toString(),
              language: checkUser.data['preferences'] == null
                  ? _response.language
                  : checkUser.data['preferences']['default_language'] == null
                      ? _response.language
                      : checkUser.data['preferences']['default_language']
                          .toString(),
              currency: checkUser.data['preferences'] == null
                  ? _response.currency
                  : checkUser.data['preferences']['alternate_currency'] == null
                      ? _response.currency
                      : checkUser.data['preferences']['alternate_currency']
                          .toString(),
              devices: checkUser.data['devices'] == null
                  ? _response.devices
                  : json.encode(checkUser.data['devices']),
              registrationDate: checkUser.data['registration_date'] ??
                  _response.registrationDate,
            );
            SessionManager.setUserData(
                userDataResponseToJson(userDataResponse));
            return null;
          }
        } else {
          return null;
        }
      });
    } catch (e) {
      return null;
    }
  }

  static Future updateStoreVisitQRPoints(
      {BuildContext context, int points, String shop_id}) async {
    try {
      String userData = await SessionManager.getUserData();
      UserDataResponse _response = userDataResponseFromJson(userData);
      if (_response == null) return null;
      Utils.checkConnectivity().then((value) async {
        if (value != null && value) {
          LoyaltyNew loyalty = new LoyaltyNew();
          loyalty.openingBalance = 0;
          loyalty.userId = _response.userId;
          loyalty.type = "store_visit";
          loyalty.description = "Store Visit Points";
          loyalty.status = "open";
          loyalty.activationStatus = "activated";
          loyalty.points = points;
          loyalty.noOfTimes = 0;
          loyalty.timestamp =
              Utils.getStringFromDate(DateTime.now(), AppString.DATE_FORMAT);
          loyalty.shopId = shop_id;
          dynamic response = await _repository.postAppOpenLoyaltyTransaction(
              loyaltyNew: loyalty);
          if (response is DioError) {
            if (response.response.statusCode == 401) {
              // refresh token
              bool returnValue = await updateRefreshToken();
              if (returnValue) {
                updateStoreVisitQRPoints(
                    context: context, shop_id: shop_id, points: points);
              }
            }
          } else {
            Navigator.push(
              context,
              FullScreenNotAnVenueDialog(
                  title: AppString.success,
                  content: AppString.loyalty_points_added_successfully),
            );
          }
          return;
        } else {
          Navigator.push(
            context,
            FullScreenNotAnVenueDialog(
                title: AppString.error,
                content: AppString.no_internet_connectivity),
          );
        }
      });
    } catch (e) {
      Navigator.push(
        context,
        FullScreenNotAnVenueDialog(
            title: AppString.error,
            content: AppString.no_internet_connectivity),
      );
      return;
    }
  }

  static Future redeemLoyaltyPoints(
      {BuildContext context, int points, String shop_id}) async {
    try {
      String userData = await SessionManager.getUserData();
      UserDataResponse _response = userDataResponseFromJson(userData);
      if (_response == null) return null;
      Utils.checkConnectivity().then((value) async {
        if (value != null && value) {
          LoyaltyNew loyalty = new LoyaltyNew();
          loyalty.userId = _response.userId;
          loyalty.type = "redemption";
          loyalty.points = points;
          loyalty.timestamp =
              Utils.getStringFromDate(DateTime.now(), AppString.DATE_FORMAT);
          loyalty.shopId = shop_id;
          dynamic response = await _repository.postAppOpenLoyaltyTransaction(
              loyaltyNew: loyalty);

          if (response is DioError) {
            if (response.response.statusCode == 401) {
              // refresh token
              bool returnValue = await updateRefreshToken();
              if (returnValue) {
                redeemLoyaltyPoints(
                    context: context, shop_id: shop_id, points: points);
              }
            }
          } else {
            Navigator.push(
              context,
              FullScreenNotAnVenueDialog(
                  title: AppString.success,
                  content: AppString.loyalty_points_added_successfully),
            );
          }
          return;
        } else {
          Navigator.push(
            context,
            FullScreenNotAnVenueDialog(
                title: AppString.error,
                content: AppString.no_internet_connectivity),
          );
        }
      });
    } catch (e) {
      Navigator.push(
        context,
        FullScreenNotAnVenueDialog(
            title: AppString.error,
            content: AppString.no_internet_connectivity),
      );
      return;
    }
  }

  static Future updateStoreVisitLoyaltyPoints({BuildContext context}) {}
}
