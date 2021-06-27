import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/preferences/model/preferences_categories.dart';
import 'package:wayawaya/app/search/model/global_app_search.dart';
import 'package:wayawaya/app/shop/model/retail_unit_category.dart';
import 'package:wayawaya/app/shop/model/retail_with_category.dart';
import 'package:wayawaya/common/model/categories_model.dart';
import 'package:wayawaya/utils/app_strings.dart';

class ProfileDatabaseHelper {
  static final ProfileDatabaseHelper _profileDatabaseHelper =
      ProfileDatabaseHelper._internal();

  factory ProfileDatabaseHelper() {
    return _profileDatabaseHelper;
  }

  ProfileDatabaseHelper._internal();

  static Database _db;

  static Future initDataBase(String databasePath) async {
    try {
      var databasesPath = await getDatabasesPath();
      var dbPath = path.join(databasesPath, "$databasePath.db");
      // Check if the database exists
      var exists = await databaseExists(dbPath);

      if (!exists) {
        // Should happen only the first time you launch your application
        print("Creating new copy from asset");
        // Make sure the parent directory exists
        await Directory(path.dirname(dbPath)).create(recursive: true);
        // Copy from asset
        ByteData data = await rootBundle
            .load(path.join("assets", "database/$databasePath.db"));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        // Write and flush the bytes written
        await File(dbPath).writeAsBytes(bytes, flush: true);
        // open the database
        _db = await openDatabase(dbPath, readOnly: true);
      } else {
        debugPrint("database_testing:- Opening existing database");
        _db = await openDatabase(dbPath, readOnly: true);
      }
    } catch (e) {
      debugPrint('database_testing:-  $e');
    }
  }

  static Future<List<Category>> getAllCategories(String databasePath) async {
    debugPrint('database_testing:-  database path $databasePath');
    if (_db == null) {
      await initDataBase(databasePath);
    }
    List<Map> data;
    await _db.transaction((txn) async {
      data = await txn.query(
        AppString.CATEGORIES_TABLE_NAME,
        columns: [
          "type",
          "parent",
          "category_color",
          "name",
          "id",
          "links",
          "label",
          "description",
          "icon_id",
          "subscription",
          "display",
          "category_id",
        ],
      );
    });
    // _db.close();
    debugPrint('database_testing:-   ${data.length}');
    debugPrint('database_testing:-   $data');
    List<Category> _mallList = [];
    data.forEach((element) {
      _mallList.add(Category.fromJson(element));
    });

    data.map((e) => debugPrint('database_testing:-    $e'));
    return _mallList;
  }

  static Future<List<PreferencesCategory>> getPreferencesCategories(
    String path,
    String limit,
    String offset,
  ) async {
    debugPrint('database_testing:-  preferences  ');
    if (_db == null) {
      await initDataBase(path);
    }
    List<Map> data;
    String subscribed = "WHERE subscription = 1";

    String query =
        "WITH RECURSIVE menu_tree (category_id, name, label, level, parent, subscription) \n" +
            "AS ( \n" +
            "  SELECT\n" +
            "    category_id, \n" +
            "    '' || name, \n" +
            "    '' || label, \n" +
            "    0, \n" +
            "    parent,\n" +
            "\tsubscription\n" +
            "  FROM categories \n" +
            "  WHERE parent = ''\n" +
            "  UNION ALL\n" +
            "  SELECT\n" +
            "    mn.category_id, \n" +
            "    mt.name || ' <> ' || mn.name, \n" +
            "    mt.label || ' <> ' || mn.label, \n" +
            "    mt.level + 0, \n" +
            "    mt.category_id,\n" +
            "\tmn.subscription\n" +
            "  FROM categories mn, menu_tree mt \n" +
            "  WHERE mn.parent = mt.category_id \n" +
            ") \n" +
            "SELECT * FROM menu_tree \n" +
            subscribed +
            " AND level >= 0 \n" +
            "ORDER BY level DESC";

    // debugPrint("profile_db_testing:-   $query");
    await _db.transaction((txn) async {
      data = await txn.rawQuery(query);
    });
    // _db.close();
    debugPrint('database_testing:-  preferences  ${data.length}');
    // debugPrint('database_testing:-   $data');
    List<PreferencesCategory> _preferencesCategoriesList = [];
    data.forEach((element) {
      _preferencesCategoriesList.add(PreferencesCategory.fromJson(element));
    });
    _preferencesCategoriesList.sort((a, b) => a.name.compareTo(b.name));
    return _preferencesCategoriesList;
  }

