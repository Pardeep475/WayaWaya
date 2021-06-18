import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:wayawaya/app/common/zoom_out_page_transformation.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/offers/view/item_offer_view_detail.dart';
import 'package:wayawaya/screens/map/mall_map.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import 'package:wayawaya/utils/utils.dart';

import '../../config.dart';
import '../../constants.dart';

class OfferDetails extends StatefulWidget {


  const OfferDetails({Key key});

  @override
  State<StatefulWidget> createState() => _OffersDetailsState();
}

class _OffersDetailsState extends State<OfferDetails> {
  bool _hasRewards = true;

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


  String _getTitle(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    return Utils.getTranslatedCode(context, campaign.campaignElement.name);
  }

  String _getImage(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    return Utils.getTranslatedCodeFromImageId(campaign.campaignElement.imageId);
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


  @override
  Widget build(BuildContext context) {
    List<Campaign> _listOfCampaign = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            MenuNew(
              title: 'widget.offerName.toUpperCase()',
              children: [
                SliverFillRemaining(
                  child: TransformerPageView(
                      loop: false,
                      transformer: new ZoomOutPageTransformer(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ItemOfferViewDetail(campaign: _listOfCampaign[index]),
                            Expanded(child: SizedBox()),
                            Container(
                              height: 70,
                              width: App.width(context),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  _hasRewards
                                      ? Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () => errorDialog(),
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.gift,
                                                    color: black,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Redeem'.toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => MapScreen()),
                                      ),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.mapMarkerAlt,
                                              color: black,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Locate'.toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.share,
                                              color: black,
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              'Share'.toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
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
                        );
                      },
                      itemCount: _listOfCampaign.length),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
