import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:firebase_auth/firebase_auth.dart';
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

import './login/login_screen.dart';

class Index extends StatefulWidget {
  
  Index({
     Key key,
     this.user,
  }) : super(key: key);

  final FirebaseUser user;

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
    if (widget.user != null) {
      if (widget.user.uid.isNotEmpty) {
        login = true;
      }
    }
  }

  void onChanged (int index) async {
    if(navBarItems.length - 1 == index && !login) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        )
      );
    }
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
