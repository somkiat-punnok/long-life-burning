part of providers;

class StepDataProvider extends ChangeNotifier {

  StepDataProvider();

  num _step = 0;
  num _distence = 0;
  num _second = 0;

  num get step => _step;
  num get distence => _distence;
  num get second => _second;

  set step(num newValue) {
    if (_step == newValue)
      return;
    _step = newValue;
    notifyListeners();
  }

  set distence(num newValue) {
    if (_distence == newValue)
      return;
    _distence = newValue;
    notifyListeners();
  }

  set second(num newValue) {
    if (_second == newValue)
      return;
    _second = newValue;
    notifyListeners();
  }

  Future<void> readDate(DateTime date) async {
    final DateTime now = DateTime.now();
    if ((date.year <= now.year) && (date.month <= now.month) && (date.day <= now.day)) {
      try {
        if (!Configs.fitkit_permissions) {
          await FitKit
            .requestPermissions(DataType.values)
            .then(
              (result) => Configs.fitkit_permissions = result
            );
          await readDate(date);
        } else {
          _step = 0;
          _distence = 0;
          _second = 0;
          final bool dateNow = Utils.isSameDay(date, now);
          for (DataType type in DataType.values) {
            if (type == DataType.STEP_COUNT) {
              await FitKit.read(
                type,
                dateNow
                  ? DateTime.now().subtract(Duration(days: 1))
                  : date,
                dateNow
                  ? DateTime.now()
                  : date.add(Duration(days: 1))
              )
              .then((data) {
                if (data != null && data.isNotEmpty) {
                  data.forEach((value) {
                    if (value.dateFrom.day == date.day && value.dateTo.day == date.day) {
                      if (value.value != 0) {
                        _step += value.value.round() ?? 0;
                        _second += ((value.dateTo.millisecondsSinceEpoch - value.dateFrom.millisecondsSinceEpoch) / 1000.0);
                      }
                    }
                  });
                  notifyListeners();
                }
              });
            }
            else if (type == DataType.DISTANCE) {
              await FitKit.read(
                type,
                dateNow
                  ? DateTime.now().subtract(Duration(days: 1))
                  : date,
                dateNow
                  ? DateTime.now()
                  : date.add(Duration(days: 1))
              )
              .then((data) {
                if (data != null && data.isNotEmpty) {
                  data.forEach((value) {
                    if (value.dateFrom.day == date.day && value.dateTo.day == date.day) {
                      if (value.value != 0) {
                        _distence += value.value.round() ?? 0;
                      }
                    }
                  });
                  notifyListeners();
                }
              });
            }
          }
        }
      } catch (e) {
        print('Failed to read all values. $e');
        _step = 0;
        _distence = 0;
        _second = 0;
        notifyListeners();
      }
    }
    else {
      _step = 0;
      _distence = 0;
      _second = 0;
      notifyListeners();
    }
  }

}