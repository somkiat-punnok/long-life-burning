part of providers;

class UserProvider extends ChangeNotifier {

  FirebaseUser _user;
  String _id;
  String _name;
  num _height;
  num _weight;
  Gender _gender;
  DateTime _dateOfBirth;

  FirebaseUser get user => _user;
  String get id => _id;
  String get name => _name;
  num get height => _height;
  num get weight => _weight;
  Gender get gender => _gender;
  DateTime get dateOfBirth => _dateOfBirth;

  set user(FirebaseUser newValue) {
    if (_user == newValue)
      return;
    _user = newValue;
    notifyListeners();
  }

  set id(String newValue) {
    if (_id == newValue)
      return;
    _id = newValue;
    notifyListeners();
  }

  set name(String newValue) {
    if (_name == newValue)
      return;
    _name = newValue;
    notifyListeners();
  }

  set height(num newValue) {
    if (_height == newValue)
      return;
    _height = newValue;
    notifyListeners();
  }

  set weight(num newValue) {
    if (_weight == newValue)
      return;
    _weight = newValue;
    notifyListeners();
  }

  set gender(Gender newValue) {
    if (_gender == newValue)
      return;
    _gender = newValue;
    notifyListeners();
  }

  set dateOfBirth(DateTime newValue) {
    if (_dateOfBirth == newValue)
      return;
    _dateOfBirth = newValue;
    notifyListeners();
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
    _dateOfBirth = dateOfBirthNew != null ? DateTime.fromMicrosecondsSinceEpoch(dateOfBirthNew?.microsecondsSinceEpoch) : null;
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
    notifyListeners();
  }

}
