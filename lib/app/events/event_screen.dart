import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/events/view/item_event_view.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/offers/view/item_offer_view.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';

import '../../constants.dart';
import 'bloc/event_bloc.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool _hasRewards = true;

  Widget offerCard(int index) {
    return SizedBox();
  }

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

  EventBloc _eventBloc;

  @override
  void initState() {
    super.initState();
    _eventBloc = EventBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _eventBloc.fetchMenuButtons();
      _eventBloc.getEventCampaign();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder<List<MainMenuPermission>>(
          initialData: [],
          stream: _eventBloc.mainMenuPermissionStream,
          builder: (context, snapshot) {
            return AnimateAppBar(
              title: AppString.offers.toUpperCase(),
              isSliver: true,
              mainMenuPermissions: snapshot.data,
              children: [
                StreamBuilder<ApiResponse<List<Campaign>>>(
                  stream: _eventBloc.eventCampaignStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          // Future.delayed(Duration(milliseconds: 200), () {
                          //   Utils.commonProgressDialog(context);
                          // });
                          return SliverFillRemaining(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              height: MediaQuery.of(context).size.height,
                            ),
                          );
                          break;
                        case Status.COMPLETED:
                          {
                            debugPrint("completed");
                            // Navigator.pop(context);
                            if (snapshot.data.data.isEmpty) {
                              return SliverToBoxAdapter(
                                child: Card(
                                  color: AppColor.white,
                                  elevation: 2,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 30),
                                    child: Text(
                                      AppString.no_offer_found,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.ubuntuCondensed()
                                          .copyWith(
                                        color: black.withOpacity(0.7),
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return ItemEventView(
                                      campaign: snapshot.data.data[index],
                                    );
                                  },
                                  childCount: snapshot.data.data.length,
                                ),
                              );
                            }
                          }
                          break;
                        case Status.ERROR:
                          {
                            // Navigator.pop(context);
                            Future.delayed(Duration(milliseconds: 100), () {
                              _showErrorDialog(
                                icon: Icon(
                                  FontAwesomeIcons.exclamationTriangle,
                                  color: AppColor.orange_500,
                                ),
                                title: AppString.login.toUpperCase(),
                                content:
                                    AppString.check_your_internet_connectivity,
                                buttonText: AppString.ok.toUpperCase(),
                                onPressed: () => Navigator.pop(context),
                              );
                            });
                          }
                          break;
                      }
                    }
                    return SliverToBoxAdapter();
                  },
                ),
              ],
            );
          }),
    ));
  }

  _showErrorDialog(
      {Icon icon,
      String title,
      String content,
      String buttonText,
      VoidCallback onPressed}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonErrorDialog(
                icon: icon,
                title: title,
                content: content,
                buttonText: buttonText,
                onPressed: onPressed,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
}