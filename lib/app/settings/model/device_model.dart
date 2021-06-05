import 'package:flutter/cupertino.dart';

class DeviceModel {
  final bool isCurrentDevice;
  final String model;
  final String manufacturer;
  final String os;

  DeviceModel({this.isCurrentDevice, this.model, this.manufacturer, this.os});
}
