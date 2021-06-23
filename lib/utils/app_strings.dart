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

  static const String DEVICE_SEPARATOR = "~^";
  static const String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
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
  static const String USER_GENDER_MALE = "mr";
  static const String USER_GENDER_FEMALE = "ms";
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
  static const enter_your_email_phone_username =
      "Enter your email, phone number or username.";
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
  static const app_version = "App version - v1.0.0";
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
  static const String share = "Share";
  static const String locate = "Locate";
  static const String redeem = "Redeem";

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
  static const RESTAURANT_SCREEN_ROUTE = "RESTAURANT_SCREEN_ROUTE";

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

  // keys
  static const String OFFER_CAMPAIGN = "offer";
  static const String EVENT_CAMPAIGN = "event";
  static const String WHATSON_CAMPAIGN = "whatson";
  static const String ACTIVITIES_CAMPAIGN = "activity";
  static const String CINEMA_CAMPAIGN = "cinema";

  static const String MAP_STORE_KEY = 'storeId';
}
