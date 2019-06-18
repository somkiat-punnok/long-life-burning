import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class AndroidScaffold extends StatelessWidget {

  AndroidScaffold({
    Key key,
    this.widgetKey,
    this.body,
    this.backgroundColor,
    this.appBar,
    this.navBar,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);

  final Key widgetKey;
  final Widget body;
  final Color backgroundColor;
  final PreferredSizeWidget appBar;
  final Widget navBar;
  final Widget drawer;
  final Widget endDrawer;
  final Widget floatingActionButton;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final List<Widget> persistentFooterButtons;
  final Widget bottomSheet;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: widgetKey,
      backgroundColor: backgroundColor,
      body: body,
      appBar: appBar,
      bottomNavigationBar: navBar,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      floatingActionButtonLocation: floatingActionButtonLocation,
      persistentFooterButtons: persistentFooterButtons,
      primary: true,
      resizeToAvoidBottomPadding: true,
      bottomSheet: bottomSheet,
      drawerDragStartBehavior: DragStartBehavior.start,
      extendBody: false,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );

  }

}

class IOSScaffold extends StatelessWidget {

  IOSScaffold({
    Key key,
    this.widgetKey,
    this.body,
    this.backgroundColor,
    this.backgroundColorTab,
    this.appBar,
    this.navBar,
  }) : super(key: key);

  final Key widgetKey;
  final Widget body;
  final Color backgroundColor;
  final Color backgroundColorTab;
  final Widget appBar;
  final Widget navBar;

  @override
  Widget build(BuildContext context) {

    if (navBar != null) {
      return CupertinoTabScaffold(
        key: widgetKey,
        backgroundColor: backgroundColorTab,
        resizeToAvoidBottomInset: true,
        tabBar: navBar,
        tabBuilder: (BuildContext context, int index) {
          return CupertinoPageScaffold(
            backgroundColor: backgroundColor,
            child: body,
            navigationBar: appBar,
            resizeToAvoidBottomInset: true,
          );
        },
      );
    }

    return CupertinoPageScaffold(
      key: widgetKey,
      backgroundColor: backgroundColor,
      child: body,
      navigationBar: appBar,
      resizeToAvoidBottomInset: true,
    );

  }

}


