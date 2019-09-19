import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    isMaterial,
    SizeConfig,
    Configs,
    UserOptions;
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
  Index({Key key}) : super(key: key);
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
    navBarItem(kMenu.name, kMenu.icon),
  ];

  @override
  void initState() {
    super.initState();
    Configs.index_context = context;
    if (UserOptions.user == null) {
      checkAuth();
    }
    pageIndex = 0;
  }

  void onChanged(int index) async {
    if(navBarItems.length - 1 == index && !Configs.login) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        )
      );
    }
    else if(pageIndex != index) {
      setState(() {
        pageIndex = index;
      });
    }
    else {
      await nav[pageIndex].navigateKey.currentState.popUntil(ModalRoute.withName('/'));
    }
  }

  void checkAuth() async {
    await Configs.auth.currentUser().then((user) async {
      if (user != null) {
        await Configs.store
          .collection(UserOptions.collection)
          .where(
            UserOptions.uid_field,
            isEqualTo: user.uid,
          )
          .snapshots()
          .listen((data) {
            if (data.documents.isNotEmpty) {
              UserOptions.user = user;
              Configs.setUser(
                n: data.documents[0].data[UserOptions.name_field],
                w: data.documents[0].data[UserOptions.weight_field],
                h: data.documents[0].data[UserOptions.height_field],
                d: data.documents[0].data[UserOptions.dateOfBirth_field],
                g: data.documents[0].data[UserOptions.gender_field],
              );
            }
          });
        Configs.login = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: () async => !await nav[pageIndex].navigateKey.currentState.maybePop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
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
