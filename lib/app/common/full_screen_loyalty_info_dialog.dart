import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FullScreenLoyaltyInfoDialog extends ModalRoute<bool> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimens.sixteen,
      ),
      child: Column(
        children: [
          SizedBox(
            height: Dimens.hundred,
          ),
          Expanded(
            child: Container(
              color: AppColor.white,
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.sixteen,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimens.sixteen,
                        ),
                        Text(
                          AppString.intro,
                          style: GoogleFonts.ubuntuCondensed().copyWith(
                            color: Color(0xff57585a),
                            fontSize: Dimens.eighteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.some_intro_text,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.find_rewards,
                          style: GoogleFonts.ubuntuCondensed().copyWith(
                            color: Color(0xff57585a),
                            fontSize: Dimens.eighteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.header_title1_p1,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title1_p2,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title1_p3,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title1_p4,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title1_p5,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Image.asset(
                          AppImages.ic_find_rewards,
                          height: 700,
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.earn_points,
                          style: GoogleFonts.ubuntuCondensed().copyWith(
                            color: Color(0xff57585a),
                            fontSize: Dimens.eighteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.header_title2_p1,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title2_p2,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title2_p3,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title2_p4,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title2_p5,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Image.asset(
                          AppImages.ic_earn_points,
                          height: 700,
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.redeem_points,
                          style: GoogleFonts.ubuntuCondensed().copyWith(
                            color: Color(0xff57585a),
                            fontSize: Dimens.eighteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.header_title3_p1,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title3_p2,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title3_p3,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title3_p1,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Image.asset(
                          AppImages.ic_redeem_points,
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.rewards_wallet,
                          style: GoogleFonts.ubuntuCondensed().copyWith(
                            color: Color(0xff57585a),
                            fontSize: Dimens.eighteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.header_title4_p1,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title4_p2,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title4_p3,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title4_p4,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title4_p4_1,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title4_p4_2,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.header_title4_p4_3,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Image.asset(
                          AppImages.ic_rewards_wallet,
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.loyalty_title,
                          style: GoogleFonts.ubuntuCondensed().copyWith(
                            color: Color(0xff57585a),
                            fontSize: Dimens.eighteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.open_the_app,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.eighteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.h1_point1,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.h1_point2,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.h1_point3,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.h1_note,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xffD95E40),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.header_3,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.eighteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.h3_point1,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.h3_point2,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.h3_point3,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.h3_note,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xffD95E40),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.header_4,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.eighteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.h4_point1,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.h4_point2,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.h4_point3,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.h4_note,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xffD95E40),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.header_5,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.eighteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.h4_point1,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.h4_point2,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          AppString.h4_point3,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xff66000000),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        Text(
                          AppString.h4_note,
                          style: GoogleFonts.ubuntu().copyWith(
                            color: Color(0xffD95E40),
                            fontSize: Dimens.forteen,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.seven,
                        ),
                        SizedBox(
                          height: Dimens.sixteen,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  height: Dimens.one,
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimens.ten,
                      horizontal: Dimens.ten,
                    ),
                    child: Text(
                      AppString.ok.toUpperCase(),
                      style: GoogleFonts.ubuntuCondensed().copyWith(
                        color: Color(0xff57585a),
                        fontSize: Dimens.twentyTwo,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Dimens.hundred,
          ),
        ],
      ),
    );
  }

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
