import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;
import 'marking_page.dart';
import 'setting_page.dart';
import 'statistic_page.dart';

class MenuPage extends StatefulWidget {
  static const String routeName = '/';
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          'Menu',
          style: TextStyle(
            color: Colors.black,
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView(
          children: _buildList(context),
        ),
      ),
    );
  }

  List<Widget> _buildList(BuildContext context) {

    List<Widget> list = <Widget>[];

    list.addAll([
      Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.setWidth(18.0),
          top: SizeConfig.setHeight(18.0),
          bottom: SizeConfig.setHeight(18.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'User Name',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'ID: ' + 'username',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      Divider(
        height: SizeConfig.setHeight(16.0),
        indent: SizeConfig.setWidth(16.0),
        endIndent: SizeConfig.setWidth(16.0),
        color: Colors.grey,
      ),
    ]);

    list.addAll(_buildMenu(
      name: 'Statistics',
      icons: Icons.pie_chart_outlined,
      onTap: () async => await Navigator.of(context).pushNamed(StatisticPage.routeName),
    ));

    list.addAll(_buildMenu(
      name: 'Marking',
      icons: Icons.location_on,
      onTap: () async => await Navigator.of(context).pushNamed(MarkingPage.routeName),
    ));

    list.addAll(_buildMenu(
      name: 'Settings',
      icons: Icons.settings,
      onTap: () async => await Navigator.of(context).pushNamed(SettingPage.routeName),
    ));

    list.addAll([
      CupertinoButton(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        child: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              )
            ),
          ),
        ),
        onPressed: () => print(""),//gotologinscreen(context),
      ),
        
    ]);

    return list;

  }

  List<Widget> _buildMenu({@required String name, @required IconData icons, VoidCallback onTap}) {
    return <Widget>[
      CupertinoButton(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        onPressed: onTap ?? () => print(name),
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.setHeight(8.0),
            bottom: SizeConfig.setHeight(8.0),
            left: SizeConfig.setWidth(18.0),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: CircleBorder(side: BorderSide(
                      color: Colors.blue,
                    )),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(
                      icons,
                      size: SizeConfig.setWidth(36.0),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      Divider(
        height: SizeConfig.setHeight(8.0),
        indent: SizeConfig.setWidth(68.0),
        endIndent: SizeConfig.setWidth(16.0),
        color: Colors.grey,
      ),
    ];
  }

}
