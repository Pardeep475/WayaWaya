import 'package:wayawaya/common/model/rgb_code.dart';

import 'cymk_code.dart';

class ColorCodes {
  RgbCode rgbCode;
  String hexCode;
  String pantoneCode;
  CymkCode cymkCode;

  ColorCodes({this.rgbCode, this.hexCode, this.pantoneCode, this.cymkCode});

  Map<String, dynamic> toJson() => {
        "rgb": rgbCode == null ? null : rgbCode.toJson(),
        "hex": hexCode,
        "pantone": pantoneCode,
        "cymk": cymkCode == null ? null : cymkCode.toJson(),
      };

  ColorCodes.fromJson(Map<String, dynamic> json) {
    rgbCode = json['rgb'];
    hexCode = json['hex'];
    pantoneCode = json['pantone'];
    cymkCode = json['cymk'];
  }
}
