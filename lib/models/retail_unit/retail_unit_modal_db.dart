class RetailUnitModalDB {
  final dynamic retailUnitId;
  final dynamic retailUnitName;
  final dynamic retailUnitDescription;
  final dynamic retailUnitCategoryName;
  final dynamic retailUnitCategories;
  final dynamic retailUnitColor;
  final dynamic retailUnitFavourite;
  final dynamic retailUnitSubLocation;

  RetailUnitModalDB(
      {this.retailUnitId,
      this.retailUnitName,
      this.retailUnitDescription,
      this.retailUnitCategoryName,
      this.retailUnitCategories,
      this.retailUnitColor,
      this.retailUnitFavourite,
      this.retailUnitSubLocation});

  factory RetailUnitModalDB.fromJson(Map<String, dynamic> json) =>
      RetailUnitModalDB(
        retailUnitId: json["retail_unit_id"] ?? "",
        retailUnitName: json["retail_unit_id"] ?? "",
        retailUnitDescription: json["retail_unit_id"] ?? "",
        retailUnitCategoryName: json["retail_unit_id"] ?? "",
        retailUnitCategories: json["retail_unit_id"] ?? "",
        retailUnitColor: json["retail_unit_id"] ?? "",
        retailUnitFavourite: json["retail_unit_id"] ?? "",
        retailUnitSubLocation: json["retail_unit_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "retail_unit_id": retailUnitId ?? '',
        "retail_unit_name": retailUnitName ?? '',
        "retail_unit_description": retailUnitDescription ?? "",
        "retail_unit_category_name": retailUnitCategoryName ?? "",
        "retail_unit_categories": retailUnitCategories ?? "",
        "retail_unit_color": retailUnitColor ?? "",
        "retail_unit_favourite": retailUnitFavourite ?? "",
        "retail_unit_sub_location": retailUnitSubLocation ?? "",
      };
}
