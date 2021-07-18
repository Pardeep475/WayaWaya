import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/common/webview/model/custom_web_view_model.dart';
import 'package:wayawaya/app/common/zoom_out_page_transformation.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/offers/bloc/offer_detail_bloc.dart';
import 'package:wayawaya/app/offers/model/detail_model.dart';
import 'package:wayawaya/app/offers/view/item_offer_view_detail.dart';
import 'package:wayawaya/common/model/language_store.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

import '../../constants.dart';
import 'model/voucher.dart';

class OfferDetails extends StatefulWidget {
  const OfferDetails({Key key});

  @override
  State<StatefulWidget> createState() => _OffersDetailsState();
}

class _OffersDetailsState extends State<OfferDetails> {
  OfferDetailBloc _offerDetailBloc;
  String title = "";
  String lastTitle = "";

  @override
  void initState() {
    super.initState();
    _offerDetailBloc = OfferDetailBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _offerDetailBloc.fetchMenuButtons();
    });
  }

  _getTitle(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    CampaignElement camElement =
        CampaignElement.fromJson(jsonDecode(campaign.campaignElement));
    List<LanguageStore> name = List<LanguageStore>.from(
        camElement.name.map((x) => LanguageStore.fromJson(x)));
    title = Utils.getTranslatedCode(context, name);
    if (title != lastTitle) {
      lastTitle = title;
      _offerDetailBloc.mainMenuPermissionSink
          .add(_offerDetailBloc.mainMenuList);
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    DetailModel _detailModel = ModalRoute.of(context).settings.arguments;
    List<Campaign> _listOfCampaign = _detailModel.listOfCampaign;

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Stack(
          children: [
            StreamBuilder<List<MainMenuPermission>>(
                initialData: [],
                stream: _offerDetailBloc.mainMenuPermissionStream,
                builder: (context, snapshot) {
                  return AnimateAppBar(
                    title: title,
                    isSliver: true,
                    physics: NeverScrollableScrollPhysics(),
                    mainMenuPermissions: snapshot.data,
                    children: [
                      SliverFillRemaining(
                        child: TransformerPageView(
                            loop: false,
                            transformer: new ZoomOutPageTransformer(),
                            index: _detailModel.position,
                            itemBuilder: (BuildContext context, int index) {
                              _getTitle(context, _listOfCampaign[index]);
                              return Container(
                                color: AppColor.white,
                                child: Column(
                                  children: [
                                    ItemOfferViewDetail(
                                        campaign: _listOfCampaign[index]),
                                    Expanded(child: SizedBox()),
                                    Card(
                                      elevation: Dimens.ten,
                                      margin: const EdgeInsets.all(0),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: Dimens.twenty),
                                        child: Row(
                                          children: [
                                            // FutureBuilder(
                                            //   future: _redeemLayout(
                                            //       _listOfCampaign[index]),
                                            //   builder: (context, snapshot) {
                                            //     if (snapshot.hasData &&
                                            //         snapshot.data) {
                                            //       return Expanded(
                                            //         child: Material(
                                            //           color: Colors.transparent,
                                            //           child: InkWell(
                                            //             onTap: () {},
                                            //             child: Column(
                                            //               mainAxisAlignment:
                                            //                   MainAxisAlignment
                                            //                       .center,
                                            //               mainAxisSize:
                                            //                   MainAxisSize.max,
                                            //               children: [
                                            //                 SizedBox(
                                            //                   height:
                                            //                       Dimens.fifteen,
                                            //                 ),
                                            //                 Icon(
                                            //                   FontAwesomeIcons
                                            //                       .gift,
                                            //                   color:
                                            //                       AppColor.black,
                                            //                 ),
                                            //                 SizedBox(
                                            //                   height: Dimens.ten,
                                            //                 ),
                                            //                 Text(
                                            //                   AppString.redeem
                                            //                       .toUpperCase(),
                                            //                   style: TextStyle(
                                            //                     fontSize:
                                            //                         Dimens.ten,
                                            //                   ),
                                            //                 ),
                                            //                 SizedBox(
                                            //                   height: Dimens.ten,
                                            //                 ),
                                            //               ],
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       );
                                            //     }
                                            //     return SizedBox();
                                            //   },
                                            // ),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  _locateOnMap(context,
                                                      _listOfCampaign[index]);
                                                },
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      SizedBox(
                                                        height: Dimens.fifteen,
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .mapMarkerAlt,
                                                        color: black,
                                                      ),
                                                      SizedBox(
                                                        height: Dimens.ten,
                                                      ),
                                                      Text(
                                                        'Locate'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize:
                                                              Dimens.forteen,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: Dimens.ten,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  _shareFiles(context,
                                                      _listOfCampaign[index]);
                                                },
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: Dimens.fifteen,
                                                      ),
                                                      Icon(
                                                        Icons.share,
                                                        color: black,
                                                      ),
                                                      SizedBox(
                                                        height: Dimens.ten,
                                                      ),
                                                      Text(
                                                        'Share'.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize:
                                                              Dimens.forteen,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: Dimens.ten,
                                                      ),
                                                    ],
                                                  ),
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
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future<bool> _redeemLayout(Campaign campaign) async {
    try {
      bool isLogin = await SessionManager.isLogin();

      if (isLogin && int.parse(_startText(campaign)) > 0) return true;
    } catch (e) {
      return false;
    }
    return false;
  }

  String _startText(Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.couponValue == null) return '';
    if (campaign.couponValue.contains(" ")) {
      return campaign.couponValue
          .substring(0, campaign.couponValue.indexOf(" "));
    } else {
      return campaign.couponValue;
    }
  }

  String _getImage(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    CampaignElement camElement =
        CampaignElement.fromJson(jsonDecode(campaign.campaignElement));
    List<LanguageStore> imageId = List<LanguageStore>.from(
        camElement.imageId.map((x) => LanguageStore.fromJson(x)));
    return Utils.getTranslatedCode(context, imageId);
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
        CampaignElement camElement =
            CampaignElement.fromJson(jsonDecode(campaign.campaignElement));
        List<LanguageStore> descriptionList = List<LanguageStore>.from(
            camElement.description.map((x) => LanguageStore.fromJson(x)));
        description = Utils.getTranslatedCode(context, descriptionList);

        // campaign.campaignElement.description.forEach((element) {
        //   if (element.language == Language.EN_US) {
        //     description = element.text;
        //   }
        // });
      }

      Share.share(description + "\n" + _getImage(buildContext, campaign),
          subject: subject);

      // Share.shareFiles([_getImage(buildContext)],
      //     subject: subject, text: description);
      // final String discount = nf.format(campaign.voucher.);
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
}
