import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/utils.dart';

class ItemEventDetailView extends StatelessWidget {
  final Campaign campaign;

  ItemEventDetailView({this.campaign});

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
    return Container(
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
    );
  }
}
