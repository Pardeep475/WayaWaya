import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/dialogs/common_login_dialog.dart';
import 'package:wayawaya/app/common/dialogs/common_not_at_venue_dialog.dart';
import 'package:wayawaya/app/common/full_screen_loyalty_info_dialog.dart';
import 'package:wayawaya/app/common/full_screen_not_an_vanue_dialog.dart';
import 'package:wayawaya/app/common/webview/model/custom_web_view_model.dart';
import 'package:wayawaya/app/common/zoom_out_page_transformation.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/offers/model/detail_model.dart';
import 'package:wayawaya/app/offers/model/voucher.dart';
import 'package:wayawaya/app/rewards/bloc/rewards_detail_bloc.dart';
import 'package:wayawaya/app/rewards/redeem.dart';
import 'package:wayawaya/common/model/language_store.dart';
import 'package:wayawaya/config.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';
import '../../constants.dart';

class RewardsDetails extends StatefulWidget {
  const RewardsDetails({Key key}) : super(key: key);

  @override
  _RewardsDetailsState createState() => _RewardsDetailsState();
}

class _RewardsDetailsState extends State<RewardsDetails> {
  final RewardsDetailBloc _rewardsDetailBloc = RewardsDetailBloc();
  int rewardPoints = 10;
  Widget _dialog;

  @override
  void initState() {
    super.initState();
    // checkPoints();
  }

