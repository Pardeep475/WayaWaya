class NetworkConstants {
  static final NetworkConstants _networkConstants =
      NetworkConstants._internal();

  factory NetworkConstants() {
    return _networkConstants;
  }

  NetworkConstants._internal();

  static const base_url = "https://api.omnistride.net/api/v1/";

  static const base_url_image =
      "https://app.treadstoneus.com/application/uploads/users/";

  // end points
  static const login_end_point = "accounts/guest";
  static const fetch_user_detail = "guests";
  static const forgot_password_end_point = "resetPassword/";
  static const new_password_end_point = "newPassword";
  static const change_password_end_point = "changepassword";
  static const get_profile_end_point = "getprofile";
  static const upload_image_end_point = "uploadimage";
  static const factor_view_auth_end_point = "auth";
  static const invoice_end_point = "invoice";
  static const pre_invoice_end_point = "preinvoice";
  static const get_invoice_end_point = "getInvoices";
  static const get_invoice_with_pagination_end_point = "getInvoicePagination";
}
