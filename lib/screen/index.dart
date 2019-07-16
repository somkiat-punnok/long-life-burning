import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/constants/icons.dart';
import 'package:long_life_burning/constants/platform.dart';
import 'package:long_life_burning/routes/route.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

  int pageIndex = 0;
  Widget currentPage = Routes.pageNavBar[0];

  void onChanged (int index) {
    setState(() {
      currentPage = Routes.pageNavBar[index];
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if ( Platforms.isIOS ) {
      return CupertinoTabScaffold(
        resizeToAvoidBottomInset: true,
        tabBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onChanged,
          items: [
            navBarItem('', IconsiOS.home),
            navBarItem('', IconsiOS.near_me),
            navBarItem('', IconsiOS.marathon),
            navBarItem('', IconsiOS.group),
            navBarItem('', IconsiOS.others),
          ],
          activeColor: CupertinoColors.activeBlue,
          inactiveColor: CupertinoColors.inactiveGray,
          backgroundColor: CupertinoColors.lightBackgroundGray,
          iconSize: 30.0,
          border: Border(
            top: BorderSide(
              color: Color(0x4C000000),
              width: 0.0, // One physical pixel.
              style: BorderStyle.solid,
            ),
          ),
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoPageScaffold(
            child: currentPage,
            resizeToAvoidBottomInset: true,
          );
        },
      );
    }
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: currentPage,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        clipBehavior: Clip.none,
        child: BottomNavigationBar(
          items: [
            navBarItem('', IconsAndroid.home),
            navBarItem('', IconsAndroid.near_me),
            navBarItem('', IconsAndroid.marathon),
            navBarItem('', IconsAndroid.group),
            navBarItem('', IconsAndroid.others),
          ],
          currentIndex: pageIndex,
          onTap: onChanged,
          iconSize: 28.0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }

}

BottomNavigationBarItem navBarItem(String title, IconData icon) {
  return BottomNavigationBarItem(
    title: Text(title),
    icon: Icon(icon),
  );
}
