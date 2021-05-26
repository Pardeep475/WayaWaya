class CellNumberList {
  CellNumberList({
    this.data,
    this.type,
  });

  String data;
  String type;

  factory CellNumberList.fromJson(Map<String, dynamic> json) => CellNumberList(
    data: json["data"] == null ? null : json["data"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data,
    "type": type == null ? null : type,
  };
}