part of calendar;

class TableCalendar<T> extends StatefulWidget {

  final CalendarController calendarController;
  final dynamic locale;
  final Map<DateTime, List> events;
  final OnHeader onTitleText;
  final OnHeader onIcon1;
  final OnHeader onIcon2;
  final OnHeader onIcon3;
  final OnDaySelected onDaySelected;
  final VoidCallback onUnavailableDaySelected;
  final OnVisibleDaysChanged onVisibleDaysChanged;
  final DateTime initialSelectedDay;
  final DateTime startDay;
  final DateTime endDay;
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
    this.events,
    this.onDaySelected,
    this.onTitleText,
    this.onIcon1,
    this.onIcon2,
    this.onIcon3,
    this.onUnavailableDaySelected,
    this.onVisibleDaysChanged,
    this.initialSelectedDay,
    this.startDay,
    this.endDay,
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
        super(key: key);

  @override
  _TableCalendarState createState() => _TableCalendarState();

}

class _TableCalendarState<T> extends State<TableCalendar<T>> with SingleTickerProviderStateMixin {

  bool eventHave = false;

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
    eventHave = (widget.events != null && widget.events.isNotEmpty);
  }

  void _selectedDayCallback(DateTime day) {
    if (widget.onDaySelected != null) {
      final key = eventHave
          ? widget.calendarController.visibleEvents.keys.firstWhere((it) => Utils.isSameDay(it, day), orElse: () => null)
          : null;
      widget.onDaySelected(day, eventHave ? widget.calendarController.visibleEvents[key] ?? [] : []);
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

  DateTime _getEventKey(DateTime date) {
    return eventHave ? widget.calendarController.visibleEvents.keys
        .firstWhere((it) => Utils.isSameDay(it, date), orElse: () => null) : null;
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
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        elevation: 0.0,
        centerTitle: true,
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
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        elevation: 0.0,
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
          _CustomIconButton(
            icon: widget.headerStyle.rightIcon3,
            onTap: widget.onIcon3 ?? () => print('on Icon 3'),
            margin: widget.headerStyle.rightMargin3,
            padding: widget.headerStyle.rightPadding3,
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
      children: widget.calendarController._visibleDays.value.take(7).map(
        (date) => Center(
          child: Text(
            widget.daysOfWeekStyle.dowTextBuilder != null
                ? widget.daysOfWeekStyle.dowTextBuilder(date, widget.locale)
                : DateFormat.E(widget.locale).format(date),
            style: widget.calendarController._isWeekend(date)
                ? widget.daysOfWeekStyle.weekendStyle
                : widget.daysOfWeekStyle.weekdayStyle,
          ),
        )
      ).toList(),
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
          ? widget.calendarController.visibleEvents[eventKey].take(widget.calendarStyle.markersMaxAmount)
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
      child: content,
    );
  }

  Widget _buildCellContent(DateTime date) {
    final eventKey = _getEventKey(date);
    final tIsUnavailable = _isDayUnavailable(date);
    final tIsSelected = widget.calendarController.isSelected(date);
    final tIsToday = widget.calendarController.isToday(date);
    final tIsOutside = widget.calendarController._isExtraDay(date);
    final tIsWeekend = widget.calendarController._isWeekend(date);
    final isUnavailable = widget.builders.unavailableDayBuilder != null && tIsUnavailable;
    final isSelected = widget.builders.selectedDayBuilder != null && tIsSelected;
    final isToday = widget.builders.todayDayBuilder != null && tIsToday;
    final isOutsideWeekend = widget.builders.outsideWeekendDayBuilder != null && tIsOutside && tIsWeekend;
    final isOutside = widget.builders.outsideDayBuilder != null && tIsOutside && !tIsWeekend;
    final isWeekend = widget.builders.weekendDayBuilder != null && !tIsOutside && tIsWeekend;
    if (isUnavailable) {
      return widget.builders.unavailableDayBuilder(context, date, eventHave ? widget.events[eventKey] ?? [] : []);
    } else if (isSelected && widget.calendarStyle.renderSelectedFirst) {
      return widget.builders.selectedDayBuilder(context, date, eventHave ? widget.events[eventKey] ?? [] : []);
    } else if (isToday) {
      return widget.builders.todayDayBuilder(context, date, eventHave ? widget.events[eventKey] ?? [] : []);
    } else if (isSelected) {
      return widget.builders.selectedDayBuilder(context, date, eventHave ? widget.events[eventKey] ?? [] : []);
    } else if (isOutsideWeekend) {
      return widget.builders.outsideWeekendDayBuilder(context, date, eventHave ? widget.events[eventKey] ?? [] : []);
    } else if (isOutside) {
      return widget.builders.outsideDayBuilder(context, date, eventHave ? widget.events[eventKey] ?? [] : []);
    } else if (isWeekend) {
      return widget.builders.weekendDayBuilder(context, date, eventHave ? widget.events[eventKey] ?? [] : []);
    } else if (widget.builders.dayBuilder != null) {
      return widget.builders.dayBuilder(context, date, eventHave ? widget.events[eventKey] ?? [] : []);
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
