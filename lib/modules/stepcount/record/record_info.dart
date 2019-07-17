class RecordInfo {

  final String id,detail;
  
  RecordInfo({
    this.id,
    this.detail,
  });

  RecordInfo.fromJson(Map json)
    : id = json["id"],
      detail = json["detail"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["detail"] = detail;
    return map;
  }

  RecordInfo.fromDB(Map map)
    : id = map["id"],
      detail = map["detail"];

}