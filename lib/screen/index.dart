import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/constants/icons.dart';
import 'package:long_life_burning/constants/platform.dart';
import 'package:long_life_burning/routes/route.dart';
import 'package:long_life_burning/widgets/nav.dart';
import 'package:long_life_burning/widgets/scaffold.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

  int _pageIndex = 0;
  Widget currentPage = Routes.pageNavBar[0];
  final PageStorageBucket bucket = PageStorageBucket();

  void onChanged (int index) {
    setState(() {
      currentPage = Routes.pageNavBar[index];
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget navBar;

    if ( Platforms.isIOS ) {
      navBar = new IOSNavBar(
        index: _pageIndex,
        callback: onChanged,
        items: [
          navBarItem('', IconsiOS.home),
          navBarItem('', IconsiOS.near_me),
          navBarItem('', IconsiOS.marathon),
          navBarItem('', IconsiOS.group),
          navBarItem('', IconsiOS.others),
        ],
      );

      return IOSScaffold(
        body: PageStorage(child: currentPage, bucket: bucket),
        navBar: navBar,
      );
    }

    navBar = new AndroidNavBar(
      index: _pageIndex,
      callback: onChanged,
      items: [
        navBarItem('', IconsAndroid.home),
        navBarItem('', IconsAndroid.near_me),
        navBarItem('', IconsAndroid.marathon),
        navBarItem('', IconsAndroid.group),
        navBarItem('', IconsAndroid.others),
      ],
    );

    return AndroidScaffold(
      body: PageStorage(child: currentPage, bucket: bucket),
      navBar: navBar,
    );

  }

}

BottomNavigationBarItem navBarItem(String title, IconData icon) {
  return new BottomNavigationBarItem(
    title: Text(title),
    icon: Icon(icon),
  );
}
