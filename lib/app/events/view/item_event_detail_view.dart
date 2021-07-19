import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/common/model/language_store.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/utils.dart';

class ItemEventDetailView extends StatelessWidget {
  final Campaign campaign;

  ItemEventDetailView({this.campaign});

  String _getTitle(BuildContext context) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    try{
      CampaignElement camElement = campaignElementFromJson(campaign.campaignElement);
      List<LanguageStore> name = List<LanguageStore>.from(camElement.name.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, name);
    }catch(e){
      CampaignElement camElement = campaignElementFromJson(jsonDecode(campaign.campaignElement));
      List<LanguageStore> name = List<LanguageStore>.from(camElement.name.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, name);
    }
  }

  String _getImage(BuildContext context) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    try{
      CampaignElement camElement = CampaignElement.fromJson(jsonDecode(campaign.campaignElement));
      List<LanguageStore> imageId = List<LanguageStore>.from(camElement.imageId.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, imageId);
    }catch(e){
      CampaignElement camElement = CampaignElement.fromJson(jsonDecode(jsonDecode(campaign.campaignElement)));
      List<LanguageStore> imageId = List<LanguageStore>.from(camElement.imageId.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, imageId);
    }
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      margin: EdgeInsets.all(Dimens.five),
      child: Wrap(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.23,
            decoration: BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                BoxShadow(blurRadius: 2, color: Colors.grey, spreadRadius: 2)
              ],
            ),
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
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.five, vertical: Dimens.eight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getTitle(context),
                  style: GoogleFonts.ubuntuCondensed().copyWith(
                    color: AppColor.black.withOpacity(0.7),
                    fontSize: Dimens.nineteen,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
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
                        Text(_startDate(context)),
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
                        Text(_endDate(context)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
