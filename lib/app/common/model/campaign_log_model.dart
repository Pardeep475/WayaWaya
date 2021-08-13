class CampaignLogModel{

  dynamic cid;
  dynamic page;
  String action;
  String user;


  CampaignLogModel({this.cid, this.page, this.action, this.user});

  factory CampaignLogModel.fromJson(Map<String, dynamic> json) => CampaignLogModel(
    cid: json["cid"] == null ? '' : json["cid"],
    page: json["page"] == null ? '' : json["page"],
    action: json["action"] == null ? '' : json["action"],
    user: json["user"] == null ? '' : json["user"],
  );

  Map<String, dynamic> toJson() => {
    "cid": cid == null ? '' : cid,
    "page": page == null ? '' : page,
    "action": action == null ? '' : action,
    "user": user == null ? '' : user,
  };

}