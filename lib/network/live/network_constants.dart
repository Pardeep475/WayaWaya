class NetworkConstants {
  static final NetworkConstants _networkConstants =
      NetworkConstants._internal();

  factory NetworkConstants() {
    return _networkConstants;
  }

  NetworkConstants._internal();

  static const base_url = "https://api.omnistride.net/api/v1/";

  static const base_url_image =
      "res.cloudinary.com/intelipower/image/upload";


  // end points
  static const login_end_point = "accounts/guest";
  static const fetch_user_detail = "guests";
  static const forgot_password_end_point = "resetPassword/";
  static const new_password_end_point = "newPassword";
  static const register_user_end_point = "register/users";
  static const update_user_end_point = "guests/";
  static const campaigns_end_point = "campaigns";
  static const venue_me_end_point = "venues/me";
  static const retail_unit_end_point = "retailUnits";
  static const venues_end_point = "venues.php";

}
