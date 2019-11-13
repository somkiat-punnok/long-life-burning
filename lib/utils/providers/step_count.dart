part of providers;

class StepCountProvider extends ChangeNotifier {

  StreamSubscription _subscription;
  num _currentStep, _previousStep;
  LocationData _currentLocate, _previousLocate;
  DateTime _currentTime, _previousTime;
  List<num> _pace;
  num _calories, _distences;
  String _avgPace;
  RecordState _state;

  StepCountProvider({
    @required this.user,
  }) {
    reset();
  }

  final UserProvider user;

  num get calories => _calories;
  num get distences => _distences / 1000.0;
  String get avgPace => _avgPace;
  RecordState get state => _state;

  void reset() {
    _pace?.clear();
    _pace = <num>[];
    _calories = 0.0;
    _distences = 0.0;
    _avgPace = "00:00";
    _currentTime = DateTime.now();
    _previousTime = DateTime.now();
    _currentStep = 0;
    _previousStep = 0;
    _currentLocate = null;
    _previousLocate = null;
    _subscription = null;
    _state = RecordState.INIT;
    notifyListeners();
  }

  void startListening() async {
    final Pedometer _pedometer = new Pedometer();
    final Location _location = new Location();
    reset();
    if (await _location.serviceEnabled()) {
      bool _permission = await _location.hasPermission();
      if (!_permission) {
        await _location.requestPermission();
        _permission = await _location.hasPermission();
      }
      if (_permission) {
        final LocationData _locate = await _location.getLocation();
        _currentLocate = _locate;
        _previousLocate = _locate;
        _subscription = _location.onLocationChanged().listen(_onDataLocate,
            onError: _onErrorLocate, onDone: _onDoneLocate, cancelOnError: true);
      } else {
        _subscription = _pedometer.pedometerStream.listen(_onData,
            onError: _onError, onDone: _onDone, cancelOnError: true);
      }
    } else {
      _subscription = _pedometer.pedometerStream.listen(_onData,
          onError: _onError, onDone: _onDone, cancelOnError: true);
    }
    _state = RecordState.START;
    notifyListeners();
  }

  void stopListening() async {
    _state = RecordState.STOP;
    await _subscription?.cancel();
    notifyListeners();
  }

  void _onData(int steps) async {
    _currentStep = steps;
    _currentTime = DateTime.now();
    final num _stepNow = (_currentStep - _previousStep).abs();
    if (_stepNow > 0) {
      num _temp = 0.0, _second = 0, _minute = 0, _hour = 0;
      final Duration _elapsed = _currentTime.difference(_previousTime).abs();
      _calories += calculateCalories(
        height: user?.height ?? kHeight,
        weight: user?.weight ?? kWeight,
        age: user?.dateOfBirth ?? kDateOfBirth,
        gender: user?.gender ?? Gender.MALE,
        seconds: _elapsed.inSeconds,
        steps: _stepNow,
      );
      _distences = (steps * calculateStepToMeters(175, Gender.MALE));
      _pace.add(_elapsed.inSeconds / (calculateDistanceInKm(_stepNow, calculateStepToMeters(175, Gender.MALE))));
      _pace.forEach((value) => _temp += value);
      _temp /= _pace.length;
      _second = _temp.round() % 60;
      _minute = (_temp ~/ 60) % 60;
      _hour = _temp ~/ (60 * 60);
      _avgPace = _hour <= 0
          ? "${_minute.toStringAsFixed(0).padLeft(2, "0")}:${_second.toStringAsFixed(0).padLeft(2, "0")}"
          : "${_hour.toStringAsFixed(0).padLeft(2, "0")}:${_minute.toStringAsFixed(0).padLeft(2, "0")}:${_second.toStringAsFixed(0).padLeft(2, "0")}";
      notifyListeners();
    }
    _previousTime = _currentTime;
    _previousStep = _currentStep;
  }

  void _onDone() => print("Finished pedometer tracking");
  void _onError(err) => print("Flutter Pedometer Error: $err");

