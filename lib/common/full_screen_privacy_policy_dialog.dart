import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bloc/web_view_bloc.dart';

class FullScreenPrivacyPolicyDialog extends ModalRoute<bool> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final _webViewBloc = WebViewBloc();
  String title;
  String url;

  FullScreenPrivacyPolicyDialog({String title, String url}) {
    this.title = title;
    this.url = url;
  }

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
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(
            vertical: Dimens.forty, horizontal: Dimens.forty),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimens.twenty,
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimens.twenty),
              child: Text(
                title ?? AppString.privacy_policy,
                style: TextStyle(
                  fontSize: Dimens.twenty,
                  color: AppColor.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: Dimens.ten,
            ),
            Expanded(
              child: Stack(
                children: [
                  WebView(
                    initialUrl:
                        Uri.dataFromString(this.url, mimeType: 'text/html',parameters: { 'charset': 'utf-8' }).toString()
                                 ??
                            AppString.PRIVACY_POLICY_URL,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebResourceError: (WebResourceError error) {
                      print("WebView_error:- $error");
                    },
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    onProgress: (int progress) {
                      print("WebView is loading (progress : $progress%)");
                    },
                    javascriptChannels: <JavascriptChannel>{
                      _toasterJavascriptChannel(context),
                    },
                    navigationDelegate: (NavigationRequest request) {
                      if (request.url.startsWith('https://www.youtube.com/')) {
                        print('blocking navigation to $request}');
                        return NavigationDecision.prevent;
                      }
                      print('allowing navigation to $request');
                      return NavigationDecision.navigate;
                    },
                    onPageStarted: (String url) {
                      print('Page started loading: $url');
                    },
                    onPageFinished: (String url) {
                      _webViewBloc.webViewSink.add(false);
                      print('Page finished loading: $url');
                    },
                    gestureNavigationEnabled: true,
                  ),
                  // Positioned(
                  //   left: 0,
                  //   right: 0,
                  //   top: 0,
                  //   child: Container(
                  //     height: Dimens.oneThirty,
                  //     color: Color(0xffC3C0D3),
                  //     padding: EdgeInsets.only(left: Dimens.fortyFive),
                  //     child: Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Image.asset(
                  //         'assets/yellow_fist_bump.png',
                  //         height: Dimens.forty,
                  //         width: Dimens.forty,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  StreamBuilder<bool>(
                      stream: _webViewBloc.webViewStream,
                      initialData: true,
                      builder: (context, snapshot) {
                        return snapshot.data
                            ? Positioned(
                                left: MediaQuery.of(context).size.width / 4,
                                right: 0,
                                top: MediaQuery.of(context).size.height / 3,
                                child: Container(
                                  height: Dimens.forty,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: Dimens.thirty,
                                        width: Dimens.thirty,
                                        child: CircularProgressIndicator(
                                          strokeWidth: Dimens.two,
                                          backgroundColor: AppColor.primaryDark,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimens.ten,
                                      ),
                                      Text(
                                        AppString.processing_data,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: Dimens.forteen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox();
                      }),
                ],
              ),
            ),
            SizedBox(
              height: Dimens.ten,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    AppString.disagree.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimens.fifteen,
                    ),
                  ),
                  onPressed: () {
                    // privacyPolicy = false;
                    // Navigator.of(context).pop(false);
                    Navigator.pop(context, false);
                  },
                ),
                TextButton(
                  child: Text(
                    AppString.agree.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimens.fifteen,
                    ),
                  ),
                  onPressed: () {
                    // privacyPolicy = true;
                    Navigator.pop(context, true);
                    // Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
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
