part of notify;

class Notify {

  final num id;
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
    date: map["date"] != null ? DateTime.fromMicrosecondsSinceEpoch(map["date"]?.microsecondsSinceEpoch ?? 0) : null,
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
