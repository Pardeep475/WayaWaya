import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/common/zoom_out_page_transformation.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/offers/bloc/offer_detail_bloc.dart';
import 'package:wayawaya/app/offers/view/item_offer_view_detail.dart';
import 'package:wayawaya/screens/map/mall_map.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

import '../../config.dart';
import '../../constants.dart';
import 'model/voucher.dart';

class OfferDetails extends StatefulWidget {
  const OfferDetails({Key key});

  @override
  State<StatefulWidget> createState() => _OffersDetailsState();
}

class _OffersDetailsState extends State<OfferDetails> {
  bool _hasRewards = true;

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

  // Widget detailCard(Campaign campaign) {
  //   return Container(
  //     margin: EdgeInsets.only(top: 5),
  //     color: white,
  //     child: Wrap(
  //       children: [
  //         Container(
  //           height: 220,
  //           width: double.infinity,
  //           child: Image.network(
  //             'https://www.cbia.com/wp-content/uploads/2020/05/Social-Distancing.png',
  //             fit: BoxFit.fill,
  //           ),
  //         ),
  //         Container(
  //           padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 widget.offerName,
  //                 style: GoogleFonts.ubuntuCondensed().copyWith(
  //                   color: black.withOpacity(0.7),
  //                   fontSize: 19,
  //                   fontWeight: FontWeight.w500,
  //                   letterSpacing: 0.8,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 8,
  //               ),
  //               Container(
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           Icons.arrow_forward,
  //                           color: Colors.green,
  //                         ),
  //                         SizedBox(
  //                           width: 3,
  //                         ),
  //                         Text('27-Nov'),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       width: 30,
  //                     ),
  //                     Row(
  //                       children: [
  //                         SizedBox(
  //                           width: 2,
  //                         ),
  //                         Icon(
  //                           Icons.circle,
  //                           color: Colors.red,
  //                           size: 18,
  //                         ),
  //                         SizedBox(
  //                           width: 6,
  //                         ),
  //                         Text('04-Oct'),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               _hasRewards
  //                   ? Container(
  //                       height: 35,
  //                       padding: EdgeInsets.only(top: 8),
  //                       child: Text(
  //                         'Win your share of R5 Million.',
  //                         style: TextStyle(
  //                           color: Colors.grey[500],
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                     )
  //                   : Container(
  //                       height: 0,
  //                     ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  errorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Container(
          child: Text(
            'You need to visit the mall to earn points.',
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
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  _getTitle(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    title = Utils.getTranslatedCode(context, campaign.campaignElement.name);
    if (title != lastTitle) {
      lastTitle = title;
      _offerDetailBloc.mainMenuPermissionSink
          .add(_offerDetailBloc.mainMenuList);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Campaign> _listOfCampaign = ModalRoute.of(context).settings.arguments;
    return SafeArea(
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
                    mainMenuPermissions: snapshot.data,
                    children: [
                      SliverFillRemaining(
                        child: TransformerPageView(
                            loop: false,
                            transformer: new ZoomOutPageTransformer(),
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
                                      child: Row(
                                        children: [
                                          FutureBuilder(
                                            future: _redeemLayout(
                                                _listOfCampaign[index]),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData &&
                                                  snapshot.data) {
                                                return Expanded(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                Dimens.fifteen,
                                                          ),
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .gift,
                                                            color:
                                                                AppColor.black,
                                                          ),
                                                          SizedBox(
                                                            height: Dimens.ten,
                                                          ),
                                                          Text(
                                                            AppString.redeem
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  Dimens.ten,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: Dimens.ten,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return SizedBox();
                                            },
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
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
                                                      CrossAxisAlignment.center,
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

      // Share.shareFiles([_getImage(buildContext)],
      //     subject: subject, text: description);
      // final String discount = nf.format(campaign.voucher.);
    } catch (e) {
      debugPrint('$e');
    }
  }

  String _getImage(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    return Utils.getTranslatedCodeFromImageId(campaign.campaignElement.imageId);
  }
}
