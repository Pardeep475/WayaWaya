import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:share/share.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/offers/voucher.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/utils.dart';

class ItemEventView extends StatelessWidget {
  final Campaign campaign;

  ItemEventView({this.campaign});

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
      onTap: () {},
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
                                // InkWell(
                                //   onTap: () {},
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       Icon(
                                //         FontAwesomeIcons.mapMarkerAlt,
                                //         color: AppColor.black,
                                //       ),
                                //       SizedBox(
                                //         height: 10,
                                //       ),
                                //       Text(
                                //         AppString.locate.toUpperCase(),
                                //         style: TextStyle(
                                //           fontSize: 10,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: 11,
                                // ),
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
                                SizedBox(
                                  width: 11,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.event,
                                        color: AppColor.black,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        AppString.events.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
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
