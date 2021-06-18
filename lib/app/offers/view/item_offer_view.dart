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

  _startText() {
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
        margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(blurRadius: 2, color: Colors.grey, spreadRadius: 2)
          ],
        ),
        child: Wrap(
          children: [
            SizedBox(
              height: 220,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      height: 220,
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
                    left: 10,
                    top: 10,
                    child: ShapeOfView(
                      elevation: 3,
                      shape: StarShape(noOfPoints: 5),
                      child: Container(
                        color: AppColor.yellow,
                        padding: const EdgeInsets.all(20),
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
              padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTitle(context),
                    style: GoogleFonts.ubuntuCondensed().copyWith(
                      color: AppColor.black.withOpacity(0.7),
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    color: Color(0xFF60F2F2F2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
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
                                    width: 3,
                                  ),
                                  Text(_startDate(context)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(_endDate(context)),
                                ],
                              ),
                            ],
                          ),
                        ),

                        ///BUTTONS
                        Expanded(
                          child: Container(
                            width: 100,
                            margin: EdgeInsets.only(right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                campaign != null
                                    ? InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 11),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.gift,
                                                color: AppColor.black,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                AppString.redeem.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                InkWell(
                                  onTap: () {
                                    _locateOnMap(context);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.mapMarkerAlt,
                                        color: AppColor.black,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        AppString.locate.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 11,
                                ),
                                InkWell(
                                  onTap: () {
                                    _shareFiles(context);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 1,
                                      ),
                                      Icon(
                                        Icons.share,
                                        color: AppColor.black,
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Text(
                                        AppString.share.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