  static Future<List<Campaign>> getAllCampaign(String databasePath) async {
    debugPrint('database_testing:-  database path $databasePath');
    if (_db == null) {
      await initDataBase(databasePath);
    }
    List<Map> data;
    await _db.transaction((txn) async {
      data = await txn.query(
        AppString.CAMPAIGN_TABLE_NAME,
        where: "status = ?",
        whereArgs: ['approved'],
        orderBy: 'start_date ASC',
      );
    });
    // _db.close();
    debugPrint('database_testing:-   ${data.length}');
    debugPrint('database_testing:-   $data');
    List<Campaign> _mallList = [];
    data.forEach((element) {
      _mallList.add(Campaign.fromJson(element));
    });
    data.map((e) => debugPrint('database_testing:-    $e'));
    // _mallList.sort();
    return _mallList;
  }

  static Future<List<GlobalAppSearch>> getAllSearchType(
      {String databasePath, String searchQuery}) async {
    debugPrint('database_testing:-  database path $databasePath');
    if (_db == null) {
      await initDataBase(databasePath);
    }
    List<Map> data;
    String shop = " \"shop\" ";
    String restaurant = " \"restaurant\" ";
    String searchQuerytring = "";
    if (searchQuery != "" && searchQuery != null) {
      searchQuerytring = " \"%" + searchQuery + "%\" ";
    }

    String query = "WITH RECURSIVE menu_tree (category_id, category_name, level, parent,category_color) AS ( \n" +
        "   SELECT\n" +
        "     category_id, \n" +
        "     '' || name, \n" +
        "     0, \n" +
        "     parent,\n" +
        "    category_color\n" +
        "   FROM categories \n" +
        "   WHERE parent = ''\n" +
        "   UNION ALL\n" +
        "   SELECT\n" +
        "     mn.category_id, \n" +
        "     mt.category_name || ' <> ' || mn.name, \n" +
        "     mt.level + 0, \n" +
        "     mt.category_id,\n" +
        "    mn.category_color\n" +
        "   FROM categories mn, menu_tree mt \n" +
        "   WHERE mn.parent = mt.category_id \n" +
        " ) \n" +
        " SELECT campaign_element as name, type as type, null as heading, null as description, end_date as end_date, start_date as start_date, start_time as start_time \n" +
        " FROM campaign WHERE campaign_element LIKE " +
        searchQuerytring +
        " AND (type='offer' OR type='event') \n" +
        "UNION SELECT DISTINCT rcmap.name as name, " +
        shop +
        " as type, rcmap.heading, rcmap.description, null as end_date, null as start_date, null as start_time FROM menu_tree mt\n" +
        " INNER JOIN (Select DISTINCT cid, ret.sub_locations as name, " +
        shop +
        " as type, ret.name as heading, ret.description as description, null as end_date, null as start_date, null as start_time FROM retail_category_map rmap  INNER JOIN \n" +
        " retail_units ret ON ret.rid = rmap.rid WHERE ret.name LIKE  " +
        searchQuerytring +
        " OR ret.sub_locations LIKE  " +
        searchQuerytring +
        " OR heading LIKE  " +
        searchQuerytring +
        " OR description LIKE  " +
        searchQuerytring +
        ") rcmap ON rcmap.cid = mt.category_id \n" +
        " WHERE (category_name NOT LIKE '%Food & Dining%' AND category_name NOT LIKE '%Hide%')  AND level >= 0 \n" +
        "UNION SELECT DISTINCT rcmap.name as name, " +
        restaurant +
        " as type, rcmap.heading, rcmap.description, null as end_date, null as start_date, null as start_time FROM menu_tree mt\n" +
        " INNER JOIN (Select DISTINCT cid, ret.sub_locations as name, " +
        restaurant +
        " as type, ret.name as heading, ret.description as description, null as end_date, null as start_date, null as start_time FROM retail_category_map rmap  INNER JOIN \n" +
        " retail_units ret ON ret.rid = rmap.rid WHERE name LIKE  " +
        searchQuerytring +
        " OR ret.sub_locations LIKE  " +
        searchQuerytring +
        " OR heading LIKE  " +
        searchQuerytring +
        " OR description LIKE  " +
        searchQuerytring +
        ") rcmap ON rcmap.cid = mt.category_id \n" +
        " WHERE (category_name LIKE '%Food & Dining%' AND category_name NOT LIKE '%Hide%' )  AND level >= 0 \n" +
        " GROUP BY heading ORDER BY heading ASC ";

    // debugPrint("profile_db_testing:-   $query");

    await _db.transaction((txn) async {
      data = await txn.rawQuery(query);
    });

    // _db.close();
    debugPrint('database_testing:-  all search  ${data.length}');
    debugPrint('database_testing:-   $data');
    List<GlobalAppSearch> _allSearchList = [];
    data.forEach((element) {
      _allSearchList.add(GlobalAppSearch.fromJson(element));
    });
    // _preferencesCategoriesList.sort((a, b) => a.name.compareTo(b.name));
    return _allSearchList;
  }

