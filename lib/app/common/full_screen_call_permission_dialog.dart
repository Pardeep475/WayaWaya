import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/permission_service/permission_service.dart';
import 'package:wayawaya/utils/utils.dart';

class FullScreenCallDialogPermission extends ModalRoute<bool> {
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
              borderRadius: BorderRadius.circular(Dimens.ten)),
          margin: EdgeInsets.only(left: Dimens.sixteen, right: Dimens.sixteen),
          padding: EdgeInsets.only(left: Dimens.sixteen, right: Dimens.sixteen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Dimens.twenty,
              ),
              Text(
                AppString.for_video_calling_please_allow,
                textAlign: TextAlign.start,
                style: GoogleFonts.ubuntuCondensed().copyWith(
                  color: Color(0xff57585a),
                  fontSize: Dimens.twenty,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(
                height: Dimens.twenty,
              ),
              Text(
                AppString.navigation_draw_over_the_app,
                textAlign: TextAlign.start,
                style: GoogleFonts.ubuntuCondensed().copyWith(
                  color: Color(0xff57585a),
                  fontSize: Dimens.twenty,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(
                height: Dimens.twenty,
              ),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () async {
                      _onBackPressed(context);
                    },
                    child: Text(
                      AppString.close.toUpperCase(),
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
                    onPressed: () async {
                      bool status = await PermissionService
                          .requestSystemOverLayPermission();
                      if (status) {
                        Navigator.pop(context, true);
                      } else {
                        _onBackPressed(context);
                      }
                    },
                    child: Text(
                      AppString.allow.toUpperCase(),
                      style: GoogleFonts.ubuntuCondensed().copyWith(
                        color: Color(0xff57585a),
                        fontSize: Dimens.eighteen,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBackPressed(BuildContext context) async {
    // await Future.delayed(Duration.zero, () => Navigator.pop(context))
    //     .whenComplete(() => Navigator.of(context).pop());
    SystemNavigator.pop();
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
