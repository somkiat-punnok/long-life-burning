import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/widgets/platform_widgets.dart';
import 'package:long_life_burning/constants/icons.dart';
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
    return PlatformScaffold(
      android: (_) => MaterialScaffoldData(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
      ),
      ios: (_) => CupertinoPageScaffoldData(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomInsetTab: true,
      ),
      body: currentPage,
      bottomNavBar: PlatformNavBar(
        currentIndex: pageIndex,
        itemChanged: onChanged,
        android: (_) => MaterialNavBarData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            navBarItem('Home', IconsAndroid.home),
            navBarItem('Nearby', IconsAndroid.near_me),
            navBarItem('Event', IconsAndroid.marathon),
            navBarItem('Group', IconsAndroid.group),
            navBarItem('', IconsAndroid.others),
          ],
        ),
        ios: (_) => CupertinoTabBarData(
          activeColor: CupertinoColors.activeBlue,
          inactiveColor: CupertinoColors.inactiveGray,
          items: [
            navBarItem('Home', IconsiOS.home),
            navBarItem('Nearby', IconsiOS.near_me),
            navBarItem('Event', IconsiOS.marathon),
            navBarItem('Group', IconsiOS.group),
            navBarItem('', IconsiOS.others),
          ],
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
