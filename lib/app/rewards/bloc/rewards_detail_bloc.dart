import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/dialogs/full_screen_show_qr_and_barcode_generator_dialog.dart';
import 'package:wayawaya/app/offers/model/voucher.dart';
import 'package:wayawaya/network/live/repository/api_repository.dart';
import 'package:wayawaya/network/local/sync_service.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_new.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class RewardsDetailBloc {
  final _repository = ApiRepository();

  redeemLoyaltyPoints(BuildContext context, int loyaltyPoints, String shopId,
      String campaignId, String shopName, dynamic mVoucher) async {
    Utils.checkConnectivity().then((value) async {
      if (value != null && value) {
        String userData = await SessionManager.getUserData();
        UserDataResponse _response = userDataResponseFromJson(userData);
        LoyaltyNew loyalty = new LoyaltyNew();
        loyalty.userId = _response.userId;
        loyalty.type = "redemption";
        loyalty.points = loyaltyPoints;
        loyalty.timestamp =
            Utils.getStringFromDate(DateTime.now(), AppString.DATE_FORMAT);
        loyalty.shopId = shopId;
        loyalty.campaignId = campaignId;
        debugPrint(
            "OFFER_REDEEM_LOYALTY: %s , %s onCreate : ${loyalty.toString()}");

        updateLoyaltyPoints(context, loyalty, shopName, -1, false, mVoucher);
      } else {
        // show internet dialog
        showErrorDialog(
          icon: Icon(
            FontAwesomeIcons.exclamationTriangle,
            color: AppColor.orange_500,
          ),
          title: AppString.error.toUpperCase(),
          content: AppString.check_your_internet_connectivity,
          buttonText: AppString.ok.toUpperCase(),
          context: context,
          onPressed: () => Navigator.pop(context),
        );
      }
    });
  }

  updateLoyaltyPoints(BuildContext context, LoyaltyNew loyalty, String shopName,
      int monthNo, bool isOfferView, dynamic mVoucher) async {
    try {
      Utils.commonProgressDialog(context);
      dynamic response =
          await _repository.postAppOpenLoyaltyTransaction(loyaltyNew: loyalty);
      Navigator.pop(context);

      if (response is DioError) {
        if (response.response.statusCode == 401) {
          // refresh token
          if (isOfferView) {
            bool returnValue = await SyncService.updateRefreshToken();
            if (returnValue) {
              updateLoyaltyPoints(
                  context, loyalty, shopName, monthNo, isOfferView, mVoucher);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppString.LOGIN_SCREEN_ROUTE, (route) => false);
            }
          } else {
            debugPrint("testing__:-   ${response.response.data['message']}");
          }
        }
      } else {
        if (isOfferView) {
          // check user api implemented
          await SyncService.checkUser();
        } else {
          String msg =
              "You have redeemed ${loyalty.points} points against the purchase at " +
                  shopName +
                  "." +
                  "\n" +
                  "Date: " +
                  Utils.getStringFromDate(
                      DateTime.now(), AppString.DATE_FORMAT) +
                  "." +
                  "\n\n" +
                  AppString.redeem_msg_2;
          Voucher voucher;
          try {
            voucher = Voucher.fromJson(jsonDecode(mVoucher));
          } catch (e) {
            voucher = Voucher.fromJson(jsonDecode(jsonDecode(mVoucher)));
          }

          String type;
          String code;
          if (voucher.enabled) {
            if (voucher.code != null && voucher.code.isNotEmpty) {
              type = voucher.displayMode;
              code = voucher.code;
            }
          }
          Navigator.push(
            context,
            FullScreenShowQrAndBarCodeGeneratorDialog(
                content: msg,
                codeText: code,
                type: type,
                onOkButtonPressed: () async {
                  // check user api implemented
                  await SyncService.checkUser();
                }),
          );
        }
      }
    } catch (e) {}
  }

  showErrorDialog(
      {Icon icon,
      String title,
      String content,
      String buttonText,
      BuildContext context,
      VoidCallback onPressed}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonErrorDialog(
                icon: icon,
                title: title,
                content: content,
                buttonText: buttonText,
                onPressed: onPressed,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
}
