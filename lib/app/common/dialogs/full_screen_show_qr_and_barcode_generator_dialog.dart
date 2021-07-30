import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/utils.dart';

class FullScreenShowQrAndBarCodeGeneratorDialog extends ModalRoute<bool> {
  final String content;
  final String codeText;
  final String type;
  final VoidCallback onOkButtonPressed;

  FullScreenShowQrAndBarCodeGeneratorDialog(
      {this.content, this.codeText, this.type, this.onOkButtonPressed});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Dimens.twenty,
              ),
              Text(
                AppString.success,
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntuCondensed().copyWith(
                  color: Color(0xff57585a),
                  fontSize: Dimens.twentyTwo,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(
                height: Dimens.ten,
              ),
              Text(
                content,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: GoogleFonts.ubuntuCondensed().copyWith(
                  color: Color(0xff57585a),
                  fontSize: Dimens.eighteen,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
              // SizedBox(
              //   height: Dimens.twenty,
              // ),
              // Text(
              //   AppString.some_intro_text,
              //   textAlign: TextAlign.center,
              //   maxLines: 3,
              //   style: GoogleFonts.ubuntuCondensed().copyWith(
              //     color: Color(0xff57585a),
              //     fontSize: Dimens.eighteen,
              //     fontWeight: FontWeight.w500,
              //     letterSpacing: 0.8,
              //   ),
              // ),
              SizedBox(
                height: Dimens.twenty,
              ),
              Utils.checkNullOrEmpty(type)
                  ? SizedBox()
                  : type == "qr"
                      ? QrImage(
                          data: codeText ?? "",
                          version: QrVersions.auto,
                          size: 200.0,
                        )
                      : BarcodeWidget(
                          barcode: Barcode.code128(),
                          data: codeText ?? "",
                        ),

              SizedBox(
                height: Utils.checkNullOrEmpty(type) ? 0 : Dimens.ten,
              ),
              TextButton(
                onPressed: () {
                  _onBackPressed(context);
                },
                child: Text(
                  AppString.ok.toUpperCase(),
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
        ),
      ),
    );
  }

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
    onOkButtonPressed();
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
