import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/map/model/service_model.dart';
import 'package:wayawaya/app/map/view/item_the_mall.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';

import 'bloc/the_mall_bloc.dart';

class TheMallScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TheMallScreenState();
}

class _TheMallScreenState extends State<TheMallScreen> {
  TheMallBloc _theMallBloc;

  @override
  void initState() {
    _theMallBloc = TheMallBloc();
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _theMallBloc.fetchServicesData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<List<MainMenuPermission>>(
            initialData: [],
            stream: _theMallBloc.mainMenuPermissionStream,
            builder: (context, snapshot) {
              return AnimateAppBar(
                title: 'Services'.toUpperCase(),
                isSliver: true,
                mainMenuPermissions: snapshot.data,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  StreamBuilder<ApiResponse<List<ServiceModel>>>(
                    stream: _theMallBloc.serviceStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30),
                                      child: Text(
                                        AppString.no_offer_found,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ubuntuCondensed()
                                            .copyWith(
                                          color:
                                              AppColor.black.withOpacity(0.7),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return SliverPadding(
                                  padding: EdgeInsets.all(Dimens.five),
                                  sliver: SliverGrid(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: Dimens.five,
                                      mainAxisSpacing: Dimens.five,
                                    ),
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return ItemTheMall(
                                          serviceModel:
                                              snapshot.data.data[index],
                                          index: index,
                                        );
                                      },
                                      childCount: snapshot.data.data.length,
                                    ),
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
                                  content: AppString
                                      .check_your_internet_connectivity,
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
      ),
    );
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
