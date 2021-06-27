import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bloc/custom_web_view_bloc.dart';
import 'model/custom_web_view_model.dart';

class CustomWebView extends StatelessWidget {
  final CustomWebViewBloc _customWebViewBloc = CustomWebViewBloc();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    CustomWebViewModel _customWebViewModel =
        ModalRoute.of(context).settings.arguments;

    debugPrint(
        'custom_web_view_model:-   title:- ${_customWebViewModel.title}   \n   url:-  ${_customWebViewModel.webViewUrl}');

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder<List<MainMenuPermission>>(
          initialData: [],
          stream: _customWebViewBloc.mainMenuPermissionStream,
          builder: (context, snapshot) {
            return AnimateAppBar(
              title: _customWebViewModel.title,
              isSliver: true,
              mainMenuPermissions: snapshot.data,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SliverFillRemaining(
                  child: Stack(
                    children: [
                      WebView(
                        initialUrl: _customWebViewModel.webViewUrl,
                        gestureRecognizers: <
                            Factory<OneSequenceGestureRecognizer>>{
                          Factory<VerticalDragGestureRecognizer>(
                              () => VerticalDragGestureRecognizer()),
                        },
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          _controller.complete(webViewController);
                          _customWebViewBloc.webViewSink.add(false);
                        },
                        onProgress: (int progress) {
                          debugPrint(
                              "WebView is loading (progress : $progress%)");
                        },
                        onPageStarted: (String url) {
                          debugPrint('Page started loading: $url');
                          _customWebViewBloc.webViewSink.add(false);
                        },
                        onPageFinished: (String url) {
                          debugPrint('Page finished loading: $url');
                          _customWebViewBloc.webViewSink.add(true);
                        },
                        debuggingEnabled: true,
                        onWebResourceError: (error) {
                          _customWebViewBloc.webViewSink.add(true);
                          debugPrint(
                              'Page error: ${error.description}  \n ${error.errorType}  \n ${error.errorCode} \n ${error.domain}  \n ${error.failingUrl}');
                        },
                        gestureNavigationEnabled: false,
                      ),
                      StreamBuilder<bool>(
                          initialData: false,
                          stream: _customWebViewBloc.webViewStream,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const SizedBox();
                            }
                            if (snapshot.data) {
                              return const SizedBox();
                            } else {
                              return Positioned.fill(
                                child: Container(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              AppColor.primary),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ],
            );
          }),
    ));
  }
}
