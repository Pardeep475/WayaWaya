import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class ItemRewards extends StatelessWidget {
  final int size;
  final int index;
  final Campaign campaign;

  ItemRewards({this.size, this.index, this.campaign});

  @override
  Widget build(BuildContext context) {
    getErrorText(campaign);
    return InkWell(
      // onTap: () => App.pushTo(context: context, screen: RewardsDetails()),
      child: Container(
        height: Dimens.twoHundredFifty,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: Dimens.six),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xffF1BD80),
              width: Dimens.three,
            ),
            left: BorderSide(
              color: Color(0xffF1BD80),
              width: Dimens.three,
            ),
            right: BorderSide(
              color: Color(0xffF1BD80),
              width: Dimens.three,
            ),
            bottom: size - 1 != index
                ? BorderSide.none
                : BorderSide(
                    color: Color(0xffF1BD80),
                    width: Dimens.three,
                  ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: FutureBuilder(
                      future: getImageUrl(context, campaign),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Image.asset(
                            AppImages.rewards,
                            fit: BoxFit.cover,
                          );
                        }
                        return CachedNetworkImage(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          imageUrl: snapshot.data,
                          fit: BoxFit.none,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          placeholder: (context, url) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      AppColor.primaryDark),
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              AppImages.icon_placeholder,
                              fit: BoxFit.cover,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: FutureBuilder(
                      future: getErrorText(campaign),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return SizedBox();
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            color: Color(0xff902a2c2d),
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimens.twenty,
                                vertical: Dimens.twenty),
                            child: Text(
                              AppString.offer_validation_error,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffddffffff),
                                fontSize: Dimens.eighteen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimens.fortyFive,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Dimens.three,
                  ),
                  FutureBuilder(
                    future: getBumpImage(campaign),
                    builder: (context,snapshot){
                      return Image.asset(
                        AppImages.red_fist_bump,
                        height: Dimens.forty,
                        width: Dimens.forty,
                      );
                    },
                  ),
                  SizedBox(
                    width: Dimens.fifteen,
                  ),
                  Text(
                    getLoyaltyPoints(campaign),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimens.eighteen,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getImageUrl(BuildContext context, Campaign campaign) async {
    try {
      return Utils.parseMediaUrl(
          Utils.getTranslatedCodeFromImageId(campaign.campaignElement.imageId));
    } catch (e) {
      return null;
    }
  }

  Future<String> getErrorText(Campaign campaign) async {
    String userData = await SessionManager.getUserData();
    UserDataResponse _response = userDataResponseFromJson(userData);
    dynamic loyaltyStatus = jsonDecode(_response.loyaltyStatus);
    debugPrint('loyality status:-   $loyaltyStatus');
    int loyaltyPoints = loyaltyStatus['points'];
    debugPrint('loyality status:-   $loyaltyPoints');
    if (campaign.loyaltyOfferThreshold > loyaltyPoints) {
      return AppString.offer_validation_error;
    }
    return null;
  }

  String getLoyaltyPoints(Campaign campaign) {
    try {
      debugPrint('campaign_voucher:-   ${campaign.voucher}');
      dynamic voucherJson = jsonDecode(campaign.voucher);
      int voucher = voucherJson['discount'];
      if (voucher != null && voucher > 0) {
        return "$voucher Points";
      } else {
        return "0 Points";
      }
    } catch (e) {
      return "0 Points";
    }
  }

  Future<String> getBumpImage(Campaign campaign) async {
    try{
      debugPrint('campaign_voucher:-   ${campaign.voucher}');
      dynamic voucherJson = jsonDecode(campaign.voucher);
      int voucher = voucherJson['discount'];
      if (voucher == 0) {
        return AppImages.red_fist_bump;
      } else {
        String userData = await SessionManager.getUserData();
        UserDataResponse _response = userDataResponseFromJson(userData);
        dynamic loyaltyStatus = jsonDecode(_response.loyaltyStatus);
        int loyaltyPoints = loyaltyStatus['points'];
        if (voucher <= loyaltyPoints) {
          return AppImages.green_fist_bump;
        } else {
          return AppImages.red_fist_bump;
        }
      }
    }catch(e){
      return AppImages.red_fist_bump;
    }
  }
}
