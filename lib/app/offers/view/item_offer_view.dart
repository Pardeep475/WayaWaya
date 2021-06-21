import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:share/share.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/offers/model/voucher.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class ItemOfferView extends StatelessWidget {
  final Campaign campaign;
  final List<Campaign> listOfCampaign;

  ItemOfferView({this.campaign, this.listOfCampaign});

  String _getTitle(BuildContext context) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    return Utils.getTranslatedCode(context, campaign.campaignElement.name);
  }

  String _getImage(BuildContext context) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    return Utils.getTranslatedCodeFromImageId(campaign.campaignElement.imageId);
  }

  String _startDate(BuildContext context) {
    if (campaign == null) return '';
    if (campaign.startDate == null) return '';
    return Utils.dateConvert(campaign.startDate, "dd-MMM");
  }

  String _endDate(BuildContext context) {
    if (campaign == null) return '';
    if (campaign.endDate == null) return '';
    return Utils.dateConvert(campaign.endDate, "dd-MMM");
  }

  String _startText() {
    if (campaign == null) return '';
    if (campaign.couponValue == null) return '';
    if (campaign.couponValue.contains(" ")) {
      return campaign.couponValue
          .substring(0, campaign.couponValue.indexOf(" "));
    } else {
      return campaign.couponValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppString.OFFER_DETAILS_SCREEN_ROUTE,
            arguments: this.listOfCampaign);
      },
      child: Container(
        margin: EdgeInsets.all(Dimens.five),
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(blurRadius: 2, color: Colors.grey, spreadRadius: 2)
          ],
        ),
        child: Wrap(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.23,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height * 0.23,
                      width: MediaQuery.of(context).size.width,
                      imageUrl: _getImage(context),
                      fit: BoxFit.fill,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
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
                    ),
                  ),
                  Positioned(
                    left: Dimens.ten,
                    top: Dimens.five,
                    child: ShapeOfView(
                      elevation: Dimens.three,
                      shape: StarShape(noOfPoints: 5),
                      child: Container(
                        color: AppColor.yellow,
                        padding: EdgeInsets.all(Dimens.twenty),
                        child: Text(
                          _startText(),
                          style: TextStyle(color: AppColor.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(Dimens.five, Dimens.eight, Dimens.five, 0),
                    color: AppColor.white,
                    child: Text(
                      _getTitle(context),
                      style: GoogleFonts.ubuntuCondensed().copyWith(
                        color: AppColor.black.withOpacity(0.7),
                        fontSize: Dimens.nineteen,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.four,
                  ),
                  Divider(height: Dimens.one,color: Colors.grey,),
                  Container(
                    color: Color(0xFF60F2F2F2),
                    padding: EdgeInsets.only(right: Dimens.five),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.eight, vertical: Dimens.five),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: Dimens.five,
                                  ),
                                  Text(_startDate(context)),
                                ],
                              ),
                              SizedBox(
                                height: Dimens.eight,
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
                                  Text(_endDate(context)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),

                        FutureBuilder(
                          future: _redeemLayout(),
                          builder: (context,snapshot){
                            if(snapshot.hasData && snapshot.data){
                              return Row(
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.gift,
                                            color: AppColor.black,
                                          ),
                                          SizedBox(
                                            height: Dimens.ten,
                                          ),
                                          Text(
                                            AppString.redeem.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: Dimens.ten,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:Dimens.eleven,
                                  ),
                                ],
                              );
                            }
                            return SizedBox();
                          },
                        ),

                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // _locateOnMap(context);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  FontAwesomeIcons.mapMarkerAlt,
                                  color: AppColor.black,
                                ),
                                SizedBox(
                                  height: Dimens.ten,
                                ),
                                Text(
                                  AppString.locate.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: Dimens.ten,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimens.eleven,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // _shareFiles(context);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.share,
                                  color: AppColor.black,
                                ),
                                SizedBox(
                                  height: Dimens.ten,
                                ),
                                Text(
                                  AppString.share.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: Dimens.ten,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///BUTTONS
                      ],
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

  Future<bool> _redeemLayout() async {
    try {
      bool isLogin = await SessionManager.isLogin();

      if (isLogin && int.parse(_startText()) > 0) return true;
    } catch (e) {
      return false;
    }
    return false;
  }

  _locateOnMap(BuildContext context) {
    if (campaign == null) return;
    if (campaign.floorplanId == null && campaign.floorplanId.trim().isEmpty)
      return;
    debugPrint('Here_is_floor_plan_id:-   ${campaign.floorplanId}');

    Navigator.pushNamedAndRemoveUntil(
        context, AppString.TWO_D_MAP_SCREEN_ROUTE, (route) => false);
  }

  _shareFiles(BuildContext buildContext) {
    try {
      Voucher _voucher = Voucher.fromJson(jsonDecode(campaign.voucher));
      // NumberFormat nf = DecimalFormat.getInstance();
      // nf.setMaximumFractionDigits(0);
      NumberFormat nf = NumberFormat.decimalPattern();
      String subject = _getTitle(buildContext);
      String discount = nf.format(_voucher.discount);
      if (discount.isNotEmpty) {
        subject = subject + "Discount (" + discount + "%" + ")";
      }
      debugPrint('share_files:-   ${nf.format(_voucher.discount)}');
      String description = '';
      campaign.campaignElement.description.forEach((element) {
        if (element.language == Language.EN_US) {
          description = element.text;
        }
      });

      Share.shareFiles([_getImage(buildContext)],
          subject: subject, text: description);
      // final String discount = nf.format(campaign.voucher.);
    } catch (e) {
      debugPrint('$e');
    }
  }
}
