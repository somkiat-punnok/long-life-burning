part of calendar;

class TableCalendar extends StatefulWidget {

  final CalendarController calendarController;
  final dynamic locale;
  final Map<DateTime, List> events;
  final OnHeader onTitleText;
  final OnHeader onIcon1;
  final OnHeader onIcon2;
  final OnDaySelected onDaySelected;
  final VoidCallback onUnavailableDaySelected;
  final OnVisibleDaysChanged onVisibleDaysChanged;
  final DateTime initialSelectedDay;
  final DateTime startDay;
  final DateTime endDay;
  final List<int> weekendDays;
  final CalendarFormat initialCalendarFormat;
  final Map<CalendarFormat, String> availableCalendarFormats;
  final bool headerVisible;
  final bool markerVisible;
  final double rowHeight;
  final StartingDayOfWeek startingDayOfWeek;
  final HitTestBehavior dayHitTestBehavior;
  final AvailableGestures availableGestures;
  final SimpleSwipeConfig simpleSwipeConfig;
  final CalendarStyle calendarStyle;
  final DaysOfWeekStyle daysOfWeekStyle;
  final HeaderStyle headerStyle;
  final CalendarBuilders builders;

  TableCalendar({
    Key key,
    @required this.calendarController,
    this.locale,
    this.events = const {},
    this.onDaySelected,
    this.onTitleText,
    this.onIcon1,
    this.onIcon2,
    this.onUnavailableDaySelected,
    this.onVisibleDaysChanged,
    this.initialSelectedDay,
    this.startDay,
    this.endDay,
    this.weekendDays = const [DateTime.saturday, DateTime.sunday],
    this.initialCalendarFormat = CalendarFormat.month,
    this.availableCalendarFormats = const {
      CalendarFormat.month: 'Month',
      CalendarFormat.week: 'Week',
    },
    this.headerVisible = true,
    this.markerVisible = true,
    this.rowHeight,
    this.startingDayOfWeek = StartingDayOfWeek.sunday,
    this.dayHitTestBehavior = HitTestBehavior.deferToChild,
    this.availableGestures = AvailableGestures.all,
    this.simpleSwipeConfig = const SimpleSwipeConfig(
      verticalThreshold: 25.0,
      swipeDetectionBehavior: SwipeDetectionBehavior.continuousDistinct,
    ),
    this.calendarStyle = const CalendarStyle(),
    this.daysOfWeekStyle = const DaysOfWeekStyle(),
    this.headerStyle = const HeaderStyle(),
    this.builders = const CalendarBuilders(),
  })  : assert(calendarController != null),
        assert(availableCalendarFormats.keys.contains(initialCalendarFormat)),
        assert(availableCalendarFormats.length <= CalendarFormat.values.length),
        assert(weekendDays != null),
        assert(weekendDays.isNotEmpty
            ? weekendDays.every((day) => day >= DateTime.monday && day <= DateTime.sunday)
            : true),
        super(key: key);

  @override
  _TableCalendarState createState() => _TableCalendarState();

}