  static Future<List<GlobalAppSearch>> getOfferSearchType(
      {String databasePath, String searchQuery}) async {
    debugPrint('database_testing:-  database path $databasePath');
    if (_db == null) {
      await initDataBase(databasePath);
    }
    List<Map> data;
    String shop = " \"shop\" ";
    String restaurant = " \"restaurant\" ";
    String searchQuerytring = "";
    if (searchQuery != "" && searchQuery != null) {
      searchQuerytring = " \"%" + searchQuery + "%\" ";
    }

    String query = "SELECT campaign_element " +
        "as name, type as type, null as heading, null as description, end_date as end_date, start_date as start_date, start_time as start_time " +
        " FROM campaign WHERE campaign_element LIKE " +
        searchQuerytring +
        " AND (type='offer') ";
    // debugPrint("profile_db_testing:-   $query");

    await _db.transaction((txn) async {
      data = await txn.rawQuery(query);
    });

    // _db.close();
    debugPrint('database_testing:-  Offer search  ${data.length}');
    debugPrint('database_testing:-   $data');
    List<GlobalAppSearch> _allSearchList = [];
    data.forEach((element) {
      _allSearchList.add(GlobalAppSearch.fromJson(element));
    });
    // _preferencesCategoriesList.sort((a, b) => a.name.compareTo(b.name));
    return _allSearchList;
  }

  static Future<List<GlobalAppSearch>> getEventsSearchType(
      {String databasePath, String searchQuery}) async {
    debugPrint('database_testing:-  database path $databasePath');
    if (_db == null) {
      await initDataBase(databasePath);
    }
    List<Map> data;
    String shop = " \"shop\" ";
    String restaurant = " \"restaurant\" ";
    String searchQuerytring = "";
    if (searchQuery != "" && searchQuery != null) {
      searchQuerytring = " \"%" + searchQuery + "%\" ";
    }

    String query = "SELECT campaign_element " +
        "as name, type as type, null as heading, null as description, end_date as end_date, start_date as start_date, start_time as start_time " +
        " FROM campaign WHERE campaign_element LIKE " +
        searchQuerytring +
        " AND (type='event') ";

    // debugPrint("profile_db_testing:-   $query");

    await _db.transaction((txn) async {
      data = await txn.rawQuery(query);
    });

    // _db.close();
    debugPrint('database_testing:-  events search  ${data.length}');
    debugPrint('database_testing:-   $data');
    List<GlobalAppSearch> _allSearchList = [];
    data.forEach((element) {
      _allSearchList.add(GlobalAppSearch.fromJson(element));
    });
    // _preferencesCategoriesList.sort((a, b) => a.name.compareTo(b.name));
    return _allSearchList;
  }

