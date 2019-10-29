part of providers;

class SettingProvider extends ChangeNotifier {
  String _province = "";
  String _category = "";

  String get province => _province;
  String get category => _category;

  set province(String newValue) {
    if (_province == newValue)
      return;
    _province = newValue;
    notifyListeners();
  }

  set category(String newValue) {
    if (_category == newValue)
      return;
    _category = newValue;
    notifyListeners();
  }

  void reset() {
    _province = "";
    _category = "";
    notifyListeners();
  }
}
