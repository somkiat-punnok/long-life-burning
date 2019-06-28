import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AndroidNavBar extends StatelessWidget {

  AndroidNavBar({
    Key key,
    this.widgetKey,
    this.index = 0,
    this.callback,
    this.items,
  }) : super(key: key);

  final Key widgetKey;
  final int index;
  final ValueChanged<int> callback;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      key: widgetKey,
      color: Colors.white,
      clipBehavior: Clip.none,
      child: BottomNavigationBar(
        items: items,
        currentIndex: index,
        onTap: callback,
        iconSize: 28.0,
        type: BottomNavigationBarType.fixed,
        key: widgetKey,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );

  }

}

class IOSNavBar extends StatelessWidget implements PreferredSizeWidget  {

  IOSNavBar({
    Key key,
    this.widgetKey,
    this.index = 0,
    this.callback,
    this.items,
  }) : super(key: key);

  final Key widgetKey;
  final int index;
  final ValueChanged<int> callback;
  final List<BottomNavigationBarItem> items;

  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {

    return CupertinoTabBar(
      key: widgetKey,
      currentIndex: index,
      onTap: callback,
      items: items,
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
    );

  }

}
