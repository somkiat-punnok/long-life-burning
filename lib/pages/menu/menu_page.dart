import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          left: 18.0,
          top: 24.0,
          bottom: 18.0,
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
        height: 16.0,
        indent: 16.0,
        endIndent: 16.0,
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
        onPressed: () => print("Logout"),
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
            top: 8.0,
            bottom: 8.0,
            left: 18.0,
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
                      size: 36.0,
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
        height: 8.0,
        indent: 68.0,
        endIndent: 16.0,
        color: Colors.grey,
      ),
    ];
  }

}
