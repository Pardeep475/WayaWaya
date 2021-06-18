import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/common/zoom_out_page_transformation.dart';
import 'package:wayawaya/app/events/bloc/event_detail_bloc.dart';
import 'package:wayawaya/app/events/view/item_event_detail_view.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
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
    title = Utils.getTranslatedCode(context, campaign.campaignElement.name);
    if(title != lastTitle){
      lastTitle = title;
      _eventDetailBloc.mainMenuPermissionSink.add(_eventDetailBloc.mainMenuList);
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
                stream: _eventDetailBloc.mainMenuPermissionStream,
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
                              return Column(
                                children: [
                                  ItemEventDetailView(
                                      campaign: _listOfCampaign[index]),
                                  Expanded(child: SizedBox()),
                                  Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        bottomButton(1),
                                        bottomButton(2),
                                        bottomButton(3),
                                        bottomButton(4),
                                      ],
                                    ),
                                  ),
                                ],
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

  Container bottomButton(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Icon(
              (index == 1)
                  ? Icons.remove_red_eye
                  : (index == 2)
                  ? Icons.watch_later_outlined
                  : (index == 3)
                  ? Icons.share
                  : Icons.calendar_today,
              size: 25,
              color: Colors.grey[700],
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              (index == 2)
                  ? '06:00'
                  : (index == 4)
                  ? 'Add'
                  : '0',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
