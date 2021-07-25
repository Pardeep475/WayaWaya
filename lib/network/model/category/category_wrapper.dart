import 'dart:convert';

CategoryWrapper categoryWrapperFromJson(String str) =>
    CategoryWrapper.fromJson(json.decode(str));

String categoryWrapperToJson(CategoryWrapper data) =>
    json.encode(data.toJson());

class CategoryWrapper {
  CategoryWrapper({
    this.items,
    this.links,
    this.meta,
  });

  List<CategoryWrapperItem> items;
  CategoryWrapperLinks links;
  Meta meta;

  factory CategoryWrapper.fromJson(Map<String, dynamic> json) =>
      CategoryWrapper(
        items: json["_items"] == null
            ? null
            : List<CategoryWrapperItem>.from(
                json["_items"].map((x) => CategoryWrapperItem.fromJson(x))),
        links: json["_links"] == null
            ? null
            : CategoryWrapperLinks.fromJson(json["_links"]),
        meta: json["_meta"] == null ? null : Meta.fromJson(json["_meta"]),
      );

  Map<String, dynamic> toJson() => {
        "_items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "_links": links == null ? null : links.toJson(),
        "_meta": meta == null ? null : meta.toJson(),
      };
}

class CategoryWrapperItem {
  CategoryWrapperItem({
    this.id,
    this.display,
    this.description,
    // this.imageId,
    this.label,
    this.type,
    this.iconId,
    this.categoryColor,
    this.subscription,
    this.parent,
    this.categoryId,
    this.name,
    // this.updated,
    // this.created,
    // this.links,
  });

  String id;
  int display;
  String description;
  // String imageId;
  List<Label> label;
  String type;
  String iconId;
  // CategoryColor categoryColor;
  dynamic categoryColor;
  int subscription;
  String parent;
  String categoryId;
  String name;
  // String updated;
  // String created;
  // ItemLinks links;

  factory CategoryWrapperItem.fromJson(Map<String, dynamic> json) =>
      CategoryWrapperItem(
        id: json["_id"],
        display: json["display"],
        description: json["description"],
        // imageId: json["image_id"],
        label: json["label"] == null
            ? null
            : List<Label>.from(json["label"].map((x) => Label.fromJson(x))),
        type: json["type"],
        iconId: json["icon_id"],
        categoryColor: json["category_color"] /*== null
            ? null
            : CategoryColor.fromJson(json["category_color"])*/,
        subscription: json["subscription"],
        parent: json["parent"],
        categoryId: json["category_id"],
        name: json["name"],
        // updated: json["_updated"],
        // created: json["_created"],
        // links:
        //     json["_links"] == null ? null : ItemLinks.fromJson(json["_links"]),
      );
// List<dynamic>.from(label.map((x) => x.toJson())),
  Map<String, dynamic> toJson() => {
        "_id": id,
        "display": display,
        "description": description,
        // "image_id": imageId,
        "label": label == null
            ? null
            : jsonEncode(label.map((e) => e.toJson()).toList()),
        "type": type,
        "icon_id": iconId,
        "category_color": categoryColor == null ? null : jsonEncode(categoryColor),
        "subscription": subscription,
        "parent": parent,
        "category_id": categoryId,
        "name": name,
        // "_updated": updated,
        // "_created": created,
        // "_links": links == null ? null : links.toJson(),
      };
}

class CategoryColor {
  CategoryColor({
    this.hex,
    this.pantone,
    this.cymk,
    this.rgb,
  });

  String hex;
  String pantone;
  Cymk cymk;
  Rgb rgb;

  factory CategoryColor.fromJson(Map<String, dynamic> json) => CategoryColor(
        hex: json["hex"],
        pantone: json["pantone"],
        cymk: json["cymk"] == null ? null : Cymk.fromJson(json["cymk"]),
        rgb: json["rgb"] == null ? null : Rgb.fromJson(json["rgb"]),
      );

  Map<String, dynamic> toJson() => {
        "hex": hex,
        "pantone": pantone,
        "cymk": cymk == null ? null : cymk.toJson(),
        "rgb": rgb == null ? null : rgb.toJson(),
      };
}

class Cymk {
  Cymk({
    this.k,
    this.c,
    this.m,
    this.y,
  });

  double k;
  double c;
  double m;
  double y;

  factory Cymk.fromJson(Map<String, dynamic> json) => Cymk(
        k: json["k"] == null ? 0.0 : json["k"].toDouble(),
        c: json["c"] == null ? 0.0 : json["c"].toDouble(),
        m: json["m"] == null ? 0.0 : json["m"].toDouble(),
        y: json["y"] == null ? 0.0 : json["y"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "k": k,
        "c": c,
        "m": m,
        "y": y,
      };
}

class Rgb {
  Rgb({
    this.b,
    this.g,
    this.r,
  });

  int b;
  int g;
  int r;

  factory Rgb.fromJson(Map<String, dynamic> json) => Rgb(
        b: json["b"],
        g: json["g"],
        r: json["r"],
      );

  Map<String, dynamic> toJson() => {
        "b": b,
        "g": g,
        "r": r,
      };
}

class Label {
  Label({
    this.text,
    this.language,
  });

  String text;
  String language;

  factory Label.fromJson(Map<String, dynamic> json) => Label(
        text: json["text"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "language": language,
      };
}

class ItemLinks {
  ItemLinks({
    this.self,
  });

  Last self;

  factory ItemLinks.fromJson(Map<String, dynamic> json) => ItemLinks(
        self: Last.fromJson(json["self"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self.toJson(),
      };
}

class Last {
  Last({
    this.title,
    this.href,
  });

  String title;
  String href;

  factory Last.fromJson(Map<String, dynamic> json) => Last(
        title: json["title"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "href": href,
      };
}

class CategoryWrapperLinks {
  CategoryWrapperLinks({
    this.parent,
    this.self,
    this.next,
    this.last,
  });

  Last parent;
  Last self;
  Last next;
  Last last;

  factory CategoryWrapperLinks.fromJson(Map<String, dynamic> json) =>
      CategoryWrapperLinks(
        parent: json["parent"] == null ? null : Last.fromJson(json["parent"]),
        self: json["self"] == null ? null : Last.fromJson(json["self"]),
        next: json["next"] == null ? null : Last.fromJson(json["next"]),
        last: json["last"] == null ? null : Last.fromJson(json["last"]),
      );

  Map<String, dynamic> toJson() => {
        "parent": parent == null ? null : parent.toJson(),
        "self": self == null ? null : self.toJson(),
        "next": next == null ? null : next.toJson(),
        "last": last == null ? null : last.toJson(),
      };
}

class Meta {
  Meta({
    this.page,
    this.maxResults,
    this.total,
  });

  int page;
  int maxResults;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        maxResults: json["max_results"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "max_results": maxResults,
        "total": total,
      };
}
