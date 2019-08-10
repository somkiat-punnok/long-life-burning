part of calendar;

class CalendarController {

  DateTime get focusedDay => _focusedDay;
  DateTime get selectedDay => _selectedDay;
  int get pageId => _pageId;
  double get dx => _dx;
  CalendarFormat get calendarFormat => _calendarFormat.value;
  List<DateTime> get visibleDays => _includeInvisibleDays ? _visibleDays.value : _visibleDays.value.where((day) => !_isExtraDay(day)).toList();
  Map<DateTime, List> get visibleEvents => Map.fromEntries(
    _events.entries.where((entry) {
      for (final day in visibleDays) {
        if (Utils.isSameDay(day, entry.key)) {
          return true;
        }
      }
      return false;
    }),
  );

  Map<DateTime, List> _events;
  DateTime _focusedDay;
  DateTime _selectedDay;
  StartingDayOfWeek _startingDayOfWeek;
  ValueNotifier<CalendarFormat> _calendarFormat;
  ValueNotifier<List<DateTime>> _visibleDays;
  Map<CalendarFormat, String> _availableCalendarFormats;
  DateTime _previousFirstDay;
  DateTime _previousLastDay;
  int _pageId;
  double _dx;
  bool _includeInvisibleDays;
  _SelectedDayCallback _selectedDayCallback;

  void _init({
    @required Map<DateTime, List> events,
    @required DateTime initialDay,
    @required CalendarFormat initialFormat,
    @required Map<CalendarFormat, String> availableCalendarFormats,
    @required StartingDayOfWeek startingDayOfWeek,
    @required _SelectedDayCallback selectedDayCallback,
    @required OnVisibleDaysChanged onVisibleDaysChanged,
    @required bool includeInvisibleDays,
  }) {
    _events = events;
    _availableCalendarFormats = availableCalendarFormats;
    _startingDayOfWeek = startingDayOfWeek;
    _selectedDayCallback = selectedDayCallback;
    _includeInvisibleDays = includeInvisibleDays;
    _pageId = 0;
    _dx = 0;
    final now = DateTime.now();
    _focusedDay = initialDay ?? DateTime(now.year, now.month, now.day);
    _selectedDay = _focusedDay;
    _calendarFormat = ValueNotifier(initialFormat);
    _visibleDays = ValueNotifier(_getVisibleDays());
    _previousFirstDay = _visibleDays.value.first;
    _previousLastDay = _visibleDays.value.last;
    _calendarFormat.addListener(() {
      _visibleDays.value = _getVisibleDays();
    });
    if (onVisibleDaysChanged != null) {
      _visibleDays.addListener(() {
        if (!Utils.isSameDay(_visibleDays.value.first, _previousFirstDay) ||
            !Utils.isSameDay(_visibleDays.value.last, _previousLastDay)) {
          _previousFirstDay = _visibleDays.value.first;
          _previousLastDay = _visibleDays.value.last;
          onVisibleDaysChanged(
            _getFirstDay(includeInvisible: _includeInvisibleDays),
            _getLastDay(includeInvisible: _includeInvisibleDays),
            _calendarFormat.value,
          );
        }
      });
    }
  }

  void dispose() {
    _calendarFormat.dispose();
    _visibleDays.dispose();
  }

  void toggleCalendarFormat() {
    _calendarFormat.value = _nextFormat();
  }

  void swipeCalendarFormat({@required bool isSwipeUp}) {
    assert(isSwipeUp != null);
    final formats = _availableCalendarFormats.keys.toList();
    int id = formats.indexOf(_calendarFormat.value);
    if (isSwipeUp) {
      id = _clamp(0, formats.length - 1, id + 1);
    } else {
      id = _clamp(0, formats.length - 1, id - 1);
    }
    _calendarFormat.value = formats[id];
  }

  void setCalendarFormat(CalendarFormat value) {
    _calendarFormat.value = value;
  }

  void setSelectedDay(
    DateTime value, {
    bool isProgrammatic = true,
    bool animate = true,
    bool runCallback = false,
  }) {
    if (animate) {
      if (value.isBefore(_getFirstDay(includeInvisible: false))) {
        _decrementPage();
      } else if (value.isAfter(_getLastDay(includeInvisible: false))) {
        _incrementPage();
      }
    }
    _selectedDay = value;
    _focusedDay = value;
    _updateVisibleDays(isProgrammatic);
    if (isProgrammatic && runCallback && _selectedDayCallback != null) {
      _selectedDayCallback(value);
    }
  }

  void setFocusedDay(DateTime value) {
    _focusedDay = value;
    _updateVisibleDays(true);
  }