  static Future<List<GlobalAppSearch>> getShopSearchType(
      {String databasePath, String searchQuery}) async {
    debugPrint('database_testing:-  database path $databasePath');
    if (_db == null) {
      await initDataBase(databasePath);
    }
    List<Map> data;
    String shop = " \"shop\" ";
    String restaurant = " \"restaurant\" ";
    String searchQuerytring = "";
    if (searchQuery != "" && searchQuery != null) {
      searchQuerytring = " \"%" + searchQuery + "%\" ";
    }

    String query =
        "WITH RECURSIVE menu_tree (category_id, category_name, level, parent,category_color) AS ( \n" +
            "   SELECT\n" +
            "     category_id, \n" +
            "     '' || name, \n" +
            "     0, \n" +
            "     parent,\n" +
            "    category_color\n" +
            "   FROM categories \n" +
            "   WHERE parent = ''\n" +
            "   UNION ALL\n" +
            "   SELECT\n" +
            "     mn.category_id, \n" +
            "     mt.category_name || ' <> ' || mn.name, \n" +
            "     mt.level + 0, \n" +
            "     mt.category_id,\n" +
            "    mn.category_color\n" +
            "   FROM categories mn, menu_tree mt \n" +
            "   WHERE mn.parent = mt.category_id \n" +
            " ) \n" +
            " SELECT DISTINCT category_id, rcmap.* FROM menu_tree mt\n" +
            " INNER JOIN (Select DISTINCT cid, ret.sub_locations as name, " +
            shop +
            " as type, ret.name as heading, ret.description as description, null as end_date, null as start_date, null as start_time FROM retail_category_map rmap  INNER JOIN \n" +
            " retail_units ret ON ret.rid = rmap.rid WHERE name LIKE " +
            searchQuerytring +
            " OR ret.sub_locations LIKE  " +
            searchQuerytring +
            " OR heading LIKE  " +
            searchQuerytring +
            " OR description LIKE  " +
            searchQuerytring +
            " ) rcmap ON rcmap.cid = mt.category_id \n" +
            " WHERE (category_name NOT LIKE '%Food & Dining%' AND category_name NOT LIKE '%Hide%' )  AND level >= 0 \n" +
            " GROUP BY heading ORDER BY heading ASC";

    // debugPrint("profile_db_testing:-   $query");

    await _db.transaction((txn) async {
      data = await txn.rawQuery(query);
    });

    // _db.close();
    debugPrint('database_testing:-  Shop search  ${data.length}');
    debugPrint('database_testing:-   $data');
    List<GlobalAppSearch> _allSearchList = [];
    data.forEach((element) {
      _allSearchList.add(GlobalAppSearch.fromJson(element));
    });
    // _preferencesCategoriesList.sort((a, b) => a.name.compareTo(b.name));
    return _allSearchList;
  }

  static Future<List<GlobalAppSearch>> getRestaurantSearchType(
      {String databasePath, String searchQuery}) async {
    debugPrint('database_testing:-  database path $databasePath');
    if (_db == null) {
      await initDataBase(databasePath);
    }
    List<Map> data;
    String shop = " \"shop\" ";
    String restaurant = " \"restaurant\" ";
    String searchQuerytring = "";
    if (searchQuery != "" && searchQuery != null) {
      searchQuerytring = " \"%" + searchQuery + "%\" ";
    }

    String query =
        "WITH RECURSIVE menu_tree (category_id, category_name, level, parent,category_color) AS ( \n" +
            "   SELECT\n" +
            "     category_id, \n" +
            "     '' || name, \n" +
            "     0, \n" +
            "     parent,\n" +
            "    category_color\n" +
            "   FROM categories \n" +
            "   WHERE parent = ''\n" +
            "   UNION ALL\n" +
            "   SELECT\n" +
            "     mn.category_id, \n" +
            "     mt.category_name || ' <> ' || mn.name, \n" +
            "     mt.level + 0, \n" +
            "     mt.category_id,\n" +
            "    mn.category_color\n" +
            "   FROM categories mn, menu_tree mt \n" +
            "   WHERE mn.parent = mt.category_id \n" +
            " ) \n" +
            " SELECT DISTINCT category_id,rcmap.* FROM menu_tree mt\n" +
            " INNER JOIN (Select DISTINCT cid, ret.sub_locations as name, " +
            restaurant +
            " as type, ret.name as heading, ret.description as description, null as end_date, null as start_date, null as start_time FROM retail_category_map rmap  INNER JOIN \n" +
            " retail_units ret ON ret.rid = rmap.rid WHERE name LIKE " +
            searchQuerytring +
            " OR ret.sub_locations LIKE  " +
            searchQuerytring +
            " OR heading LIKE " +
            searchQuerytring +
            " OR description LIKE  " +
            searchQuerytring +
            " ) rcmap ON rcmap.cid = mt.category_id \n" +
            " WHERE (category_name  LIKE '%Food & Dining%' AND category_name NOT LIKE '%Hide%' )  AND level >= 0 \n" +
            " GROUP BY heading ORDER BY heading ASC ";

    // debugPrint("profile_db_testing:-   $query");

    await _db.transaction((txn) async {
      data = await txn.rawQuery(query);
    });

    // _db.close();
    debugPrint('database_testing:-  Restaurant search  ${data.length}');
    debugPrint('database_testing:-   $data');
    List<GlobalAppSearch> _allSearchList = [];
    data.forEach((element) {
      _allSearchList.add(GlobalAppSearch.fromJson(element));
    });
    // _preferencesCategoriesList.sort((a, b) => a.name.compareTo(b.name));
    return _allSearchList;
  }

