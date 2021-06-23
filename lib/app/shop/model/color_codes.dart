import 'dart:convert';

import 'rgb_code.dart';
import 'cymk_code.dart';

class ColorCodes {
  final RgbCode rgbCode;
  final String hexCode;
  final String pantoneCode;

  final CymkCode cymkCode;

  ColorCodes({this.rgbCode, this.hexCode, this.pantoneCode, this.cymkCode});

  Map<String, dynamic> toJson() => {
        "rgb": rgbCode == null ? null : rgbCode.toJson(),
        "hex": hexCode,
        "pantone": pantoneCode,
        "cymk": cymkCode == null ? null : cymkCode.toJson(),
      };

  factory ColorCodes.fromJson(Map<String, dynamic> json) => ColorCodes(
        rgbCode: json['rgb'] == null
            ? null
            : RgbCode.fromJson(
                json['rgb'],
              ),
        hexCode: json['hex'],
        pantoneCode: json['pantone'],
        cymkCode: json['cymk'] == null
            ? null
            : CymkCode.fromJson(
                json['cymk'],
              ),
      );
}
