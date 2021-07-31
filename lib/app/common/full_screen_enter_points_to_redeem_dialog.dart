import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';

class FullScreenEnterPointsToRedeemDialog extends ModalRoute<bool> {
  final Function(int position) onPressed;

  TextEditingController _redeemPointsController = TextEditingController();
  var _redeemFormKey = GlobalKey<FormState>();

  FullScreenEnterPointsToRedeemDialog({this.onPressed});

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
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimens.sixteen)),
          margin: EdgeInsets.only(left: Dimens.sixteen, right: Dimens.sixteen),
          padding: EdgeInsets.only(left: Dimens.sixteen, right: Dimens.sixteen),
          child: Form(
            key: _redeemFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Dimens.twenty,
                ),
                Text(
                  AppString.enter_points,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntuCondensed().copyWith(
                    color: Color(0xff57585a),
                    fontSize: Dimens.twentyTwo,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(
                  height: Dimens.twenty,
                ),
                TextFormField(
                  autofocus: false,
                  controller: _redeemPointsController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppString.enter_points_error;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppString.no_points_entered,
                    alignLabelWithHint: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: TextStyle(
                      fontSize: Dimens.sixteen,
                      fontWeight: FontWeight.w400,
                    ),
                    hintStyle: TextStyle(
                      fontSize: Dimens.sixteen,
                      fontWeight: FontWeight.w400,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.colored_text,
                        width: Dimens.two,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.borderColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: Dimens.twenty,
                ),
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppString.cancel.toUpperCase(),
                        style: GoogleFonts.ubuntuCondensed().copyWith(
                          color: Color(0xff57585a),
                          fontSize: Dimens.eighteen,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimens.ten,
                    ),
                    TextButton(
                      onPressed: () {
                        _onBackPressed(context);
                      },
                      child: Text(
                        AppString.redeem_now.toUpperCase(),
                        style: GoogleFonts.ubuntuCondensed().copyWith(
                          color: Color(0xff57585a),
                          fontSize: Dimens.eighteen,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onBackPressed(BuildContext context) {
    if (_redeemFormKey.currentState.validate()) {
      Navigator.pop(context);
      if (onPressed != null) onPressed(int.parse(_redeemPointsController.text));
    }

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