  static Future<List<Campaign>> getCampaignByType(
      {String databasePath,
      final String campaignType,
      final String searchText,
      final String rid,
      final String publishDate}) async {
    debugPrint('database_testing:-  database path $databasePath');
    if (_db == null) {
      await initDataBase(databasePath);
    }
    String whereClause = "";
    String searchQueryCondition = "";
    String offerForRetailUnitCondition = "";
    if (searchText != null && searchText != "") {
      searchQueryCondition =
          " AND ( campaign_element LIKE '%" + searchText + "%' ) ";
    }
    if (rid != null && rid != "") {
      offerForRetailUnitCondition = " AND ( rid LIKE '%" + rid + "%') ";
    }

    if (campaignType != "") {
      whereClause =
          " WHERE type='" + campaignType + "' AND " + 'status' + "='approved' ";
    } else {
      whereClause = " WHERE " + 'status' + "='approved' ";
    }

    // whereClause += " AND publish_date <= '" + publish_date + "'";

    String query = "SELECT *, '' as shop_name FROM " +
        AppString.CAMPAIGN_TABLE_NAME +
        " " +
        whereClause +
        searchQueryCondition +
        offerForRetailUnitCondition +
        " ORDER BY " +
        'start_date' +
        " ASC";

    List<Map> data;

    await _db.transaction((txn) async {
      data = await txn.rawQuery(query);
    });
    // await _db.transaction((txn) async {
    //   data = await txn.query(
    //     AppString.CAMPAIGN_TABLE_NAME,
    //     where: "status = ? and type = ?",
    //     whereArgs: ['approved', campaignType],
    //     orderBy: 'start_date ASC',
    //   );
    // });

    // _db.close();
    debugPrint('database_testing:-   ${data.length}');
    debugPrint('database_testing:-   $data');
    List<Campaign> _mallList = [];
    data.forEach((element) {
      _mallList.add(Campaign.fromJson(element));
    });
    data.map((e) => debugPrint('database_testing:-    $e'));
    // _mallList.sort();
    return _mallList;
  }

  static Future<List<RetailUnitCategory>> getRestaurantAndStopData({
    String databasePath,
    String searchQuery,
    bool isShop,
  }) async {
    debugPrint('database_testing:-  database path $databasePath');
    if (_db == null) {
      await initDataBase(databasePath);
    }
    List<Map> data;

    String searchQueryCondition = "";
    String shopsWhereClause = "";

    if (isShop) {
      shopsWhereClause =
          " WHERE name NOT LIKE '%Food & Dining%' AND name NOT LIKE '%Restaurants%' AND name NOT LIKE '%Hide%' AND display='1' ";
    } else {
      shopsWhereClause =
          " WHERE name LIKE '%Food & Dining%' OR name LIKE '%Restaurants%' AND name NOT LIKE '%Hide%' AND display='1'  ";
    }

    if (searchQuery != null && searchQuery != "") {
      searchQueryCondition = "  AND (name LIKE '%" + searchQuery + "%') ";
    }

    String query =
        "WITH RECURSIVE menu_tree (category_id, name, level, parent,category_color, display) \n" +
            "AS ( \n" +
            "  SELECT\n" +
            "    category_id, \n" +
            "    '' || name, \n" +
            "    0, \n" +
            "    parent,\n" +
            "\tcategory_color,\n" +
            "\tdisplay\n" +
            "  FROM categories \n" +
            "  WHERE parent = ''\n" +
            "  UNION ALL\n" +
            "  SELECT\n" +
            "    mn.category_id, \n" +
            "    mt.name || ' <> ' || mn.name, \n" +
            "    mt.level + 0, \n" +
            "    mt.category_id,\n" +
            "\tmn.category_color,\n" +
            "\tmn.display\n" +
            "  FROM categories mn, menu_tree mt \n" +
            "  WHERE mn.parent = mt.category_id \n" +
            ") \n" +
            "SELECT DISTINCT category_id, * FROM menu_tree mt\n" +
            "INNER JOIN (Select DISTINCT cid FROM retail_category_map  \n" +
            ") rcmap ON rcmap.cid = mt.category_id" +
            shopsWhereClause +
            " AND level >= 0 \n" +
            searchQueryCondition +
            "GROUP BY name ORDER BY name ASC";

    await _db.transaction((txn) async {
      data = await txn.rawQuery(query);
    });

    debugPrint('database_testing:- Restaurant all search  ${data.length}');
    debugPrint('database_testing:-   $data');
    List<RetailUnitCategory> _allSearchList = [];
    data.forEach((element) {
      _allSearchList.add(RetailUnitCategory.fromJson(element));
    });
    // _preferencesCategoriesList.sort((a, b) => a.name.compareTo(b.name));
    return _allSearchList;
  }

