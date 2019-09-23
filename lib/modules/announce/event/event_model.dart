part of event;

class EventModel {

  final String id;
  final String detail;
  final DateTime date;
  
  EventModel({
    this.id,
    this.detail,
    this.date,
  });

  factory EventModel.fromMap(Map<String, dynamic> map) => EventModel(
    id: map["id"],
    detail: map["detail"],
    date: DateTime.parse(map["date"]),
  );

  factory EventModel.fromJson(String s) => EventModel.fromMap(json.decode(s));

  Map<String, dynamic> toMap() => <String, dynamic>{
    "id": this.id,
    "detail": this.detail,
    "date": this.date.toIso8601String(),
  };

  String toJson() => json.encode(this.toMap());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EventModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              detail == other.detail &&
              date == other.date;

  @override
  int get hashCode => (id.hashCode ^ detail.hashCode ^ date.hashCode);

  @override
  String toString() {
    return '$runtimeType{id: $id, detail: $detail, date: $date}';
  }

}
