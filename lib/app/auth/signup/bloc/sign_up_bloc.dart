import 'dart:async';

class SignUpBloc {

  StreamController _tACController = StreamController<bool>();

  StreamSink<bool> get tACSink => _tACController.sink;

  Stream<bool> get tACStream => _tACController.stream;

  StreamController _newsLetterController = StreamController<bool>();

  StreamSink<bool> get newsLetterSink => _newsLetterController.sink;

  Stream<bool> get newsLetterStream => _newsLetterController.stream;

  StreamController _genderController = StreamController<int>();

  StreamSink<int> get genderSink => _genderController.sink;

  Stream<int> get genderStream => _genderController.stream;
}