  static Future<List<RetailWithCategory>> getRetailWithCategory({
    String databasePath,
    String searchQuery,
    String categoryId,
    bool isShop,
    final int favourite,
  }) async {
    if (_db == null) {
      await initDataBase(databasePath);
    }

    try {
      List<Map> data = [];

      String shopsWhereClause = "";
      String groupBy = "";
      String orderBy = "";

      if (isShop) {
        if (categoryId != "") {
          shopsWhereClause =
              " WHERE (category_name NOT LIKE '%Food & Dining%' AND category_name NOT LIKE '%Restaurants%') AND category_name NOT LIKE '%Hide%' AND rcmap.name NOT LIKE '%Vacant%' AND display = 1 AND category_id = '" +
                  categoryId +
                  "' ";
        } else {
          shopsWhereClause =
              " WHERE (category_name NOT LIKE '%Food & Dining%' AND category_name NOT LIKE '%Restaurants%') AND category_name NOT LIKE '%Hide%' AND rcmap.name NOT LIKE '%Vacant%' AND display = 1";
        }
      } else {
        if (categoryId != "") {
          shopsWhereClause =
              " WHERE (category_name LIKE '%Food & Dining%' OR category_name LIKE '%Restaurants%') AND category_name NOT LIKE '%Hide%' AND rcmap.name NOT LIKE '%Vacant%' AND display = 1 AND category_id = '" +
                  categoryId +
                  "' ";
        } else {
          shopsWhereClause =
              " WHERE (category_name LIKE '%Food & Dining%' OR category_name LIKE '%Restaurants%') AND category_name NOT LIKE '%Hide%' AND rcmap.name NOT LIKE '%Vacant%' AND display = 1 ";
        }
      }

      groupBy = " GROUP BY rcmap.rid  ";
      orderBy = " ORDER BY name COLLATE NOCASE ASC ";

      if (favourite == 1) {
        shopsWhereClause =
            " WHERE rcmap.favourite=" + favourite.toString() + " ";
      }

      String searchQueryCondition = "";

      if (searchQuery != null && searchQuery != "") {
        searchQueryCondition = "  AND (rcmap.name LIKE '%" +
            searchQuery +
            "%' OR rcmap.sub_locations LIKE '^" +
            searchQuery +
            "%' OR category_name LIKE '%" +
            searchQuery +
            "%') ";
      }

      String query = "WITH RECURSIVE menu_tree (category_id, category_name, level, parent,category_color, display) AS ( \n" +
          "SELECT\n" +
          " category_id, \n" +
          " '' || name, \n" +
          " 0, \n" +
          " parent,\n" +
          " category_color,\n" +
          " display \n" +
          " FROM categories \n" +
          " WHERE parent = ''\n" +
          " UNION ALL\n" +
          " SELECT\n" +
          " mn.category_id, \n" +
          " mt.category_name || ' <> ' || mn.name, \n" +
          " mt.level + 0, \n" +
          " mt.category_id,\n" +
          " mn.category_color,\n" +
          " mn.display \n" +
          " FROM categories mn, menu_tree mt \n" +
          " WHERE mn.parent = mt.category_id \n" +
          " ) \n" +
          " SELECT DISTINCT category_id, category_name as category,display, * FROM menu_tree mt\n" +
          " INNER JOIN (Select DISTINCT * FROM retail_category_map rmap INNER JOIN \n" +
          " retail_units ret ON ret.rid = rmap.rid) rcmap ON rcmap.cid = mt.category_id \n" +
          searchQueryCondition +
          shopsWhereClause +
          groupBy +
          orderBy;

      debugPrint('query_is :-    $query');

      await _db.transaction((txn) async {
        data = await txn.rawQuery(query);
      });

      debugPrint('database_testing:-  all search  ${data.length}');
      debugPrint('database_testing:-   $data');
      List<RetailWithCategory> _allSearchList = [];
      data.forEach((element) {
        _allSearchList.add(RetailWithCategory.fromJson(element));
      });
      _allSearchList.sort((a, b) => a.name.compareTo(b.name));
      return _allSearchList;
    } catch (e) {
      debugPrint('error:- database :-  $e');
    }
    return [];
  }
}
