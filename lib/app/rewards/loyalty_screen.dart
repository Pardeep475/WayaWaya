import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/common/circular_percent_indicator.dart';
import 'package:wayawaya/app/common/full_screen_loyalty_info_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/rewards/bloc/loyalty_bloc.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/dimens.dart';

class LoyaltyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends State<LoyaltyScreen> {
  LoyaltyBloc _loyaltyBloc;

  @override
  void initState() {
    _loyaltyBloc = LoyaltyBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context, FullScreenLoyaltyInfoDialog());
        },
        child: Container(
          child: Icon(
            Icons.info_outline,
            color: Color(0xff1774E6),
            size: Dimens.forty,
          ),
        ),
      ),
      body: Stack(
        children: [
          StreamBuilder<List<MainMenuPermission>>(
              initialData: [],
              stream: _loyaltyBloc.mainMenuPermissionStream,
              builder: (context, snapshot) {
                return AnimateAppBar(
                  title: 'Home/Rewards/Wallet',
                  isSliver: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainMenuPermissions: snapshot.data,
                  children: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(
                            right: Dimens.twenty, bottom: Dimens.twenty),
                        alignment: Alignment.bottomRight,
                        height: Dimens.twoHundredFifty,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage(AppImages.ic_loyelty_chart_banner),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: CircularPercentIndicator(
                          radius: Dimens.oneFifty,
                          lineWidth: Dimens.thirty,
                          animation: true,
                          percent: 0.3,
                          startAngle: 270,
                          circularStrokeCap: CircularStrokeCap.round,
                          backgroundColor: Colors.red[100],
                          progressColor: Colors.red[200],
                          center: Container(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '30',
                                        style: GoogleFonts.ubuntuCondensed()
                                            .copyWith(
                                          color: AppColor.red_500,
                                          fontSize: Dimens.forty,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimens.five,
                                      ),
                                      Text(
                                        'Available',
                                        style: GoogleFonts.ubuntuCondensed()
                                            .copyWith(
                                          color: AppColor.red_500,
                                          fontSize: Dimens.nineteen,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: Dimens.forty,
                                  top: Dimens.eight,
                                  child: Text(
                                    '6',
                                    style:
                                        GoogleFonts.ubuntuCondensed().copyWith(
                                      color: AppColor.red_500,
                                      fontSize: Dimens.thirty,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
