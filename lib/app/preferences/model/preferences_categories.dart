class PreferencesCategory {
  String parent;
  String categoryId;
  String name;
  String label;
  int subscription;

  PreferencesCategory(
      {this.parent, this.categoryId, this.name, this.label, this.subscription});

  factory PreferencesCategory.fromJson(Map<String, dynamic> json) =>
      PreferencesCategory(
        parent: json["parent"] == null ? '' : json["parent"],
        categoryId: json["category_id"] == null ? '' : json["category_id"],
        name: json["name"] == null ? '' : json["name"],
        label: json["label"] == null ? '' : json["label"],
        subscription: json["subscription"] == null ? '' : json["subscription"],
      );

  Map<String, dynamic> toJson() => {
        "parent": parent == null ? '' : parent,
        "category_id": categoryId == null ? '' : categoryId,
        "name": name == null ? '' : name,
        "label": label == null ? '' : label,
        "subscription": label == null ? '' : subscription,
      };
}
