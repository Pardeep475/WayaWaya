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
import 'package:wayawaya/app/common/webview/model/custom_web_view_model.dart';
import 'package:wayawaya/app/common/zoom_out_page_transformation.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/offers/model/detail_model.dart';
import 'package:wayawaya/app/offers/model/voucher.dart';
import 'package:wayawaya/app/rewards/redeem.dart';
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
  int rewardPoints = 10;
  Widget _dialog;

  redeemDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(''),
        content: Container(
          child: Text(
            'Go to the cashier and redeem the Voucher in front of them”',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              // Navigator.of(context).pop();
              App.pushTo(context: context, screen: RedeemVoucher());
            },
          ),
        ],
      ),
    );
  }

  checkPoints() {
    if (rewardPoints < 5) {
      _dialog = Container(
        height: 200,
        width: 200,
        margin: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(
              flex: 2,
            ),
            Text(
              'You need 5 points.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      printY('OK');
                    },
                  ),
                  TextButton(
                    child: Text(
                      'INFO',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      );
      return _dialog;
    } else {
      _dialog = Container(
        height: 200,
        width: 200,
        margin: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(
              flex: 2,
            ),
            Text(
              'Go to the cashier and redeem the Voucher in front of them.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  printY('OK');
                  App.pushTo(context: context, screen: RedeemVoucher());
                },
              ),
            ),
          ],
        ),
      );
      return _dialog;
    }
  }

  @override
  void initState() {
    super.initState();
    checkPoints();
  }

  @override
  Widget build(BuildContext context) {
    // checkPoints();

    // _campaign = ModalRoute.of(context).settings.arguments;
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
                                        child: FutureBuilder(
                                          future: getImageUrl(
                                              context, _listOfCampaign[index]),
                                          builder: (context, snapshot) {
                                            if (snapshot.data == null) {
                                              return Image.asset(
                                                AppImages.rewards,
                                                fit: BoxFit.cover,
                                              );
                                            }
                                            return CachedNetworkImage(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              imageUrl: snapshot.data,
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
                                                              AppColor
                                                                  .primaryDark),
                                                    ),
                                                  ),
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, error) {
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
                                      onTap: () => checkPoints(),
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
      if (campaign.campaignElement != null &&
          campaign.campaignElement.description != null) {
        campaign.campaignElement.description.forEach((element) {
          if (element.language == Language.EN_US) {
            description = element.text;
          }
        });
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
    return Utils.getTranslatedCodeFromImageId(campaign.campaignElement.imageId);
  }

  _getTitle(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    return Utils.getTranslatedCode(context, campaign.campaignElement.name);
  }

  _getDescription(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    if (campaign.campaignElement.description == null) return '';
    return Utils.getTranslatedCode(
        context, campaign.campaignElement.description);
  }
}
