class AppString {
  static final AppString _appString = AppString._internal();

  factory AppString() {
    return _appString;
  }

  AppString._internal();

  // session Manager
  static const IS_FIRST_TIME = "IS_FIRST_TIME";

  static const String PRIVACY_POLICY_URL =
      "http://www.connectwayawaya.co.za/privacy-notice/";
  static const String TERMS_CONDITION_URL =
      "http://www.connectwayawaya.co.za/terms-conditions/";

  static const app_name = "Waya Waya";
  static const check_your_internet_connectivity =
      "Your Internet seems slow please check your internet connection";
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
  static const success = "Success";
  static const error = "Error";
  static const password_reset = "Password Reset";
  static const request_code = "Request Code";
  static const authentication_code = "Authentication Code";
  static const ok = "OK";
  static const mr = "Mr.";
  static const ms = "Ms.";
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
  static const term_and_conditions = "Terms and Conditions";
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

  // Routes
  static const LOGIN_SCREEN_ROUTE = "LOGIN_SCREEN_ROUTE";
  static const SIGN_UP_SCREEN_ROUTE = "SIGN_UP_SCREEN_ROUTE";
  static const FORGOT_PASSWORD_SCREEN_ROUTE = "FORGOT_PASSWORD_SCREEN_ROUTE";
  static const SPLASH_SCREEN_ROUTE = "SPLASH_SCREEN_ROUTE";
  static const MALL_SCREEN_ROUTE = "MALL_SCREEN_ROUTE";
}
