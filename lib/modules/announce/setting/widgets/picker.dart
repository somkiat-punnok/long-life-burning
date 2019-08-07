part of settings;

class SettingPicker extends StatefulWidget {

  final List<String> items;
  final String title;
  final int currentIndex;
  final SelectionCallback onSelect;

  SettingPicker({
    Key key,
    @required this.items,
    @required this.title,
    this.currentIndex = 0,
    this.onSelect,
  }) :  assert(items != null),
        assert(title != null),
        assert(0 <= currentIndex && currentIndex < items.length),
        super(key: key);

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<SettingPicker> {

  FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: widget.currentIndex);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scrollController = FixedExtentScrollController(initialItem: widget.currentIndex);
    return Container(
      height: SETTING_ITEM_HEIGHT,
      padding: SETTING_ITEM_PADDING,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: SETTING_BORDER_COLOR,
            width: 1.0,
          ),
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async => await showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => _buildBottomPicker(
                  CupertinoPicker(
                    scrollController: scrollController,
                    itemExtent: _kPickerItemHeight,
                    backgroundColor: Colors.white,
                    onSelectedItemChanged: widget.onSelect,
                    children: List<Widget>.generate(widget.items.length, (int index) {
                      return Center(
                        child: Text(widget.items[index]),
                      );
                    }),
                  ),
                  title: widget.title,
                  context: context,
                ),
              ),
              child: _buildMenu(
                <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.items[widget.currentIndex],
                    style: TextStyle(
                      color: CupertinoColors.inactiveGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class SettingCountdownTimerPicker extends StatefulWidget {
  @override
  _CountdownTimerPickerState createState() => _CountdownTimerPickerState();
}

class _CountdownTimerPickerState extends State<SettingCountdownTimerPicker> {

  Duration timer = Duration();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoTimerPicker(
                initialTimerDuration: timer,
                onTimerDurationChanged: (Duration newTimer) {
                  setState(() => timer = newTimer);
                },
              ),
            );
          },
        );
      },
      child: _buildMenu(
        <Widget>[
          const Text('Countdown Timer'),
          Text(
            '${timer.inHours}:'
            '${(timer.inMinutes % 60).toString().padLeft(2,'0')}:'
            '${(timer.inSeconds % 60).toString().padLeft(2,'0')}',
            style: const TextStyle(color: CupertinoColors.inactiveGray),
          ),
        ],
      ),
    );
  }

}

class SettingDatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<SettingDatePicker> {

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: date,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() => date = newDateTime);
                },
              ),
            );
          },
        );
      },
      child: _buildMenu(
        <Widget>[
          const Text('Date'),
          Text(
            DateFormat.yMMMMd().format(date),
            style: const TextStyle(color: CupertinoColors.inactiveGray),
          ),
        ]
      ),
    );
  }

}

class SettingTimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<SettingTimePicker> {

  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: time,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() => time = newDateTime);
                },
              ),
            );
          },
        );
      },
      child: _buildMenu(
        <Widget>[
          const Text('Time'),
          Text(
            DateFormat.jm().format(time),
            style: const TextStyle(color: CupertinoColors.inactiveGray),
          ),
        ],
      ),
    );
  }

}

class SettingDateAndTimePicker extends StatefulWidget {
  @override
  _DateAndTimePickerState createState() => _DateAndTimePickerState();
}

class _DateAndTimePickerState extends State<SettingDateAndTimePicker> {

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: dateTime,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() => dateTime = newDateTime);
                },
              ),
            );
          },
        );
      },
      child: _buildMenu(
        <Widget>[
          const Text('Date and Time'),
          Text(
            DateFormat.yMMMd().add_jm().format(dateTime),
            style: const TextStyle(color: CupertinoColors.inactiveGray),
          ),
        ],
      ),
    );
  }

}

Widget _buildMenu(List<Widget> children) {
  return Container(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    ),
  );
}

Widget _buildBottomPicker(Widget picker, {String title, BuildContext context}) {
  return Container(
    height: _kPickerSheetHeight,
    color: Colors.white,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: DefaultTextStyle(
            style: TextStyle(
              color: CupertinoColors.inactiveGray,
              fontSize: 18.0,
            ),
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(title),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
            ),
            child: GestureDetector(
              onTap: () { },
              child: SafeArea(
                child: picker,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
