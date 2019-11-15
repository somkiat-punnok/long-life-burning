part of providers;

class EventRecordUser {

  final String eventId;
  final bool isRecord;
  final num calories;
  final num distance;
  final TimeRecordUser avgpace;
  final TimeRecordUser duration;

  EventRecordUser({
    this.eventId,
    this.isRecord,
    this.calories,
    this.distance,
    this.avgpace,
    this.duration,
  });

  factory EventRecordUser.fromMap(Map<String, dynamic> map) => EventRecordUser(
    eventId: map["eventId"],
    isRecord: map["record"],
    calories: map["calories"],
    distance: map["distance"],
    avgpace: TimeRecordUser.fromMap(map["avgpace"]),
    duration: TimeRecordUser.fromMap(map["duration"]),
  );

  factory EventRecordUser.fromJson(String s) => EventRecordUser.fromMap(json.decode(s));

  Map<String, dynamic> toMap() => <String, dynamic>{
    "eventId": this.eventId,
    "record": this.isRecord,
    "calories": this.calories,
    "distance": this.distance,
    "avgpace": this.avgpace.toMap(),
    "duration": this.duration.toMap(),
  };

  String toJson() => json.encode(this.toMap());

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is EventRecordUser &&
        runtimeType == other.runtimeType &&
        eventId == other.eventId &&
        isRecord == other.isRecord &&
        calories == other.calories &&
        distance == other.distance &&
        avgpace == other.avgpace &&
        duration == other.duration;

  @override
  int get hashCode => (
    eventId.hashCode ^
    isRecord.hashCode ^
    calories.hashCode ^
    distance.hashCode ^
    avgpace.hashCode ^
    duration.hashCode
  );

  @override
  String toString() {
    return '$runtimeType{id: $eventId, calories: $calories, distance: $distance}';
  }
}

class TimeRecordUser {

  final num hour;
  final num minute;
  final num second;

  TimeRecordUser({
    this.hour,
    this.minute,
    this.second,
  });

  factory TimeRecordUser.fromMap(Map map) => TimeRecordUser(
    hour: map["hour"],
    minute: map["minute"],
    second: map["second"],
  );

  factory TimeRecordUser.fromJson(String s) => TimeRecordUser.fromMap(json.decode(s));

  Map<String, dynamic> toMap() => <String, dynamic>{
    "hour": this.hour,
    "minute": this.minute,
    "second": this.second,
  };

  String toJson() => json.encode(this.toMap());

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is TimeRecordUser &&
        runtimeType == other.runtimeType &&
        hour == other.hour &&
        minute == other.minute &&
        second == other.second;

  @override
  int get hashCode => (
    hour.hashCode ^
    minute.hashCode ^
    second.hashCode
  );

  @override
  String toString() {
    return '$runtimeType{hour: $hour, minute: $minute, second: $second}';
  }
}

class UserProvider extends ChangeNotifier {

  FirebaseUser _user;
  String _id;
  String _name;
  num _height;
  num _weight;
  Gender _gender;
  DateTime _dateOfBirth;
  List<String> _events;
  List<EventRecordUser> _record;

  FirebaseUser get user => _user;
  String get id => _id;
  String get name => _name;
  num get height => _height;
  num get weight => _weight;
  Gender get gender => _gender;
  DateTime get dateOfBirth => _dateOfBirth;
  List<String> get events => _events;
  List<EventRecordUser> get record => _record;

  set events(List<String> eventNew) {
    _events = eventNew;
  }

  set record(List<EventRecordUser> recordNew) {
    _record = recordNew;
  }

  void setUser({
    FirebaseUser userNew,
    String idNew,
    String nameNew,
    String genderNew,
    dynamic dateOfBirthNew,
    num heightNew,
    num weightNew,
  }) {
    _user = userNew;
    _id = idNew;
    _name = nameNew;
    _height = heightNew;
    _weight = weightNew;
    _gender = genderNew != null ? genderNew?.toLowerCase() != 'female' ? Gender.MALE : Gender.FEMALE : null;
    _dateOfBirth = dateOfBirthNew != null ? DateTime.fromMicrosecondsSinceEpoch(dateOfBirthNew?.microsecondsSinceEpoch ?? 0) : null;
    notifyListeners();
  }

  void resetUser() {
    _user = null;
    _id = null;
    _name = null;
    _height = null;
    _weight = null;
    _gender = null;
    _dateOfBirth = null;
    _events = null;
    notifyListeners();
  }
}