  void _onDataLocate(LocationData locate) async {
    _currentLocate = locate;
    _currentTime = DateTime.now();
    final Geolocator _locator = new Geolocator();
    final num _distenceBetween = await _locator.distanceBetween(
      _previousLocate?.latitude,
      _previousLocate?.longitude,
      _currentLocate?.latitude,
      _currentLocate?.longitude
    );
    if (_distenceBetween > 0) {
      num _temp = 0.0, _second = 0, _minute = 0, _hour = 0;
      final Duration _elapsed = _currentTime.difference(_previousTime).abs();
      _distences += _distenceBetween.abs();
      _calories += calculateCaloriesWithDistance(
        height: user?.height ?? kHeight,
        weight: user?.weight ?? kWeight,
        age: user?.dateOfBirth ?? kDateOfBirth,
        gender: user?.gender ?? Gender.MALE,
        seconds: _elapsed.inSeconds,
        distance: (_distenceBetween.abs() / 1000.0),
      );
      _pace.add(_elapsed.inSeconds / (_distenceBetween.abs() / 1000.0));
      _pace.forEach((value) => _temp += value);
      _temp /= _pace.length;
      _second = _temp.round() % 60;
      _minute = (_temp ~/ 60) % 60;
      _hour = _temp ~/ (60 * 60);
      _avgPace = _hour <= 0
          ? "${_minute.toStringAsFixed(0).padLeft(2, "0")}:${_second.toStringAsFixed(0).padLeft(2, "0")}"
          : "${_hour.toStringAsFixed(0).padLeft(2, "0")}:${_minute.toStringAsFixed(0).padLeft(2, "0")}:${_second.toStringAsFixed(0).padLeft(2, "0")}";
      notifyListeners();
    }
    _previousLocate = _currentLocate;
    _previousTime = _currentTime;
  }

  void _onDoneLocate() => print("Finished pedometer tracking");
  void _onErrorLocate(err) => print("Flutter Location Error: $err");
}

class StepToDayProvider extends ChangeNotifier {

  StreamSubscription _subscription;
  SharedPreferences _pref;
  num _currentStep, _previousStep;
  DateTime _currentTime, _previousTime;
  num _steps, _calories, _distences;
  num _stepOld, _distenceOld, _caloriesOld;

  StepToDayProvider({
    @required this.user,
  }) {
    startListening();
  }

  final UserProvider user;

  num get steps => _steps;
  num get calories => _calories;
  num get distences => _distences;

  void startListening() async {
    final Pedometer _pedometer = new Pedometer();
    final DateTime _now = DateTime.now();
    _pref = await SharedPreferences.getInstance();
    _stepOld = _pref?.getInt("$Prefix_KEY${_now.year}-${_now.month}-${_now.day}_steps") ?? 0;
    _distenceOld = _pref?.getDouble("$Prefix_KEY${_now.year}-${_now.month}-${_now.day}_distences") ?? 0.0;
    _caloriesOld = _pref?.getDouble("$Prefix_KEY${_now.year}-${_now.month}-${_now.day}_calories") ?? 0.0;
    _steps = _stepOld ?? 0;
    _distences = _distenceOld ?? 0.0;
    _calories = _caloriesOld ?? 0.0;
    _currentStep = _steps ?? 0;
    _previousStep = _steps ?? 0;
    _currentTime = DateTime.now();
    _previousTime = DateTime.now();
    _subscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
    notifyListeners();
  }

  void stopListening() async {
    await _subscription?.cancel();
  }

  void _onData(int steps) async {
    _steps = _stepOld + steps;
    _currentStep = _steps;
    _currentTime = DateTime.now();
    final num _stepNow = (_currentStep - _previousStep).abs();
    if (_stepNow > 0) {
      final Duration _elapsed = _currentTime.difference(_previousTime).abs();
      _calories += calculateCalories(
        height: user?.height ?? kHeight,
        weight: user?.weight ?? kWeight,
        age: user?.dateOfBirth ?? kDateOfBirth,
        gender: user?.gender ?? Gender.MALE,
        seconds: _elapsed.inSeconds,
        steps: _stepNow,
      );
      _distences = _distenceOld + calculateDistanceInKm(steps, calculateStepToMeters(175, Gender.MALE));
      await _pref?.setInt("$Prefix_KEY${_currentTime.year}-${_currentTime.month}-${_currentTime.day}_steps", _steps ?? 0);
      await _pref?.setDouble("$Prefix_KEY${_currentTime.year}-${_currentTime.month}-${_currentTime.day}_distences", _distences ?? 0.0);
      await _pref?.setDouble("$Prefix_KEY${_currentTime.year}-${_currentTime.month}-${_currentTime.day}_calories", _calories ?? 0.0);
      notifyListeners();
    }
    _previousTime = _currentTime;
    _previousStep = _currentStep;
  }

  void _onDone() => print("Finished pedometer tracking");
  void _onError(err) => print("Flutter Pedometer Error: $err");
}
