import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    PROVINCE,
    CATEGORIES;
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    SettingProvider;
import 'package:long_life_burning/modules/announce/setting/settings.dart';

class SettingEventPage extends StatefulWidget {
  SettingEventPage({ Key key }) : super(key: key);
  static const String routeName = '/setevent';
  @override
  _SettingEventPageState createState() => _SettingEventPageState();
}

class _SettingEventPageState extends State<SettingEventPage> {

  SettingProvider _setting;
  int _province;
  int _category;
  bool _temp;

  @override
  void initState() {
    super.initState();
    _province = 0;
    _category = 0;
    _temp = true;
  }

  @override
  Widget build(BuildContext context) {
    _setting = Provider.of<SettingProvider>(context);
    if (_temp) {
      _province = PROVINCE.indexOf(_setting.province);
      _category = CATEGORIES.indexOf(_setting.category);
      if (_province < 0) _province = 0;
      if (_category < 0) _category = 0;
      _temp = false;
    }
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
            onTap: () async {
              _setting.province = PROVINCE[_province];
              _setting.category = CATEGORIES[_category];
              await Navigator.of(context).maybePop();
            },
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
          SettingHeader('filter by'),
          CusttomPicker(
            title: 'Province',
            items: PROVINCE,
            currentIndex: _province,
            onSelect: (int i) {
              setState(() {
                _province = i;
              });
            },
          ),
          CusttomPicker(
            title: 'Category',
            items: CATEGORIES,
            currentIndex: _category,
            onSelect: (int i) {
              setState(() {
                _category = i;
              });
            },
          ),
          SettingHeader(''),
          SettingButton(
            "Reset All Settings",
            () => setState(() {
              _province = 0;
              _category = 0;
            }),
            type: SettingButtonType.DESTRUCTIVE,
          ),
        ],
      ),
    );
  }

}
