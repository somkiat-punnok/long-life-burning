part of providers;

class UserProvider extends ChangeNotifier {

  FirebaseUser _user;
  String _id;
  String _name;
  num _height;
  num _weight;
  Gender _gender;
  DateTime _dateOfBirth;
  List<String> _events;

  FirebaseUser get user => _user;
  String get id => _id;
  String get name => _name;
  num get height => _height;
  num get weight => _weight;
  Gender get gender => _gender;
  DateTime get dateOfBirth => _dateOfBirth;
  List<String> get events => _events;

  set events(List<String> eventNew) {
    _events = eventNew;
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
