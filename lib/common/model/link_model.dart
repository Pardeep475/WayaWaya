class Link {
  String href;
  String title;

  Link(this.href, this.title);

  Map<String, dynamic> toJson() => {"href": href, "title": title};

  Link.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    title = json['title'];
  }
}