class _TableCalendarState extends State<TableCalendar> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    widget.calendarController._init(
      events: widget.events,
      initialDay: widget.initialSelectedDay,
      initialFormat: widget.initialCalendarFormat,
      availableCalendarFormats: widget.availableCalendarFormats,
      startingDayOfWeek: widget.startingDayOfWeek,
      selectedDayCallback: _selectedDayCallback,
      onVisibleDaysChanged: widget.onVisibleDaysChanged,
      includeInvisibleDays: widget.calendarStyle.outsideDaysVisible,
    );
  }

  @override
  void didUpdateWidget(TableCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.events != widget.events) {
      widget.calendarController._events = widget.events;
    }
  }

  void _selectedDayCallback(DateTime day) {
    if (widget.onDaySelected != null) {
      widget.onDaySelected(day, widget.calendarController.visibleEvents[_getEventKey(day)] ?? []);
    }
  }

  void _selectPrevious() {
    setState(() {
      widget.calendarController._selectPrevious();
    });
  }

  void _selectNext() {
    setState(() {
      widget.calendarController._selectNext();
    });
  }

  void _selectDay(DateTime day) {
    setState(() {
      widget.calendarController.setSelectedDay(day, isProgrammatic: false);
      _selectedDayCallback(day);
    });
  }

  void _onHorizontalSwipe(DismissDirection direction) {
    if (direction == DismissDirection.startToEnd) {
      _selectPrevious();
    } else {
      _selectNext();
    }
  }

  void _onUnavailableDaySelected() {
    if (widget.onUnavailableDaySelected != null) {
      widget.onUnavailableDaySelected();
    }
  }

  bool _isDayUnavailable(DateTime day) {
    return (widget.startDay != null && day.isBefore(widget.startDay)) ||
        (widget.endDay != null && day.isAfter(widget.endDay));
  }

  DateTime _getEventKey(DateTime day) {
    return widget.calendarController._getEventKey(day);
  }

  @override
  Widget build(BuildContext context) {

    final children = <Widget>[];

    if (widget.headerVisible) {
      children.addAll([
        _buildHeader(),
      ]);
    }

    children.addAll([
      SizedBox(height: SizeConfig.setWidth(15.0),),
      _buildCalendarContent(),
    ]);

    return ClipRect(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );

  }

  Widget _buildHeader() {
    return widget.headerStyle.centerHeaderTitle
      ? AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        leading: _CustomIconButton(
          icon: widget.headerStyle.beforeIcon,
          onTap: _selectPrevious,
          margin: widget.headerStyle.beforeMargin,
          padding: widget.headerStyle.beforePadding,
        ),
        title: FlatButton(
          onPressed: widget.onTitleText,
          padding: EdgeInsets.zero,
          child: Text(
            widget.headerStyle.titleTextBuilder != null
                ? widget.headerStyle.titleTextBuilder(widget.calendarController.focusedDay, widget.locale)
                : DateFormat.yMMMM(widget.locale).format(widget.calendarController.focusedDay),
            style: widget.headerStyle.titleTextStyle,
          ),
        ),
        actions: <Widget>[
          _CustomIconButton(
            icon: widget.headerStyle.nextIcon,
            onTap: _selectNext,
            margin: widget.headerStyle.nextMargin,
            padding: widget.headerStyle.nextPadding,
          ),
        ],
      )
      : AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        title: FlatButton(
          onPressed: widget.onTitleText,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: widget.headerStyle.titleTextStyle.fontSize,
              ),
              Text(
                widget.headerStyle.titleTextBuilder != null
                    ? widget.headerStyle.titleTextBuilder(widget.calendarController.focusedDay, widget.locale)
                    : DateFormat.yMMMM(widget.locale).format(widget.calendarController.focusedDay),
                style: widget.headerStyle.titleTextStyle,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          _CustomIconButton(
            icon: widget.headerStyle.rightIcon1,
            onTap: widget.onIcon1 ?? () => print('on Icon 1'),
            margin: widget.headerStyle.rightMargin1,
            padding: widget.headerStyle.rightPadding1,
          ),
          _CustomIconButton(
            icon: widget.headerStyle.rightIcon2,
            onTap: widget.onIcon2 ?? () => print('on Icon 2'),
            margin: widget.headerStyle.rightMargin2,
            padding: widget.headerStyle.rightPadding2,
          ),
          SizedBox(width: SizeConfig.setWidth(10.0),),
        ],
      );
  }

  Widget _buildCalendarContent() {
    return AnimatedSize(
      duration: Duration(milliseconds: widget.calendarController.calendarFormat == CalendarFormat.month ? 330 : 220),
      curve: Curves.fastOutSlowIn,
      alignment: Alignment(0, -1),
      vsync: this,
      child: _buildWrapper(),
    );
  }

  Widget _buildWrapper({Key key}) {
    Widget wrappedChild = _buildTable();
    switch (widget.availableGestures) {
      case AvailableGestures.all:
        wrappedChild = _buildVerticalSwipeWrapper(
          child: _buildHorizontalSwipeWrapper(
            child: wrappedChild,
          ),
        );
        break;
      case AvailableGestures.verticalSwipe:
        wrappedChild = _buildVerticalSwipeWrapper(
          child: wrappedChild,
        );
        break;
      case AvailableGestures.horizontalSwipe:
        wrappedChild = _buildHorizontalSwipeWrapper(
          child: wrappedChild,
        );
        break;
      case AvailableGestures.none:
        break;
    }
    return Container(
      key: key,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: wrappedChild,
    );
  }

  Widget _buildVerticalSwipeWrapper({Widget child}) {
    return SimpleGestureDetector(
      child: child,
      onVerticalSwipe: (direction) {
        setState(() {
          widget.calendarController.swipeCalendarFormat(isSwipeUp: direction == SwipeDirection.up);
        });
      },
      swipeConfig: widget.simpleSwipeConfig,
    );
  }

  Widget _buildHorizontalSwipeWrapper({Widget child}) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 350),
      switchInCurve: Curves.decelerate,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(widget.calendarController.dx, 0), end: Offset(0, 0)).animate(animation),
          child: child,
        );
      },
      layoutBuilder: (currentChild, _) => currentChild,
      child: Dismissible(
        key: ValueKey(widget.calendarController.pageId),
        resizeDuration: null,
        onDismissed: _onHorizontalSwipe,
        direction: DismissDirection.horizontal,
        child: child,
      ),
    );
  }

  Widget _buildTable() {
    final daysInWeek = 7;
    final children = <TableRow>[
      _buildDaysOfWeek(),
    ];
    int x = 0;
    while (x < widget.calendarController._visibleDays.value.length) {
      children.add(_buildTableRow(widget.calendarController._visibleDays.value.skip(x).take(daysInWeek).toList()));
      x += daysInWeek;
    }
    return Table(
      defaultColumnWidth: FractionColumnWidth(1.0 / daysInWeek),
      children: children,
    );
  }

  TableRow _buildDaysOfWeek() {
    return TableRow(
      children: widget.calendarController._visibleDays.value.take(7).map((date) {
        final weekdayString = widget.daysOfWeekStyle.dowTextBuilder != null
            ? widget.daysOfWeekStyle.dowTextBuilder(date, widget.locale)
            : DateFormat.E(widget.locale).format(date);
        final isWeekend = widget.calendarController._isWeekend(date, widget.weekendDays);
        if (isWeekend && widget.builders.dowWeekendBuilder != null) {
          return widget.builders.dowWeekendBuilder(context, weekdayString);
        }
        if (widget.builders.dowWeekdayBuilder != null) {
          return widget.builders.dowWeekdayBuilder(context, weekdayString);
        }
        return Center(
          child: Text(
            weekdayString,
            style: isWeekend
                ? widget.daysOfWeekStyle.weekendStyle
                : widget.daysOfWeekStyle.weekdayStyle,
          ),
        );
      }).toList(),
    );
  }

  TableRow _buildTableRow(List<DateTime> days) {
    return TableRow(children: days.map((date) => _buildTableCell(date)).toList());
  }

  Widget _buildTableCell(DateTime date) {
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.rowHeight ?? constraints.maxWidth,
          minHeight: widget.rowHeight ?? constraints.maxWidth,
        ),
        child: _buildCell(date),
      ),
    );
  }

  Widget _buildCell(DateTime date) {
    if (!widget.calendarStyle.outsideDaysVisible &&
        widget.calendarController._isExtraDay(date) &&
        widget.calendarController.calendarFormat == CalendarFormat.month) {
      return Container();
    }
    Widget content = _buildCellContent(date);
    final eventKey = _getEventKey(date);
    if (eventKey != null) {
      final children = <Widget>[content];
      final events = eventKey != null
          ? widget.calendarController.visibleEvents[eventKey]
          : [];
      if (!_isDayUnavailable(date) && widget.markerVisible) {
        if (widget.builders.markersBuilder != null) {
          children.addAll(
            widget.builders.markersBuilder(
              context,
              eventKey,
              events.toList(),
            ),
          );
        } else {
          children.add(
            Positioned(
              bottom: 5.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: events.map((event) => _buildMarker(eventKey, event)).toList(),
              ),
            ),
          );
        }
      }
      if (children.length > 1) {
        content = Stack(
          alignment: widget.calendarStyle.markersAlignment,
          children: children,
          overflow: widget.calendarStyle.canEventMarkersOverflow ? Overflow.visible : Overflow.clip,
        );
      }
    }
    return GestureDetector(
      behavior: widget.dayHitTestBehavior,
      onTap: () => _isDayUnavailable(date) ? _onUnavailableDaySelected() : _selectDay(date),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: content,
      ),
    );
  }

  Widget _buildCellContent(DateTime date) {
    final eventKey = _getEventKey(date);
    final tIsUnavailable = _isDayUnavailable(date);
    final tIsSelected = widget.calendarController.isSelected(date);
    final tIsToday = widget.calendarController.isToday(date);
    final tIsOutside = widget.calendarController._isExtraDay(date);
    final tIsWeekend = widget.calendarController._isWeekend(date, widget.weekendDays);
    final isUnavailable = widget.builders.unavailableDayBuilder != null && tIsUnavailable;
    final isSelected = widget.builders.selectedDayBuilder != null && tIsSelected;
    final isToday = widget.builders.todayDayBuilder != null && tIsToday;
    final isOutsideWeekend = widget.builders.outsideWeekendDayBuilder != null && tIsOutside && tIsWeekend;
    final isOutside = widget.builders.outsideDayBuilder != null && tIsOutside && !tIsWeekend;
    final isWeekend = widget.builders.weekendDayBuilder != null && !tIsOutside && tIsWeekend;
    if (isUnavailable) {
      return widget.builders.unavailableDayBuilder(context, date, eventKey != null ? (widget.events[eventKey] ?? []) : null);
    } else if (isSelected && widget.calendarStyle.renderSelectedFirst) {
      return widget.builders.selectedDayBuilder(context, date, eventKey != null ? (widget.events[eventKey] ?? []) : null);
    } else if (isToday) {
      return widget.builders.todayDayBuilder(context, date, eventKey != null ? (widget.events[eventKey] ?? []) : null);
    } else if (isSelected) {
      return widget.builders.selectedDayBuilder(context, date, eventKey != null ? (widget.events[eventKey] ?? []) : null);
    } else if (isOutsideWeekend) {
      return widget.builders.outsideWeekendDayBuilder(context, date, eventKey != null ? (widget.events[eventKey] ?? []) : null);
    } else if (isOutside) {
      return widget.builders.outsideDayBuilder(context, date, eventKey != null ? (widget.events[eventKey] ?? []) : null);
    } else if (isWeekend) {
      return widget.builders.weekendDayBuilder(context, date, eventKey != null ? (widget.events[eventKey] ?? []) : null);
    } else if (widget.builders.dayBuilder != null) {
      return widget.builders.dayBuilder(context, date, eventKey != null ? (widget.events[eventKey] ?? []) : null);
    } else {
      return _CellWidget(
        text: '${date.day}',
        isUnavailable: tIsUnavailable,
        isSelected: tIsSelected,
        isToday: tIsToday,
        isWeekend: tIsWeekend,
        isOutsideMonth: tIsOutside,
        calendarStyle: widget.calendarStyle,
      );
    }
  }

  Widget _buildMarker(DateTime date, dynamic event) {
    return Container(
      width: 5.0,
      height: 5.0,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.calendarStyle.markersColor,
      ),
    );
  }

}
