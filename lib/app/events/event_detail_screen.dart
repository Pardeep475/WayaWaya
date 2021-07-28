import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/common/zoom_out_page_transformation.dart';
import 'package:wayawaya/app/events/bloc/event_detail_bloc.dart';
import 'package:wayawaya/app/events/view/item_event_detail_view.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/offers/model/detail_model.dart';
import 'package:wayawaya/common/model/language_store.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({Key key});

  @override
  State<StatefulWidget> createState() => _EventDetailScreen();
}

class _EventDetailScreen extends State<EventDetailScreen> {
  EventDetailBloc _eventDetailBloc;
  String title = "";
  String lastTitle = "";

  @override
  void initState() {
    super.initState();
    _eventDetailBloc = EventDetailBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _eventDetailBloc.fetchMenuButtons();
    });
  }

  _getTitle(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    try {
      CampaignElement camElement =
          campaignElementFromJson(campaign.campaignElement);
      List<LanguageStore> name = List<LanguageStore>.from(
          camElement.name.map((x) => LanguageStore.fromJson(x)));
      title = Utils.getTranslatedCode(context, name);
    } catch (e) {
      CampaignElement camElement =
          campaignElementFromJson(jsonDecode(campaign.campaignElement));
      List<LanguageStore> name = List<LanguageStore>.from(
          camElement.name.map((x) => LanguageStore.fromJson(x)));
      title = Utils.getTranslatedCode(context, name);
    }
    if (title != lastTitle) {
      lastTitle = title;
      _eventDetailBloc.mainMenuPermissionSink
          .add(_eventDetailBloc.mainMenuList);
    }
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
                stream: _eventDetailBloc.mainMenuPermissionStream,
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
                            index: _detailModel.position,
                            transformer: new ZoomOutPageTransformer(),
                            itemBuilder: (BuildContext context, int index) {
                              _getTitle(context, _listOfCampaign[index]);
                              return Container(
                                color: AppColor.white,
                                child: Column(
                                  children: [
                                    ItemEventDetailView(
                                        campaign: _listOfCampaign[index]),
                                    Expanded(child: SizedBox()),
                                    Card(
                                      margin: const EdgeInsets.all(0),
                                      elevation: Dimens.ten,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: Dimens.twenty),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: bottomButton(
                                                  icon: Icons.remove_red_eye,
                                                  index: 0,
                                                  contentText: '0'),
                                            ),
                                            Expanded(
                                              child: bottomButton(
                                                  icon: Icons
                                                      .watch_later_outlined,
                                                  index: 1,
                                                  contentText: _getTimingText(
                                                      context,
                                                      _listOfCampaign[index])),
                                            ),
                                            Expanded(
                                              child: bottomButton(
                                                  icon: Icons.share,
                                                  index: 2,
                                                  contentText: '0'),
                                            ),
                                            Expanded(
                                              child: bottomButton(
                                                  onPressed: () {
                                                    _addEventToCalender(context,
                                                        _listOfCampaign[index]);
                                                  },
                                                  icon: Icons.event,
                                                  index: 3,
                                                  contentText: 'Add'),
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

  Widget bottomButton(
      {int index, String contentText, IconData icon, VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          SizedBox(height: Dimens.ten),
          Icon(
            icon,
            size: Dimens.twentyFive,
            color: Colors.grey[700],
          ),
          SizedBox(
            height: Dimens.seven,
          ),
          Text(
            contentText,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: Dimens.ten),
        ],
      ),
    );
  }

  String _getDescription(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    if (campaign.campaignElement.description == null) return '';
    String description = '';
    if (campaign.campaignElement != null) {
      try {
        CampaignElement camElement =
            campaignElementFromJson(campaign.campaignElement);
        List<LanguageStore> name = List<LanguageStore>.from(
            camElement.description.map((x) => LanguageStore.fromJson(x)));
        description = Utils.getTranslatedCode(context, name);
      } catch (e) {
        CampaignElement camElement =
            campaignElementFromJson(jsonDecode(campaign.campaignElement));
        List<LanguageStore> name = List<LanguageStore>.from(
            camElement.description.map((x) => LanguageStore.fromJson(x)));
        description = Utils.getTranslatedCode(context, name);
      }
    }

    return description;
  }

  _addEventToCalender(BuildContext context, Campaign campaign) async {
    try {
      String title = _getTitleForCalender(context, campaign);
      String description = _getDescription(context, campaign);
      String location = '';

      String defaultMall = await SessionManager.getDefaultMall();
      List<MallProfileModel> mallProfileModelList =
          await SuperAdminDatabaseHelper.getDefaultVenueProfile(defaultMall);
      mallProfileModelList.forEach((element) {
        location = element.name;
      });

      String startDate = campaign.startDate;
      String endDate = campaign.endDate;

      // final Event event = Event(
      //   title: title ?? '',
      //   description: description ?? "",
      //   location: location ?? "",
      //   startDate:
      //       startDate == null ? DateTime.now() : DateTime.parse(startDate),
      //   allDay: true,
      //   endDate: endDate == null ? DateTime.now() : DateTime.parse(endDate),
      //   iosParams: IOSParams(reminder: Duration()),
      //   androidParams: AndroidParams(
      //     emailInvites: [],
      //   ),
      // );
      // Add2Calendar.addEvent2Cal(event);
    } catch (e) {
      debugPrint("event_calender_issue:-  $e");
    }
  }

  _getTitleForCalender(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.campaignElement == null) return '';
    try {
      CampaignElement camElement =
          campaignElementFromJson(campaign.campaignElement);
      List<LanguageStore> name = List<LanguageStore>.from(
          camElement.name.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, name);
    } catch (e) {
      CampaignElement camElement =
          campaignElementFromJson(jsonDecode(campaign.campaignElement));
      List<LanguageStore> name = List<LanguageStore>.from(
          camElement.name.map((x) => LanguageStore.fromJson(x)));
      return Utils.getTranslatedCode(context, name);
    }
  }

  String _getTimingText(BuildContext context, Campaign campaign) {
    if (campaign == null) return '';
    if (campaign.startTime == null) return '';
    return Utils.dateConvert(
        Utils.dateConvert(campaign.startTime, AppString.DATE_FORMAT), 'hh:ss');
  }
}
