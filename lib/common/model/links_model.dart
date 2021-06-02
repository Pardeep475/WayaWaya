import 'link_model.dart';

class Links {
  Link self;
  Link parent;
  Link next;

  Links({this.self, this.parent, this.next});

  Map<String, dynamic> toJson() => {
        "self": self == null ? null : self.toJson(),
        "parent": parent == null ? null : parent.toJson(),
        "next": next == null ? null : next.toJson(),
      };

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    parent = json['parent'];
    next = json['next'];
  }
}
