import 'dart:async';

class WebViewBloc {
  StreamController _webViewController = StreamController<bool>();

  StreamSink<bool> get webViewSink => _webViewController.sink;

  Stream<bool> get webViewStream => _webViewController.stream;
}
