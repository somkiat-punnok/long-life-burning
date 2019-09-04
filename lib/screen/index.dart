import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:long_life_burning/utils/helper/constants.dart';
import 'package:long_life_burning/utils/routes/routing.dart'
  show
    nav,
    kStepCount,
    kNearby,
    kEvents,
    kGroups,
    kMenu,
    PageNavigate;

// import './login/login_screen.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

  int pageIndex;
  bool login = false;
  final List<BottomNavigationBarItem> navBarItems = [
    navBarItem(kStepCount.name, kStepCount.icon),
    navBarItem(kNearby.name, kNearby.icon),
    navBarItem(kEvents.name, kEvents.icon),
    navBarItem(kGroups.name, kGroups.icon),
    navBarItem(kMenu.name, kMenu.icon),
  ];

  @override
  void initState() {
    super.initState();
    pageIndex = 0;
  }

  void onChanged (int index) async {
    // if(navBarItems.length - 1 == index && !login) {
    //   await Navigator.of(context).pushReplacementNamed('/login');
    // }
    if(pageIndex != index) {
      setState(() {
        pageIndex = index;
      });
    }
    else {
      await nav[pageIndex].navigateKey.currentState.popUntil(ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // print(SizeConfig.printData());
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
    backgroundColor: Colors.white,
    selectedItemColor: isMaterial ? Colors.blue : CupertinoColors.activeBlue,
    unselectedItemColor: isMaterial ? Colors.grey : CupertinoColors.inactiveGray,
    iconSize: SizeConfig.setSize(24.0),
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
