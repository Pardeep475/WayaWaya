import 'dart:async';

class CategoriesPreferencesBloc {
  // ignore: close_sinks
  StreamController _switchController = StreamController<bool>();

  StreamSink<bool> get switchSink => _switchController.sink;

  Stream<bool> get switchStream => _switchController.stream;
}
