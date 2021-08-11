class AppString {
  static final AppString _appString = AppString._internal();

  factory AppString() {
    return _appString;
  }

  AppString._internal();

  static const home_menu = "Home";
  static const offers_menu = "Offers";
  static const events_menu = "Events";
  static const shops_menu = "Shops";
  static const restaurants_menu = "Restaurants";
  static const rewards_menu = "Rewards";
  static const the_mall_menu = "The Mall";
  static const mall_map_menu = "Mall Map";

  static const DEFAULT_MALL_KEY =
      'twG0iiIbMw3IxS5MMw|R6f29ZKdAz7TaDA1cJFFSwtysP88doc_Vwq8EbJfPIN2I';

  static const MAP_URL_LIVE =
      "https://acbash.com/orioncepheid/mapfolder/map/twodmap/vectormap/mod.html";

  // session Manager
  static const IS_FIRST_TIME = "IS_FIRST_TIME";
  static const DEFAULT_MALL = "DEFAULT_MALL";
  static const AUTH_HEADER = "AUTH_HEADER";
  static const CURRENT_DEVICE = "CURRENT_DEVICE";
  static const IS_LOGIN_SCREEN_VISIBLE = "IS_LOGIN_SCREEN_VISIBLE";
  static const JWT_TOKEN = "JWT_TOKEN";
  static const REFRESH_TOKEN = "REFRESH_TOKEN";
  static const USER_DATA = "USER_DATA";
  static const SMALL_DEFAULT_MALL_DATA = "SMALL_DEFAULT_MALL_DATA";
  static const IS_LOGIN = "IS_LOGIN";
  static const String PREF_GUEST_USER_CATEGORIES = "PREF_GUEST_USER_CATEGORIES";
  static const String PREF_GUEST_USER_NOTIFICATIONS =
      "PREF_GUEST_USER_NOTIFICATIONS";
  static const String PREF_GUEST_USER_FAVOURITE_MALL =
      "PREF_GUEST_USER_FAVOURITE_MALL";
  static const String PREF_GUEST_USER_CURRENCY = "PREF_GUEST_USER_CURRENCY";
  static const String PREF_GUEST_USER_LANGUAGE = "PREF_GUEST_USER_LANGUAGE";
  static const String SYNC_DATE = "SYNC_DATE";
  static const String USER_IN_MALL = "USER_IN_MALL";
  static const String PREF_OFFER_OPEN_JSON = "PREF_OFFER_OPEN_JSON";
  static const String GESTURE_HOME = "GESTURE_HOME";
  static const String GESTURE_MENU = "GESTURE_MENU";
  static const String GESTURE_DETAIL_RETAIL_UNIT = "GESTURE_DETAIL_RETAIL_UNIT";
  static const String GESTURE_MAP = "GESTURE_MAP";
  static const String GESTURE_REWARDS = "GESTURE_REWARDS";
  static const String GESTURE_LOYALTY = "GESTURE_LOYALTY";
  static const String LAST_TIME_ALERT = "LAST_TIME_ALERT";
  static const String IGNORE_THIS_VERSION = "IGNORE_THIS_VERSION";

  static const String DEVICE_SEPARATOR = "~^";
  static const String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
  static const String BUILD_TIME = "2021-07-17 00:00:00";
  static const String DATE_FORMAT_UPDATE = "yyyy-MM-dd hh:mm:ss a";
  static const String DATE_FORMAT_WITHOUT_TIME = "yyyy-MM-dd 00:00:00";
  static const String STATE = "state";

  static const String PRIVACY_POLICY_URL =
      "http://www.connectwayawaya.co.za/privacy-notice/";
  static const String TERMS_CONDITION_URL =
      "http://www.connectwayawaya.co.za/terms-conditions/";

  static const app_name = "Waya Waya";
  static const check_your_internet_connectivity =
      "Unable to connect to server, please check your internet connection or try again later.";
  static const no_internet_connectivity =
      "Your device not connected to Internet please check your internet connection";
  static const no_service_found_exception = "No service found ";
  static const invalid_format_exception = "Invalid response format";
  static const bad_request_exception = "Bad Request";
  static const un_authorised_exception = "Unauthorised exception";
  static const processing_data = "Processing data...";
  static const skip = "SKIP";
  static const login = "Login";
  static const email = "Email";
  static const no_points_entered = "Please enter points to redeem";
  static const enter_points = "Enter points to redeem";
  static const enter_points_error = "Please enter points";
  static const password = "Password";
  static const confirm_password = "Confirm Password";
  static const submit = "Submit";
  static const cancel = "Cancel";
  static const sign_up = "SIGN UP";
  static const success = "Success";
  static const error = "Error";
  static const password_reset = "Password Reset";
  static const request_code = "Request Code";
  static const authentication_code = "Authentication Code";
  static const ok = "OK";
  static const mr = "Mr.";
  static const ms = "Ms.";
  static const m = "Unwilling to Specify";
  static const String USER_GENDER_MALE = "mr";
  static const String USER_GENDER_FEMALE = "ms";
  static const String USER_GENDER_UKNOWN = "unknown";
  static const forgot_password = "Forgot password?";
  static const not_account_yet = "No account yet? Create one";
  static const enter_valid_email_address = "Enter valid email address";
  static const first_name = "First Name";
  static const enter_your_first_name = "Enter your first name";
  static const last_name = "Last Name";
  static const enter_your_last_name = "Enter your last name";
  static const dob = "Date of Birth";
  static const enter_your_dob = "Enter your date of birth";
  static const cell_number = "Cell Number";
  static const enter_your_cell_number = "Enter your cell number";
  static const privacy_policy = "Privacy Policy";
  static const news_letter = "Newsletter";
  static const disagree = "DISAGREE";
  static const agree = "AGREE";
  static const sorry = "Sorry";
  static const preferences = "PREFERENCES";
  static const settings = "SETTINGS";
  static const logout = "LOGOUT";
  static const term_and_conditions = "Terms and Conditions";
  static const user_config = "User Config";
  static const my_account = "My Account";
  static const preferences_small = "Preferences";
  static const my_devices = "My Devices";
  static const my_favourites = "My Favourites";
  static const already_have_an_account = "Already have an Account?";
  static const enter_authentication_code = "Enter valid authentication code";
  static const enter_valid_password = "Enter valid password";
  static const enter_valid_confirm_password = "Enter valid confirm password";
  static const password_and_confirm_password_must_be_same =
      "Password and confirm password must be same";
  static const email_validation_error_message = "Please enter valid Email";
  static const enter_your_email_phone_username = "Enter your email address.";
  static const verification_email_has_been_sent =
      "Verification email has been sent to registered email address";
  static const unable_to_verify_email = "Unable to verify email";
  static const password_change_successfully = "Password changed successfully";
  static const select_your_default_mall = "Select Your Default Mall";
  static const invalid_cred_check_user_name_and_password =
      "Invalid Credentials. Check username and password.";
  static const String error_term_and_conditions =
      "Please agree your terms & conditions";
  static const String currently_not_logged_in =
      "Currently you are not logged in to access this feature please login with valid credentials.";
  static const app_version = "App version - v";
  static const favourite_malls = "Favourite Malls";
  static const notification_frequency = "Notification Frequency";
  static const alternate_currency = "Alternate Currency";
  static const default_language = "Default Language";
  static const home = "Home";
  static const String ANDROID_NAME = "ANDROID";
  static const String IOS_NAME = "IOS";
  static const String device_sync_error =
      "Unable to sync devices since no internet. You\'ll able to see only locally saved devices for now.";
  static const String save = "Save";
  static const String my_profile = "MY PROFILE";
  static const String your_account_updated_successfully =
      "Your account updated successfully.";
  static const String home_page = "HOMEPAGE";
  static const String event = "EVENT";
  static const String offer = "OFFER";
  static const String interested_categories = "Interested Categories";
  static const String your_preferences_saved_successfully =
      "Your preferences saved successfully";
  static const String all = "ALL";
  static const String offers = "OFFERS";
  static const String events = "EVENTS";
  static const String shops = "SHOPS";
  static const String restaurant = "RESTAURANT";
  static const String no_result_to_show = "No Result To Show";
  static const String go_to_home_page = "GO TO HOME PAGE";
  static const String no_offer_found = "No Offers Found";
  static const String no_record_found = "No Record Found";
  static const String share = "Share";
  static const String locate = "Locate";
  static const String redeem = "Redeem";
  static const String no_website = "Web Address not available";
  static const String no_number = "Number not available";
  static const String exit_content = "Are you sure you want to exit?";
  static const String find_rewards = "Find Rewards";
  static const String header_title1_p1 = "– Click on the Rewards menu button";
  static const String header_title1_p2 =
      "– You are presented with ALL the available rewards";
  static const String header_title1_p3 =
      "– You can search for rewards within specific categories such as “ Food and Drink”, selectable by sliding through the category slider and clicking on the category of interest.";
  static const String header_title1_p4 =
      "– You can further reset the filter to “ALL”";
  static const String header_title1_p5 =
      "– You can find your Rewards Wallet by clicking that option, at the bottom of the screen.";

  static const String earn_points = "Earn points";
  static const String header_title2_p1 =
      "– We reward you for using the Connect Waya-Waya App. See Points Awarded section";
  static const String header_title2_p2 =
      "– On entering a participating shop, ask for the QR code, and scan it to earn points.";
  static const String header_title2_p3 =
      "– The QR Code scan option, is located on your middle menu button, click and scan.";
  static const String header_title2_p4 =
      "– Note: You do need to physically be at the mall and inside the shop, to scan for points.";
  static const String header_title2_p5 =
      "– Points scanned are immediately added to your Rewards Wallet, accessible frrom the Rewards screen.";

  static const String redeem_points = "Redeem points";
  static const String header_title3_p1 =
      "– When you find a Reward you are interested in, you can click the Waya-Waya FISTPUMP icon, to initiate the reward.";
  static const String header_title3_p2 =
      "– A GREEN FISTPUMP will indicate you have sufficient points to redeem the Reward";
  static const String header_title3_p3 =
      "– A RED FISTPUMP indicates you still need to earn more points.";
  static const String header_title3_p4 =
      "– You can click the Reward and open the Rewards Detail page, and from there redeem the reward.";

  static const String rewards_wallet = "Rewards Wallet";
  static const String header_title4_p1 =
      "– The Rewards wallet, shows you how many points you have, as well as how many points you have redeemed.";
  static const String header_title4_p2 =
      "– You will also see your Monthly totals of points balance.";
  static const String header_title4_p3 =
      "– Click each month to expand it, and examine transaction details";
  static const String header_title4_p4 = "– Key to PIE chart:";

  static const String header_title4_p4_1 =
      "\u2022 Available - The amount of points you have that you can still redeem.";
  static const String header_title4_p4_2 =
      "\u2022 Earn - The total number of points you have earned.";
  static const String header_title4_p4_3 =
      "\u2022 Redeemed - The total number of points you have redeemed at point of sale. ";

  static const String loyalty_title = "Points Award Rules";
  static const String open_the_app = "Open the APP";
  static const String h1_point1 =
      "– More than 1 times a week and earn 5 points";
  static const String h1_point2 =
      "– More than 3 times a week and earn 10 points";
  static const String h1_point3 =
      "– More than 5 times a week and earn 15 points";
  static const String h1_note = "Points can only be earned once per day";

  static const String header_2 = "View a Promotion";
  static const String h2_point1 =
      "– More than 1 times a month and earn 5 points";
  static const String h2_point2 =
      "– More than 3 times a month and earn 10 points";
  static const String h2_point3 =
      "– More than 5 times a month and earn 15 points";
  static const String h2_note = "Points can only be earned once per day";

  static const String header_3 = "View Ads or Offers";
  static const String h3_point1 =
      "– More than 1 times a month and earn 5 points";
  static const String h3_point2 =
      "– More than 3 times a month and earn 10 points";
  static const String h3_point3 =
      "– More than 5 times a month and earn 15 points";
  static const String h3_note = "Points can only be earned once per day";

  static const String header_4 = "Visit a Store";
  static const String h4_point1 =
      "– More than 1 times a month and earn 5 points";
  static const String h4_point2 =
      "– More than 3 times a month and earn 10 points";
  static const String h4_point3 =
      "– More than 5 times a month and earn 15 points";
  static const String h4_note = "Points can only be earned once per day";

  static const String header_5 = "Visit the Mall";

  static const String intro =
      "Introducing the new Connect Waya-Waya® Rewards Programme!";
  static const String some_intro_text =
      "Depending on how many times per month you access the app, view ads or offers, visit the mall or store, will determine how many points you accumulate, which can be used at your favourite stores and restaurants. You can also earn additional rewards points by simply visiting any of our participating shopping centres and scanning the QR codes in-store. Earning rewards points has never been easier!”";

  static const String quality_for_rewards =
      "See if you qualify for a Reward Voucher?";
  static const String no_rewards_available =
      "Currently no rewards available under this category but please come back soon.";
  static const String offer_validation_error =
      "Not available for current loyalty level";
  static const String offer_user_logged_in_error =
      "Only for registered members.";
  static const String not_at_venue =
      "You need to visit the mall to earn points.";
  static const String not_at_venue_msg_android =
      "You need to visit the mall to earn/redeem shop points. If you are at the mall please check following and restart your app. \n ● You received a Welcome message when visiting the mall. \n ● You have this mall selected as your current mall.";
  static const String not_at_venue_msg_ios =
      "You need to visit the mall to earn/redeem shop points. If you are at the mall please check following and restart your app. \n ● Your settings: location services is set to \"Always\"for the Connect Waya-Waya® app. \n ● You received a Welcome message when visiting the mall. \n ● You have this mall selected as your current mall.";
  static const String redemption = "Points Redeemed";
  static const String view_offer = "View Offer";
  static const String mall_visit = "Mall Visit";
  static const String store_visit = "Store Visit";
  static const String scan = "Scan QR Code for earning points";
  static const String qr_scan = "QR Scan";
  static const String membership = "Membership";
  static const String redeem_offer = "REDEEM OFFER";
  static const String redeem_msg_2 =
      "If you have not shown the redemption page to the cashier, you will forfeit your points.";
  static const String no_shop_available =
      "Please check the selected mall. The shop you\'r looking for is not available.";
  static const String no_sufficient_points =
      "You don\'t have sufficient points to redeem.";
  static const String you_need_five_points = "You need 5 additional points";
  static const String info = "Info";
  static const String redeem_now = "Redeem Now";
  static const String loyalty_points_added_successfully =
      "The QR code scan was successful. Loyalty points will be evaluated and allocated to your account.";
  static const String for_video_calling_please_allow =
      "For Video Calling, please allow the app to Appear on Top so that incoming video calls can be prioritized.";
  static const String navigation_draw_over_the_app =
      "You can also give the permission manually Tap (Settings > Apps > WayaWaya > Advanced > Draw over other apps)";
  static const String close = "Close";
  static const String allow = "Allow";
  static const String menu = "Menu";
  static const String change_mall = "Change\nMall";
  static const String account_detail = "Account\nDetails";
  static const String swipe_to_view_more_offers = "Swipe to view\nmore offers";
  static const String swipe_to_view_more_events = "Swipe to view\nmore Events";
  static const String swipe_to_view_more_ads = "Swipe to view\nmore ads";
  static const String click_to_access_details = "Click to\naccess details";
  static const String scan_rewards = "Scan\nRewards";
  static const String click_to_view_web_page = "Click to view webpage";
  static const String click_to_dial_the_number = "Click to dial the number";
  static const String swipe_and_zoom_to_find_your_shop =
      "Swipe and Zoom to find your shop";
  static const String view_category_or_services = "View Category or service";
  static const String slide_and_click = "Slide & click";
  static const String show_detail = "Show details";
  static const String slide = "Slide";
  static const String earned_points = "Earned\nPoints";
  static const String available_points = "Available\nPoints";
  static const String redeemed_points = "Redeemed\nPoints";
  static const String show_details_new_line = "Show\ndetails";
  static const String your_points = "Your points";
  static const String help = "Help";

  // Routes
  static const LOGIN_SCREEN_ROUTE = "LOGIN_SCREEN_ROUTE";
  static const SIGN_UP_SCREEN_ROUTE = "SIGN_UP_SCREEN_ROUTE";
  static const FORGOT_PASSWORD_SCREEN_ROUTE = "FORGOT_PASSWORD_SCREEN_ROUTE";
  static const SPLASH_SCREEN_ROUTE = "SPLASH_SCREEN_ROUTE";
  static const MALL_SCREEN_ROUTE = "MALL_SCREEN_ROUTE";
  static const HOME_SCREEN_ROUTE = "HOME_SCREEN_ROUTE";
  static const SELECT_PREFERENCES_SCREEN_ROUTE =
      "SELECT_PREFERENCES_SCREEN_ROUTE";
  static const SETTINGS_SCREEN_ROUTE = "SETTINGS_SCREEN_ROUTE";
  static const MY_DEVICES_SCREEN_ROUTE = "MY_DEVICES_SCREEN_ROUTE";
  static const MY_ACCOUNT_SCREEN_ROUTE = "MY_ACCOUNT_SCREEN_ROUTE";
  static const SEARCH_SCREEN_ROUTE = "SEARCH_SCREEN_ROUTE";
  static const OFFER_SCREEN_ROUTE = "OFFER_SCREEN_ROUTE";
  static const OFFER_DETAILS_SCREEN_ROUTE = "OFFER_DETAILS_SCREEN_ROUTE";
  static const EVENT_SCREEN_ROUTE = "EVENT_SCREEN_ROUTE";
  static const EVENT_DETAILS_ROUTE = "EVENT_DETAILS_SCREEN_ROUTE";
  static const TWO_D_MAP_SCREEN_ROUTE = "TWO_D_MAP_SCREEN_ROUTE";
  static const SHOP_SCREEN_ROUTE = "SHOP_SCREEN_ROUTE";
  static const SHOP_DETAIL_SCREEN_ROUTE = "SHOP_DETAIL_SCREEN_ROUTE";
  static const RESTAURANT_SCREEN_ROUTE = "RESTAURANT_SCREEN_ROUTE";
  static const RESTAURANT_DETAIL_SCREEN_ROUTE =
      "RESTAURANT_DETAIL_SCREEN_ROUTE";
  static const CUSTOM_WEB_VIEW_SCREEN_ROUTE = "CUSTOM_WEB_VIEW_SCREEN_ROUTE";
  static const REWARDS_SCREEN_ROUTE = "REWARDS_SCREEN_ROUTE";
  static const THE_MALL_SCREEN_ROUTE = "THE_MALL_SCREEN_ROUTE";
  static const QR_SCANNER_SCREEN_ROUTE = "QR_SCANNER_SCREEN_ROUTE";
  static const REWARDS_DETAIL_SCREEN_ROUTE = "REWARDS_DETAIL_SCREEN_ROUTE";
  static const LOYALTY_SCREEN_ROUTE = "LOYALTY_SCREEN_ROUTE";

// db
  static const String ADMIN_DB_FILE = "admin.db";

  // table names
  static const String VENUE_PROFILE_TABLE_NAME = "venue_profile";
  static const String MENU_TABLE_NAME = "menu";
  static const String APP_SOFTWARE_PARAMETER_TABLE_NAME = "app_sw";
  static const String MAIN_MENU_PERMISSION_TABLE_NAME = "main_menu_permission";
  static const String IN_MALL_TABLE_NAME = "whats_happening";
  static const String MALL_PROFILE_TABLE_NAME = "mall_profiles";
  static const String OFFER_TABLE_NAME = "offer";
  static const String VENUE_TABLE_NAME = "venues";
  static const String BEACON_TABLE_NAME = "beacon";
  static const String BEACON_RETAIL_UNIT_TABLE_NAME = "retail_units";
  static const String CATEGORIES_TABLE_NAME = "categories";
  static const String CAMPAIGN_TABLE_NAME = "campaign";
  static const String FAVOURITE_TABLE_NAME = "favourites";
  static const String TRIGGER_ZONES_TABLE_NAME = "trigger_zones";
  static const String LOYALTY_TABLE_NAME = "loyalty";
  static const String RETAIL_CATEGORY_TABLE_NAME = "retail_category_map";
  static const String PARKING_TABLE_NAME = "parking";
  static const String CINEMAS_TABLE_NAME = "cinemas";
  static const String THEME_TABLE_NAME = "theme";
  static const String SERVICES_TABLE_NAME = "services";

  // keys
  static const String OFFER_CAMPAIGN = "offer";
  static const String EVENT_CAMPAIGN = "event";
  static const String WHATSON_CAMPAIGN = "whatson";
  static const String ACTIVITIES_CAMPAIGN = "activity";
  static const String CINEMA_CAMPAIGN = "cinema";

  static const String MAP_STORE_KEY = 'storeId';

  static bool POINT_SHOW = false;
}
