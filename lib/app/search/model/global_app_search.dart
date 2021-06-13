class GlobalAppSearch {
  String name;
  String type;
  String heading;
  String description;
  String startDate;
  String endDate;
  String startTime;

  GlobalAppSearch({
    this.name,
    this.type,
    this.heading,
    this.description,
    this.startDate,
    this.endDate,
    this.startTime,
  });

  factory GlobalAppSearch.fromJson(Map<String, dynamic> json) =>
      GlobalAppSearch(
        name: json["name"],
        type: json["type"],
        heading: json["heading"],
        description: json["description"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        startTime: json["start_time"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "heading": heading,
        "description": description,
        "start_date": startDate,
        "end_date": endDate,
        "start_time": startTime,
      };
}
