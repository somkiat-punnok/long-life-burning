import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'size_config.dart';

double _kPickerSheetHeight = SizeConfig.setHeight(216.0);
double _kPickerItemHeight = SizeConfig.setHeight(32.0);

const List<String> coolColorNames = <String>[
  'Sarcoline', 'Coquelicot', 'Smaragdine', 'Mikado', 'Glaucous', 'Wenge',
  'Fulvous', 'Xanadu', 'Falu', 'Eburnean', 'Amaranth', 'Australien',
  'Banan', 'Falu', 'Gingerline', 'Incarnadine', 'Labrador', 'Nattier',
  'Pervenche', 'Sinoper', 'Verditer', 'Watchet', 'Zaffre',
];

class Picker extends StatefulWidget {
  static const String routeName = '/cupertino/picker';

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).brightness == Brightness.light
              ? CupertinoColors.extraLightBackgroundGray
              : CupertinoColors.darkBackgroundGray,
        ),
        child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 32.0)),
            ColorPicker(),
            CountdownTimerPicker(),
            DatePicker(),
            TimePicker(),
            DateAndTimePicker(),
          ],
        ),
      ),
    );
  }

}

Widget _buildMenu(List<Widget> children) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: const Border(
        top: BorderSide(color: Colors.grey, width: 0.0),
        bottom: BorderSide(color: Colors.grey, width: 0.0),
      ),
    ),
    height: 44.0,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    ),
  );
}

Widget _buildBottomPicker(Widget picker) {
  return Container(
    height: _kPickerSheetHeight,
    padding: const EdgeInsets.only(top: 6.0),
    color: Colors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        onTap: () { },
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    ),
  );
}

class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {

  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    final FixedExtentScrollController scrollController = FixedExtentScrollController(initialItem: _selectedColorIndex);
    return GestureDetector(
      onTap: () async {
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoPicker(
                scrollController: scrollController,
                itemExtent: _kPickerItemHeight,
                backgroundColor: CupertinoColors.white,
                onSelectedItemChanged: (int index) {
                  setState(() => _selectedColorIndex = index);
                },
                children: List<Widget>.generate(coolColorNames.length, (int index) {
                  return Center(
                    child: Text(coolColorNames[index]),
                  );
                }),
              ),
            );
          },
        );
      },
      child: _buildMenu(
        <Widget>[
          Text('Favorite Color'),
          Text(
            coolColorNames[_selectedColorIndex],
            style: TextStyle(
                color: CupertinoColors.inactiveGray
            ),
          ),
        ],
      ),
    );
  }
}

class CountdownTimerPicker extends StatefulWidget {
  @override
  _CountdownTimerPickerState createState() => _CountdownTimerPickerState();
}

class _CountdownTimerPickerState extends State<CountdownTimerPicker> {

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

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

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

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {

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

class DateAndTimePicker extends StatefulWidget {
  @override
  _DateAndTimePickerState createState() => _DateAndTimePickerState();
}

class _DateAndTimePickerState extends State<DateAndTimePicker> {

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
