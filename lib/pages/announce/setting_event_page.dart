import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    PROVINCE,
    CATEGORIES;
import 'package:long_life_burning/modules/announce/setting/settings.dart';

class SettingEventPage extends StatefulWidget {
  SettingEventPage({Key key}) : super(key: key);
  static const String routeName = '/setevent';
  @override
  _SettingEventPageState createState() => _SettingEventPageState();
}

class _SettingEventPageState extends State<SettingEventPage> {

  int province = 0;
  int category = 0;
  Duration timer = Duration();
  DateTime date = DateTime.now();
  DateTime time = DateTime.now();
  DateTime datetime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Settings(
        items: <Widget>[
          SettingHeader('performed by'),
          CusttomPicker(
            title: 'Province',
            items: PROVINCE,
            currentIndex: province,
            onSelect: (int i) {
              setState(() {
                province = i;
              });
            },
          ),
          CusttomPicker(
            title: 'Category',
            items: CATEGORIES,
            currentIndex: category,
            onSelect: (int i) {
              setState(() {
                category = i;
              });
            },
          ),
          // SettingHeader(''),
          // TimerPicker(
          //   currentTimer: timer,
          //   onSelect: (Duration t) {
          //     setState(() {
          //       timer = t;
          //     });
          //   },
          // ),
          // DatePicker(
          //   currentDate: date,
          //   onSelect: (DateTime t) {
          //     setState(() {
          //       date = t;
          //     });
          //   },
          // ),
          // TimePicker(
          //   currentTime: time,
          //   onSelect: (DateTime t) {
          //     setState(() {
          //       time = t;
          //     });
          //   },
          // ),
          // DateAndTimePicker(
          //   currentDateAndTime: datetime,
          //   onSelect: (DateTime t) {
          //     setState(() {
          //       datetime = t;
          //     });
          //   },
          // ),
          SettingHeader(''),
          SettingButton(
            "Reset All Settings",
            () => setState(() {
              province = 0;
              category = 0;
            }),
            type: SettingButtonType.DESTRUCTIVE,
          ),
          // SettingHeader(''),
        ],
      ),
    );
  }

}
