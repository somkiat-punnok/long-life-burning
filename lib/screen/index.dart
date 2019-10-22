import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    isMaterial,
    SizeConfig,
    Configs,
    checkAuth;
import 'package:long_life_burning/utils/routes/routing.dart'
  show
    nav,
    kStepCount,
    kNearby,
    kEvents,
    kGroups,
    kNotify,
    kMenu,
    PageNavigate;
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    NavBarProvider,
    UserProvider;

import './login/login_screen.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

  NavBarProvider provider;
  List<BottomNavigationBarItem> navBarItems;

  @override
  void initState() {
    super.initState();
    Configs.index_context = context;
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final FirebaseUser user = Provider.of<FirebaseUser>(context);
    check(userProvider, user);
    provider = Provider.of<NavBarProvider>(context);
    SizeConfig.init(context);
    navBarItems = [
      navBarItem(kStepCount.name, kStepCount.icon),
      navBarItem(kNearby.name, kNearby.icon),
      navBarItem(kEvents.name, kEvents.icon),
      navBarItem(kGroups.name, kGroups.icon),
      navBarItem(kNotify.name, kNotify.icon),
      navBarItem(kMenu.name, kMenu.icon),
    ];
    return WillPopScope(
      onWillPop: () async => !await nav[provider.value].navigateKey.currentState.maybePop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: _buildPageBody(),
        bottomNavigationBar: _buildNavBar(),
      ),
    );
  }

  void check(UserProvider userProvider, FirebaseUser user) async {
    if (userProvider.user == null && !Configs.login) {
      await checkAuth(userProvider, user);
    }
  }

  Widget _buildPageBody() => Stack(
    children: List<Widget>.generate(navBarItems.length, (int i) => _buildOffstageNavigate(i)),
  );

  Widget _buildNavBar() => BottomNavigationBar(
    currentIndex: provider.value,
    onTap: onChanged,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Colors.white,
    selectedItemColor: isMaterial ? Colors.blue : CupertinoColors.activeBlue,
    unselectedItemColor: isMaterial ? Colors.grey : CupertinoColors.inactiveGray,
    items: navBarItems,
  );

  BottomNavigationBarItem navBarItem(String title, IconData icon) => BottomNavigationBarItem(
    title: Text(title),
    icon: Icon(icon),
  );

  Widget _buildOffstageNavigate(int index) => Offstage(
    offstage: provider.value != index,
    child: PageNavigate(
      index: index,
    ),
  );

  void onChanged(int index) async {
    if (navBarItems.length - 1 == index && !Configs.login) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        )
      );
      return;
    } else if (provider.value != index) {
      provider.value = index;
      return;
    } else {
      await nav[provider.value].navigateKey.currentState.popUntil(ModalRoute.withName('/'));
      return;
    }
  }

}
