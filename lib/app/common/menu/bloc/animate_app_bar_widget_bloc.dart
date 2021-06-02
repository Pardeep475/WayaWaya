import 'dart:async';

class AnimateAppBarWidgetBloc {
  StreamController _searchController = StreamController<bool>();

  StreamSink<bool> get searchSink => _searchController.sink;

  Stream<bool> get searchStream => _searchController.stream;
}
