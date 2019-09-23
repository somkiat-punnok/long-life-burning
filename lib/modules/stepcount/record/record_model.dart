part of record;

class RecordModel {

  int id;
  String day;
  int step;
  double cal;
  double dist;
  
  RecordModel({
    this.id,
    this.day,
    this.step,
    this.cal,
    this.dist,
  });

  factory RecordModel.fromMap(Map<String, dynamic> map) => RecordModel(
    id: int.parse(map[columnId]),
    day: map[columnDay],
    step: int.parse(map[columnStep]),
    cal: double.parse(map[columnCal]),
    dist: double.parse(map[columnDist]),
  );

  factory RecordModel.fromJson(String s) => RecordModel.fromMap(json.decode(s));

  Map<String, dynamic> toMap() => <String, dynamic>{
    columnId: this.id ?? 0,
    columnDay: this.day ?? '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}',
    columnStep: this.step ?? 0,
    columnCal: this.cal ?? 0.0,
    columnDist: this.dist ?? 0.0,
  };

  String toJson() => json.encode(this.toMap());

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is RecordModel &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        day == other.day &&
        step == other.step &&
        cal == other.cal &&
        dist == other.dist;

  @override
  int get hashCode =>
    id.hashCode ^
    day.hashCode ^
    step.hashCode ^
    cal.hashCode ^
    dist.hashCode;

  @override
  String toString() {
    return '$runtimeType{day: $day, step: $step, cal: $cal, dist: $dist}';
  }

}