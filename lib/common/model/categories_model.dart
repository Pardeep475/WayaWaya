import 'color_codes.dart';
import 'language_store.dart';
import 'links_model.dart';

class Category {
  String description;
  String parent;
  String id;
  String categoryId;
  String name;
  String type;
  int subscription;
  int display;
  Links links;
  String categoryColor;
  String label;

  Map<String, dynamic> toJson() => {
        "description": description,
        "parent": parent,
        "_id": id,
        "category_id": categoryId,
        "name": name,
        "type": type,
        "subscription": subscription,
        "display": display,
        "_links": links == null ? null : links.toJson(),
        "category_color": categoryColor /*== null ? null : categoryColor.toJson()*/,
        "label": label /*== null
            ? null
            : List<dynamic>.from(label.map((x) => x.toJson()))*/,
      };

  Category.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    parent = json['parent'];
    id = json['_id'];
    categoryId = json['category_id'];
    name = json['name'];
    type = json['type'];
    subscription = json['subscription'];
    display = json['display'];
    links = json['_links'];
    categoryColor = json['category_color'];
    label = json['label'];
  }
}
