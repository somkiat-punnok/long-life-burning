import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:long_life_burning/screen/login/login_screen.dart' show LoginScreen;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    SizeConfig,
    Configs;
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    UserProvider;

import './check_point_page.dart';
import './setting_page.dart';
import './statistic_page.dart';

class MenuPage extends StatefulWidget {
  MenuPage({ Key key }) : super(key: key);
  static const String routeName = '/';
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Menu',
          style: TextStyle(
            color: Colors.black,
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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
              userProvider.name ?? 'Username',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'ID: ${userProvider.name?.toLowerCase()}',
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
      ),
    ]);
    list.addAll(_buildMenu(
      name: 'Statistics',
      icons: Icons.pie_chart_outlined,
      onTap: () async => await Navigator.of(context).pushNamed(StatisticPage.routeName),
    ));
    list.addAll(_buildMenu(
      name: 'Check Points',
      icons: Icons.location_on,
      onTap: () async => await Navigator.of(context).pushNamed(CheckPointPage.routeName),
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
        onPressed: () async {
          await Configs.auth
            .signOut()
            .then((_) async {
              userProvider.resetUser();
              Configs.login = false;
              await Navigator.of(Configs.index_context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen(),
                )
              );
            });
        },
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
      ),
    ];
  }
}
