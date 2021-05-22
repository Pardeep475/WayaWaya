import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';

import 'custom_raise_button.dart';

class FullScreenDialogWithWebView extends ModalRoute<void> {
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
      persistentFooterButtons: [
        Builder(
          builder: (BuildContext context) {
            return CustomRaiseButton(
              backgroundColor: AppColor.white,
              title: AppString.submit.toUpperCase(),
              borderRadius: 0,
              width: MediaQuery.of(context).size.width,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ],
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: Dimens.forty, horizontal: Dimens.forty),
        child: WebviewScaffold(
          url: "https://instagram.com/mahi7781",
          withZoom: true,
          withLocalStorage: true,
          initialChild: Container(
            child: const Center(
              child: Text(
                "Loading....",
                style: TextStyle(color: AppColor.black),
              ),
            ),
          ),
        ),
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
