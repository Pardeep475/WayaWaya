import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:share/share.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/offers/model/voucher.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/utils.dart';

class ItemEventView extends StatelessWidget {
  final Campaign campaign;

  final List<Campaign> listOfCampaign;

  ItemEventView({this.campaign, this.listOfCampaign});

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

  String _getFlag(BuildContext context) {
    return Utils.eventStatus(
        startDate: Utils.dateConvert(campaign.startDate, AppString.DATE_FORMAT),
        endDate: Utils.dateConvert(campaign.endDate, AppString.DATE_FORMAT));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppString.EVENT_DETAILS_ROUTE,
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
            Container(
              foregroundDecoration: RotatedCornerDecoration(
                color: _getFlag(context) == 'starts'
                    ? Color(0xFF66BB6A)
                    : _getFlag(context) == 'started'
                        ? Color(0xFFFFEE58)
                        : Color(0xFFEF5350),
                // 66BB6A
                badgeShadow:
                    const BadgeShadow(color: Colors.black87, elevation: 1.5),
                labelInsets: LabelInsets(baselineShift: 2),
                geometry: const BadgeGeometry(
                  width: 70,
                  alignment: BadgeAlignment.topLeft,
                  height: 70,
                ),
                textSpan: TextSpan(
                  text: _getFlag(context),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
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
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        Dimens.five, Dimens.eight, Dimens.five, 0),
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
                        SizedBox(width: Dimens.eleven),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.event,
                                  color: AppColor.black,
                                ),
                                SizedBox(
                                  height: Dimens.ten,
                                ),
                                Text(
                                  AppString.events.toUpperCase(),
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