  void _updateVisibleDays(bool isProgrammatic) {
    if (calendarFormat == CalendarFormat.month || calendarFormat == CalendarFormat.week || isProgrammatic) {
      _visibleDays.value = _getVisibleDays();
    }
  }

  CalendarFormat _nextFormat() {
    final formats = _availableCalendarFormats.keys.toList();
    int id = formats.indexOf(_calendarFormat.value);
    id = (id + 1) % formats.length;

    return formats[id];
  }

  void _selectPrevious() {
    if (calendarFormat == CalendarFormat.month) {
      _selectPreviousMonth();
    } else {
      _selectPreviousWeek();
    }

    _visibleDays.value = _getVisibleDays();
    _decrementPage();
  }

  void _selectNext() {
    if (calendarFormat == CalendarFormat.month) {
      _selectNextMonth();
    } else {
      _selectNextWeek();
    }

    _visibleDays.value = _getVisibleDays();
    _incrementPage();
  }

  void _selectPreviousMonth() {
    _focusedDay = Utils.previousMonth(_focusedDay);
  }

  void _selectNextMonth() {
    _focusedDay = Utils.nextMonth(_focusedDay);
  }

  void _selectPreviousWeek() {
    _focusedDay = Utils.previousWeek(_focusedDay);
  }

  void _selectNextWeek() {
    _focusedDay = Utils.nextWeek(_focusedDay);
  }

  DateTime _getFirstDay({@required bool includeInvisible}) {
    if (_calendarFormat.value == CalendarFormat.month && !includeInvisible) {
      return _firstDayOfMonth(_focusedDay);
    } else {
      return _visibleDays.value.first;
    }
  }

  DateTime _getLastDay({@required bool includeInvisible}) {
    if (_calendarFormat.value == CalendarFormat.month && !includeInvisible) {
      return _lastDayOfMonth(_focusedDay);
    } else {
      return _visibleDays.value.last;
    }
  }

  List<DateTime> _getVisibleDays() {
    if (calendarFormat == CalendarFormat.month) {
      return _daysInMonth(_focusedDay);
    } else {
      return _daysInWeek(_focusedDay);
    }
  }

  void _decrementPage() {
    _pageId--;
    _dx = _dxMin;
  }

  void _incrementPage() {
    _pageId++;
    _dx = _dxMax;
  }

  List<DateTime> _daysInMonth(DateTime month) {
    final first = _firstDayOfMonth(month);
    final daysBefore = _startingDayOfWeek == StartingDayOfWeek.sunday ? first.weekday % 7 : first.weekday - 1;
    final firstToDisplay = first.subtract(Duration(days: daysBefore));
    final last = _lastDayOfMonth(month);
    var daysAfter = 7 - last.weekday;
    if (_startingDayOfWeek == StartingDayOfWeek.sunday) {
      if (daysAfter == 0) {
        daysAfter = 7;
      }
    } else {
      daysAfter++;
    }
    final lastToDisplay = last.add(Duration(days: daysAfter));
    return Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  List<DateTime> _daysInWeek(DateTime week) {
    final first = _firstDayOfWeek(week);
    final last = _lastDayOfWeek(week);
    return Utils.daysInRange(first, last).toList();
  }

  DateTime _firstDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);
    final decreaseNum = _startingDayOfWeek == StartingDayOfWeek.sunday ? day.weekday % 7 : day.weekday - 1;
    return day.subtract(Duration(days: decreaseNum));
  }

  DateTime _lastDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);
    final increaseNum = _startingDayOfWeek == StartingDayOfWeek.sunday ? day.weekday % 7 : day.weekday - 1;
    return day.add(Duration(days: 7 - increaseNum));
  }

  DateTime _firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1, 12);
  }

  DateTime _lastDayOfMonth(DateTime month) {
    final date = month.month < 12 ? DateTime.utc(month.year, month.month + 1, 1, 12) : DateTime.utc(month.year + 1, 1, 1, 12);
    return date.subtract(const Duration(days: 1));
  }

  bool isSelected(DateTime day) {
    return Utils.isSameDay(day, selectedDay);
  }

  bool isToday(DateTime day) {
    return Utils.isSameDay(day, DateTime.now());
  }

  bool _isWeekend(DateTime day) {
    return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
  }

  bool _isExtraDay(DateTime day) {
    return _isExtraDayBefore(day) || _isExtraDayAfter(day);
  }

  bool _isExtraDayBefore(DateTime day) {
    return day.month < _focusedDay.month;
  }

  bool _isExtraDayAfter(DateTime day) {
    return day.month > _focusedDay.month;
  }

  int _clamp(int min, int max, int value) {
    if (value > max) {
      return max;
    } else if (value < min) {
      return min;
    } else {
      return value;
    }
  }
  
}
