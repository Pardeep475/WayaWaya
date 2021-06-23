import 'dart:convert';

import 'package:wayawaya/app/shop/model/image_model.dart';

ImageProperties imagePropertiesFromJson(String str) =>
    ImageProperties.fromJson(json.decode(str));

String imagePropertiesToJson(ImageProperties data) =>
    json.encode(data.toJson());

class ImageProperties {
  final ImageModel image;
  final String type;

  ImageProperties({this.image, this.type});

  factory ImageProperties.fromJson(Map<String, dynamic> json) =>
      ImageProperties(
          image: json["image"] == null
              ? null
              : ImageModel.fromJson(
                  json["image"],
                ),
          type: json["type"]);

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image.toJson(),
        "type": type,
      };
}
