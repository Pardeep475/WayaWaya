import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wayawaya/app/common/logger/actions/action_filter.dart';
import 'package:wayawaya/app/common/logger/actions/analytics_output.dart';
import 'package:wayawaya/app/common/logger/actions/my_log_output.dart';
import 'package:wayawaya/app/common/logger/actions/pageview_filter.dart';
import 'package:wayawaya/app/common/logger/actions/print_output.dart';
import 'package:wayawaya/app/common/logger/click_log/click_log.dart';
import 'package:wayawaya/app/common/logger/click_log/device_details.dart';
import 'package:wayawaya/app/common/logger/logger.dart';
import 'package:wayawaya/utils/utils.dart';

class EventLoggerService {
  // make it singleton class
  static final EventLoggerService _syncService = EventLoggerService._internal();

  factory EventLoggerService() {
    return _syncService;
  }

  EventLoggerService._internal();

  static final logger = Logger(
    filters: [
      PageViewFilter(tagPattern: 'page_view'),
      ActionFilter(tagPattern: 'action'),
    ],
    outputs: [
      PrintOutput(tagPattern: '**'),
      MyLogOutput(tagPattern: 'my.**'),
      AnalyticsOutput(tagPattern: 'ga.**'),
    ],
  );

  /*UUID's for activities*/
  static String InTheMall = "097758d69f544b75b2923eb8e05f8e16";
  static String Offers = "dd31e9763e3342fa82f96becf6464204";
  static String Events = "de6e99c8086d418e92ae35d933543302";
  static String OffersDetails = "f56dceed59cf4655bb249015447f6942";
  static String RewardOffer = "1f938a3504224f39869dd7c34d2b4a96";
  static String EventsDetails = "3a45484ae6cb43e89019d5922bb1dea1";
  static String Shops = "ce37dc197662437da4c83d35e71ddaf5";
  static String Restaurants = "dba9865c0207407584def41737f70b11";
  static String Loyalty = "8b3eb0e990fb4830a67baec5d72d8241";
  static String TheMallMainPage = "59bfefa9d19e42a3be7bb0a6714931e6";
  static String MallMap = "4b160a80bda947f1b1ddd4385d10614d";

  //     static String TwoDMallMap     = "a737c4356c7b4cef828f7def575c1462";
  static String Settings = "4717f75ec1e648dba3432ad469bf1005";
  static String MyDevices = "8121f2ba950641ba9ec41fd7c897175c";
  static String SignUp = "e774570666b54e198e11b2c3d811beb9";
  static String Login = "bad4e7dfe78f40b88372fb9b3664b291";
  static String ForgotPassword = "c6cd0bbdbc7b42c4bc69e2c5e2dac20e";
  static String Preferences = "78fb66760ac648019285f3418ab42951";
  static String QRScan = "3ae8f087afed4228b2313717d2378023";

  //     static String TheMallChild    = "d90c04b142814b5b8857650bb42b1711";
  static String OpeningHours = "ab7fcab8e00d461b94963bfb42133e4f";
  static String ContactUs = "7c951c0f9cd349378f492a187f87cd44";
  static String Services = "cc34f073f72e4dbe8517fe78b6a4a893";
  static String GettingHere = "0d91be961b7b447dae1fba385ff61c19";
  static String ShopDetail = "cbcc91a3d9b04fad916f403be4adede5";
  static String RestaurantDetail = "ec04a4db4f6043a6ab95c7d77c0198cd";
  static String MyAccount = "6f1a521fa46d40faa8a434c739332409";
  static String GlobalSearch = "5a071102e45d4849a5d8c77d0c87d3ac";
  static String Cinema = "884f150f193b4a7eaae8b784a4e84102";
  static String Parking = "12661de8225146e5b20df89fee9f8683";
  static String Fountain = "92b32d9b8a5d4ba48f1c42863f69da73";
  static String Mall360View = "9f4e157732b54a51bfc5c8515627ce52";
  static String Favourites = "30808f2ff3e141dd890a3f304c9cf3e0";
  static String AppLaunch = "79ebdb5403404eb98fd0fe5cf0468312";


