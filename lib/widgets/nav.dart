import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:long_life_burning/contents/content.dart';
import 'package:long_life_burning/routes/route.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int _pageIndex = 0;
  Widget currentPage = Routes.pageNavBar[0];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {

    BottomNavigationBarItem navBarItem(String title, IconData icon) {
      return new BottomNavigationBarItem(
        title: Text(title),
        icon: Icon(icon),
      );
    }

    void onChanged (int index) {
      setState(() {
        currentPage = Routes.pageNavBar[index];
        _pageIndex = index;
      });
    }

    var navBar = new PlatformNavBar(
      android: (_) => MaterialNavBarData(
        currentIndex: _pageIndex,
        itemChanged: onChanged,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: [
          navBarItem('', Icons.home),
          navBarItem('', Icons.near_me),
          navBarItem('', IconsAndroid.marathon),
          navBarItem('', Icons.group),
          navBarItem('', Icons.view_headline),
        ],
      ),
      ios: (_) => CupertinoTabBarData(
        currentIndex: _pageIndex,
        itemChanged: onChanged,
        //activeColor: Colors.green,
        //inactiveColor: Colors.orange,
        items: [
          navBarItem('', IconsiOS.home),
          navBarItem('', IconsiOS.near_me),
          navBarItem('', IconsiOS.marathon),
          navBarItem('', CupertinoIcons.group_solid),
          navBarItem('', IconsiOS.view_headline),
        ],
      ),
    );

    return PlatformScaffold(
      body: PageStorage(child: currentPage, bucket: bucket),
      bottomNavBar: navBar,
    );

  }
}
