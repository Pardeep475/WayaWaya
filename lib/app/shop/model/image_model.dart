import 'dart:convert';

ImageModel imageModelFromJson(String str) =>
    ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  final String file;
  final dynamic length;
  final String contentType;
  final String name;

  ImageModel({this.file, this.length, this.contentType, this.name});

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        file: json["file"],
        length: json["length"],
        contentType: json["content_type"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "length": length,
        "content_type": contentType,
        "name": name,
      };
}
