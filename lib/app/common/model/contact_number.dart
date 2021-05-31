class CellNumberList {
  CellNumberList({
    this.data,
    this.type,
  });

  String data;
  String type;

  factory CellNumberList.fromJson(Map<String, dynamic> json) => CellNumberList(
    data: json["data"] == null ? '' : json["data"],
    type: json["type"] == null ? '' : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? '' : data,
    "type": type == null ? '' : type,
  };
}