  @override
  Widget build(BuildContext context) {
    DetailModel _detailModel = ModalRoute.of(context).settings.arguments;
    List<Campaign> _listOfCampaign = _detailModel.listOfCampaign;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColor.white,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xff3A4D51),
              automaticallyImplyLeading: false,
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              size: Dimens.sixteen,
                            ),
                            Text(
                              'Offer',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Dimens.eighteen),
                            ),
                          ],
                        ),
                        onTap: () => Navigator.pop(context)),
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      'Reward',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.sixteen,
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: TransformerPageView(
                  loop: false,
                  transformer: new ZoomOutPageTransformer(),
                  index: _detailModel.position,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: AppColor.white,
                      child: Column(
                        children: [
                          Container(
                            height: Dimens.twoHundredFifty,
                            width: MediaQuery.of(context).size.width,
                            margin:
                                EdgeInsets.symmetric(horizontal: Dimens.three),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffF1BD80),
                                width: Dimens.three,
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: CachedNetworkImage(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          imageUrl: getImageUrl(
                                              context, _listOfCampaign[index]),
                                          fit: BoxFit.none,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
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
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      new AlwaysStoppedAnimation<
                                                              Color>(
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
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: FutureBuilder(
                                          future: getErrorText(
                                              _listOfCampaign[index]),
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
                                                  AppString
                                                      .offer_validation_error,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: Dimens.three,
                                      ),
                                      FutureBuilder(
                                        future: getBumpImage(
                                            _listOfCampaign[index]),
                                        builder: (context, snapshot) {
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
                                        getLoyaltyPoints(
                                            _listOfCampaign[index]),
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
                          SizedBox(
                            height: Dimens.four,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: Dimens.three,
                                  ),
                                  Text(
                                    _startDate(context, _listOfCampaign[index]),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: Dimens.twenty,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: Dimens.two,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.red,
                                            width: Dimens.one),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[400],
                                            blurRadius: 5.0,
                                          ),
                                        ]),
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.red,
                                      size: Dimens.forteen,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimens.six,
                                  ),
                                  Text(
                                    _endDate(context, _listOfCampaign[index]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            _getDescription(context, _listOfCampaign[index]),
                            style: GoogleFonts.ubuntuCondensed().copyWith(
                              color: AppColor.black.withOpacity(0.7),
                              fontSize: Dimens.nineteen,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.8,
                            ),
                          ),
                          // _dialog ?? Container(),
                          Expanded(child: SizedBox()),
                          Card(
                            elevation: Dimens.ten,
                            margin: const EdgeInsets.all(0),
                            child: Container(
                              height: Dimens.eighty,
                              padding: EdgeInsets.only(
                                bottom: Dimens.twenty,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        redeemClickEvent(
                                            campaign: _listOfCampaign[index]);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.gift,
                                            color: rewardPoints < 5
                                                ? Colors.grey[700]
                                                : Colors.green[900],
                                          ),
                                          SizedBox(
                                            height: Dimens.ten,
                                          ),
                                          Text(
                                            'REDEEM',
                                            style: TextStyle(
                                              color: rewardPoints < 5
                                                  ? Colors.grey[600]
                                                  : Colors.green[900],
                                              fontSize: Dimens.twelve,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _locateOnMap(
                                            context, _listOfCampaign[index]);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.mapMarkerAlt,
                                            color: Colors.grey[700],
                                          ),
                                          SizedBox(
                                            height: Dimens.ten,
                                          ),
                                          Text(
                                            'LOCATE',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: Dimens.twelve,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _shareFiles(
                                            context, _listOfCampaign[index]);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.share,
                                            color: Colors.grey[700],
                                          ),
                                          SizedBox(
                                            height: Dimens.ten,
                                          ),
                                          Text(
                                            'SHARE',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: Dimens.twelve,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: _listOfCampaign.length),
            ),
          ],
        ),
      ),
    );
  }

// redeem functionality start
  redeemClickEvent({Campaign campaign}) async {
    bool isUserInMall = await SessionManager.getUserInMall();
    if (isUserInMall) {
      try {
        int userLoyaltyPoints = await getLoyaltyPointsForRedeem();
        int finalCouponPoints = getFinalUserPoints(campaign: campaign);
        if (finalCouponPoints <= userLoyaltyPoints) {
          String redeemMsg =
              "Proceeding further will deduct $finalCouponPoints points from your balance of $userLoyaltyPoints points. \nMake sure you are at the cashier.";
          String shopName = getShopName(campaign: campaign);
          // redeem offer
          _redeemOfferDialog(
            context: context,
            title: AppString.redeem_offer,
            content: redeemMsg,
            buttonText: AppString.redeem.toUpperCase(),
            onPressed: () {
              Navigator.pop(context);
              String shopId = campaign.rid;
              _rewardsDetailBloc.redeemLoyaltyPoints(context, finalCouponPoints,
                  shopId, campaign.id, shopName, campaign.voucher);
            },
          );
        } else {
          if (AppString.POINT_SHOW) {
            _rewardsDetailBloc.showErrorDialog(
              icon: Icon(
                FontAwesomeIcons.exclamationTriangle,
                color: AppColor.orange_500,
              ),
              title: AppString.info.toUpperCase(),
              content: AppString.you_need_five_points,
              buttonText: AppString.ok.toUpperCase(),
              context: context,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, FullScreenLoyaltyInfoDialog());
              },
            );
          } else {
            _rewardsDetailBloc.showErrorDialog(
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
        }
      } catch (e) {}
    } else {
      _notAnVenueDialog(
        onPressed: () => Navigator.pop(context),
      );
    }
    // checkPoints();
  }

  int getFinalUserPoints({Campaign campaign}) {
    try {
      if (campaign.voucher == null) return 0;
      dynamic voucherJson = jsonDecode(campaign.voucher);
      if (voucherJson['value'] is String) {
        return int.parse(voucherJson['value']);
      } else {
        return voucherJson['value'];
      }
    } catch (e) {
      dynamic voucherJson = jsonDecode(jsonDecode(campaign.voucher));
      if (voucherJson['value'] is String) {
        return int.parse(voucherJson['value']);
      } else {
        return voucherJson['value'];
      }
    }
  }

  Future<int> getLoyaltyPointsForRedeem() async {
    String userData = await SessionManager.getUserData();
    UserDataResponse _response = userDataResponseFromJson(userData);
    if (_response == null) return 0;
    if (_response.loyaltyStatus == null) return 0;
    dynamic loyaltyStatus = jsonDecode(_response.loyaltyStatus);
    if (loyaltyStatus['points'] == null) return 0;
    return loyaltyStatus['points'];
  }

  String getShopName({Campaign campaign}) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    try {
      CampaignElement camElement =
          campaignElementFromJson(campaign.campaignElement);
      List<LanguageStore> name = List<LanguageStore>.from(
          camElement.name.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, name);
    } catch (e) {
      CampaignElement camElement =
          campaignElementFromJson(jsonDecode(campaign.campaignElement));
      List<LanguageStore> name = List<LanguageStore>.from(
          camElement.name.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, name);
    }
  }


  _redeemOfferDialog(
      {BuildContext context,
      Icon icon,
      String title,
      String content,
      String buttonText,
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
              child: CommonLoginDialog(
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

  _notAnVenueDialog({VoidCallback onPressed}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonNoAtVenueDialog(
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

  // redeem functionality ends
  String getImageUrl(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    try {
      CampaignElement camElement =
          CampaignElement.fromJson(jsonDecode(campaign.campaignElement));
      List<LanguageStore> imageId = List<LanguageStore>.from(
          camElement.imageId.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, imageId);
    } catch (e) {
      CampaignElement camElement = CampaignElement.fromJson(
          jsonDecode(jsonDecode(campaign.campaignElement)));
      List<LanguageStore> imageId = List<LanguageStore>.from(
          camElement.imageId.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, imageId);
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
    try {
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
    } catch (e) {
      return AppImages.red_fist_bump;
    }
  }

  String _startDate(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.startDate == null) return '';
    return Utils.dateConvert(campaign.startDate, "dd-MMM");
  }

  String _endDate(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.endDate == null) return '';
    return Utils.dateConvert(campaign.endDate, "dd-MMM");
  }

  _shareFiles(BuildContext buildContext, Campaign campaign) {
    try {
      String subject = _getTitle(buildContext, campaign);
      if (campaign.voucher != null) {
        Voucher _voucher = Voucher.fromJson(jsonDecode(campaign.voucher));
        NumberFormat nf = NumberFormat.decimalPattern();
        String discount = nf.format(_voucher.discount);
        if (discount.isNotEmpty) {
          subject = subject + "Discount (" + discount + "%" + ")";
        }
        debugPrint('share_files:-   ${nf.format(_voucher.discount)}');
      }

      String description = '';
      if (campaign.campaignElement != null) {
        try {
          CampaignElement camElement =
              campaignElementFromJson(campaign.campaignElement);
          List<LanguageStore> name = List<LanguageStore>.from(
              camElement.description.map((x) => LanguageStore.fromJson(x)));
          description = Utils.getTranslatedCode(buildContext, name);
        } catch (e) {
          CampaignElement camElement =
              campaignElementFromJson(jsonDecode(campaign.campaignElement));
          List<LanguageStore> name = List<LanguageStore>.from(
              camElement.description.map((x) => LanguageStore.fromJson(x)));
          description = Utils.getTranslatedCode(buildContext, name);
        }
      }

      Share.share(description + "\n" + _getImage(buildContext, campaign),
          subject: subject);
    } catch (e) {
      debugPrint('$e');
    }
  }

  _locateOnMap(BuildContext context, Campaign campaign) async {
    try {
      if (campaign == null) return;
      if (campaign.floorplanId == null && campaign.floorplanId.trim().isEmpty)
        return;
      debugPrint('Here_is_floor_plan_id:-   ${campaign.floorplanId}');
      String defaultMap = await SessionManager.getDefaultMall();
      String mapUrl =
          '${AppString.MAP_URL_LIVE}?retail_unit=${campaign.floorplanId}&map_data_url=$defaultMap';
      Navigator.pushNamed(
        context,
        AppString.CUSTOM_WEB_VIEW_SCREEN_ROUTE,
        arguments: CustomWebViewModel(
            title: _getTitle(context, campaign),
            webViewUrl: mapUrl.replaceAll(" ", "%20")),
      );
    } catch (e) {
      debugPrint('offers_details_error:-   $e');
    }
  }

  String _getImage(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    try {
      CampaignElement camElement =
          CampaignElement.fromJson(jsonDecode(campaign.campaignElement));
      List<LanguageStore> imageId = List<LanguageStore>.from(
          camElement.imageId.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, imageId);
    } catch (e) {
      CampaignElement camElement = CampaignElement.fromJson(
          jsonDecode(jsonDecode(campaign.campaignElement)));
      List<LanguageStore> imageId = List<LanguageStore>.from(
          camElement.imageId.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, imageId);
    }
  }

  _getTitle(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    // return Utils.getTranslatedCode(context, campaign.campaignElement.name);
    try {
      CampaignElement camElement =
          campaignElementFromJson(campaign.campaignElement);
      List<LanguageStore> name = List<LanguageStore>.from(
          camElement.name.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, name);
    } catch (e) {
      CampaignElement camElement =
          campaignElementFromJson(jsonDecode(campaign.campaignElement));
      List<LanguageStore> name = List<LanguageStore>.from(
          camElement.name.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, name);
    }
  }

  _getDescription(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    try {
      CampaignElement camElement =
          campaignElementFromJson(campaign.campaignElement);
      List<LanguageStore> name = List<LanguageStore>.from(
          camElement.description.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, name);
    } catch (e) {
      CampaignElement camElement =
          campaignElementFromJson(jsonDecode(campaign.campaignElement));
      List<LanguageStore> name = List<LanguageStore>.from(
          camElement.description.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, name);
    }
  }
}