  // group for Puree
   static String LOG_GROUP_ADVERTISMENT = "Advertisement";
   static String LOG_GROUP_NAVIGATION = "Navigation";
   static String LOG_GROUP_PERFORMED_ACTION = "PerformedAction";
   static String LOG_GROUP_CAMPAIGN = "campaigns";
   static String LOG_GROUP_LOCATION = "location";
  // The constants below are less interesting than those above.
   static String LOG_GROUP_ADS = "advertisement";
  // log action
   static String LOG_ACTION_EXPAND_CATEGORY = "expand_category";
   static String LOG_ACTION_TRIGGERZONES_SYNCED = "triggerzones_synced";
   static String LOG_ACTION_LIKED = "like";
   static String LOG_ACTION_SOCIAL_LOGIN = "social_login";
  //Type for Puree Log's
   static String LOG_TYPE_CATEGORY_LIST = "category list";
   static String LOG_TYPE_CAMPAIGN = "campaignLog";
   static String LOG_TYPE_REWARDS = "rewardsLog";
  //     static String LOG_TYPE_REWARDS = "rewards";
   static String LOG_TYPE_Home = "app_home";
   static String LOG_TYPE_LOCATION_LOGGER = "demographics";
   static String LOG_TYPE_BEACON = "ibeacon";
   static String LOG_TYPE_BEACON_DISCOVERED = "ibeacon_discovered";
   static String LOG_TYPE_NOTIFICATION_DATA = "notification_data";
   static String LOG_TYPE_ADVERTISEMENT_DATA = "advertisement_data";
   static String LOG_TYPE_NOTIFICATION_SENT = "notification_sent";
   static String LOG_TYPE_GEOFENCE = "geofence";
   static String LOG_TYPE_NAVIGATION = "click";
   static String LOG_TYPE_NAVIGATION_VIEW = "view";
   static String LOG_TYPE_LOGIN = "login";
   static String LOG_TYPE_LOGIN_CANCEL = "login_cancel";
   static String LOG_TYPE_SIGNUP = "sign_up";
   static String LOG_TYPE_LOGOUT = "logout";
   static String LOG_TYPE_FORGOT_PASSWORD = "forgot_password";
   static String LOG_TYPE_SKIP_LOGIN = "skip_login";
   static String LOG_TYPE_PREFERENCE = "preference";
   static String LOG_TYPE_CHANGE_PASSWORD = "change_password";
   static String LOG_TYPE_LOCATE = "locate";
   static String LOG_TYPE_SHARE = "share";
   static String LOG_TYPE_OFFER = "offers";
   static String LOG_TYPE_SCAN = "scan";
   static String LOG_TYPE_SEARCH = "search";
   static String LOG_TYPE_ATM = "atms";
   static String LOG_TYPE_PARKING = "parking";
  
  
  
  static void eventLogger(
      {String uuid,
      String action,
      String type,
      String group,
      String data}) async {
    try {
      debugPrint("isProduction in Log----%s  ");
      String deviceInfo = Platform.isAndroid ? "Android" : "IOS";
      var uniqueIdBase = Uuid();
      String uniqueID = uniqueIdBase.v1();
      ClickLog clickLog = ClickLog();

      clickLog.uuid = uniqueID;
      clickLog.type = type;

      DeviceDetails deviceDetails = DeviceDetails();
      deviceDetails.platform = deviceInfo;
      String systemVersion = await Utils.getDeviceInfo(true);
      String deviceName = await Utils.getDeviceInfo(false);
      deviceDetails.system_version = systemVersion;
      deviceDetails.device_name = deviceName;
      deviceDetails.id = uuid;

      clickLog.device = deviceDetails;
      String getAppVersion = Utils.getAppVersionName();
      clickLog.appVersion = getAppVersion;
      clickLog.group = group;
      clickLog.action = action;
      clickLog.data = data;
      clickLog.production = "";

      logger.post(clickLog.toJson(),tag: action);
    } catch (e) {
      debugPrint("Exception for puree in Constant's $e");
    }
  }
}
