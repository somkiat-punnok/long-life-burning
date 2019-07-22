import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/constants/constant.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onChanged,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: isMaterial ? Colors.blue : CupertinoColors.activeBlue,
        unselectedItemColor: isMaterial ? Colors.grey : CupertinoColors.inactiveGray,
        iconSize: SizeConfig.setWidth(24.0),
        items: [
          navBarItem('Home', isMaterial ? IconsAndroid.home : IconsiOS.home),
          navBarItem('Nearby', isMaterial ? IconsAndroid.near_me : IconsiOS.near_me),
          navBarItem('Event', isMaterial ? IconsAndroid.marathon : IconsiOS.marathon),
          navBarItem('Group', isMaterial ? IconsAndroid.group : IconsiOS.group),
          navBarItem('', isMaterial ? IconsAndroid.others : IconsiOS.others),
        ],
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
