import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/utils/constants.dart';
import 'package:long_life_burning/utils/routes/r.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

  int pageIndex;
  final List<BottomNavigationBarItem> navBarItems = [
    navBarItem(kStepCount.name, kStepCount.icon),
    navBarItem(kNearby.name, kNearby.icon),
    navBarItem(kEvents.name, kEvents.icon),
    navBarItem(kGroups.name, kGroups.icon),
    navBarItem(kOthers.name, kOthers.icon),
  ];

  @override
  void initState() {
    super.initState();
    pageIndex = 0;
  }

  void onChanged (int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await nav[pageIndex].navigateKey.currentState.maybePop(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        body: _buildPageBody(),
        bottomNavigationBar: _buildNavBar(),
      ),
    );
  }

  Widget _buildPageBody() => Stack(
    children: List<Widget>.generate(navBarItems.length, (int i) => _buildOffstageNavigate(i)),
  );

  Widget _buildNavBar() => BottomNavigationBar(
    currentIndex: pageIndex,
    onTap: onChanged,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: isMaterial ? Colors.blue : CupertinoColors.activeBlue,
    unselectedItemColor: isMaterial ? Colors.grey : CupertinoColors.inactiveGray,
    iconSize: SizeConfig.setWidth(24.0),
    items: navBarItems,
  );

  Widget _buildOffstageNavigate(int index) {
    return Offstage(
      offstage: pageIndex != index,
      child: PageNavigate(
        index: index,
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
