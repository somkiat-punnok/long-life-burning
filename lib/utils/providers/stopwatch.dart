part of providers;

class StopWatchProvider extends ChangeNotifier {

  Timer _timer;
  DateTime _startTime;
  num _second, _minute, _hour;

  StopWatchProvider() {
    reset();
  }

  num get hour => _hour;
  num get minute => _minute;
  num get second => _second;
  DateTime get startTime => _startTime;

  void reset() {
    _hour = 0;
    _minute = 0;
    _second = 0;
    _startTime = null;
    _timer = null;
    notifyListeners();
  }

  void start() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), _handleTick);
    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    notifyListeners();
  }

  void _handleTick(Timer t) {
    final Duration _elapsed = _startTime.difference(DateTime.now()).abs();
    _second = (_elapsed.inSeconds - (_elapsed.inMinutes * 60)).abs();
    _minute = (_elapsed.inMinutes - (_elapsed.inHours * 60)).abs();
    _hour = (_elapsed.inHours - (_elapsed.inDays * 24)).abs();
    notifyListeners();
  }
}
