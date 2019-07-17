class EventInfo {

  final String id,detail;
  
  EventInfo({
    this.id,
    this.detail,
  });

  EventInfo.fromJson(Map json)
    : id = json["id"],
      detail = json["detail"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["detail"] = detail;
    return map;
  }

  EventInfo.fromDB(Map map)
    : id = map["id"],
      detail = map["detail"];

}