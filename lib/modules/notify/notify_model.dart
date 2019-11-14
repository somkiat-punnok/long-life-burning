part of notify;

class Notify {
  final String id;
  final String title;
  final String body;
  final DateTime date;

  Notify({
    this.id,
    this.title,
    this.body,
    this.date,
  });

  factory Notify.fromMap(Map<String, dynamic> map) => Notify(
    id: map["id"],
    title: map["title"],
    body: map["body"],
    date: DateTime.parse("${map["date"]} ${map["time"].split(".")[0]}:${map["time"].split(".")[1]}:00"),
  );

  factory Notify.fromJson(String s) => Notify.fromMap(json.decode(s));

  Map<String, dynamic> toMap() => <String, dynamic>{
    "id": this.id,
    "title": this.title,
    "body": this.body,
    "date": this.date,
  };

  String toJson() => json.encode(this.toMap());

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is Notify &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        title == other.title &&
        body == other.body &&
        date == other.date;

  @override
  int get hashCode => (
    id.hashCode ^
    title.hashCode ^
    body.hashCode ^
    date.hashCode
  );

  @override
  String toString() {
    return '$runtimeType{id: $id, title: $title, date: $date}';
  }
}
