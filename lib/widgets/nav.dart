import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:long_life_burning/routes/route.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int _pageIndex = 0;
  Widget currentPage = Routes.page[0];
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
        _pageIndex = index;
        currentPage = Routes.page[index];
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
          navBarItem('', Icons.memory),
          navBarItem('', Icons.group),
          navBarItem('', Icons.view_headline),
        ],
      ),
      ios: (_) => CupertinoTabBarData(
        currentIndex: _pageIndex,
        itemChanged: onChanged,
        activeColor: Colors.blue,
        inactiveColor: Colors.black54,
        border: Border(
          top: BorderSide(
            color: Colors.blue,
            width: 1.0, // One physical pixel.
            style: BorderStyle.solid,
          ),
        ),
        items: [
          navBarItem('', CupertinoIcons.book),
          navBarItem('', CupertinoIcons.book),
          navBarItem('', CupertinoIcons.book),
          navBarItem('', CupertinoIcons.group_solid),
          navBarItem('', CupertinoIcons.profile_circled),
        ],
      ),
    );

    return PlatformScaffold(
      body: PageStorage(child: currentPage, bucket: bucket),
      bottomNavBar: navBar,
    );

  }
}
