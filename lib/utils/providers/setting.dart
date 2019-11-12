part of providers;

class SettingProvider extends ChangeNotifier {
  String _province = "";
  String _category = "";

  SettingProvider() {
    init();
  }

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

  void init() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    _province = _pref.getString("${Prefix_KEY}province") ?? "";
    _category = _pref.getString("${Prefix_KEY}category") ?? "";
    notifyListeners();
  }
}
