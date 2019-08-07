import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/utils/constants.dart' show Constants;
import 'package:long_life_burning/modules/announce/setting/settings.dart';

class SettingPage extends StatefulWidget {
  static const String routeName = '/setting';
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  int province = 0;
  int category = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: 18.0,
                  color: CupertinoColors.activeBlue,
                ),
              ),
            ),
          ),
        ],
        elevation: 1.0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: Settings(
        items: <Widget>[
          SettingHeader('performed by'),
          SettingPicker(
            title: 'Province',
            items: Constants.province,
            currentIndex: province,
            onSelect: (int i) {
              setState(() {
                province = i;
              });
            },
          ),
          SettingPicker(
            title: 'Category',
            items: Constants.categories,
            currentIndex: category,
            onSelect: (int i) {
              setState(() {
                category = i;
              });
            },
          ),
          SettingHeader(''),
          SettingButton(
            "Reset All Settings",
            () => setState(() {
              province = 0;
              category = 0;
            }),
            type: SettingButtonType.DESTRUCTIVE,
          ),
          SettingHeader(''),
        ],
      ),
    );
  }

}