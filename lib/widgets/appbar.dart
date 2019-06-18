import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AndroidAppBar extends StatelessWidget implements PreferredSizeWidget {

  AndroidAppBar({
    Key key,
    this.widgetKey,
    this.title,
    this.backgroundColor,
    this.leading,
    this.actions,
    this.bottom,
    this.brightness,
    this.centerTitle,
    this.flexibleSpace,
    this.iconTheme,
    this.textTheme,
    this.actionsIconTheme,
    this.shape
  }) :  preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  final Key widgetKey;
  final Widget title;
  final Color backgroundColor;
  final Widget leading;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;
  final Brightness brightness;
  final bool centerTitle;
  final Widget flexibleSpace;
  final IconThemeData iconTheme;
  final TextTheme textTheme;
  final IconThemeData actionsIconTheme;
  final ShapeBorder shape;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {

    return AppBar(
      key: widgetKey,
      title: title,
      backgroundColor: backgroundColor,
      bottom: bottom,
      actions: actions,
      automaticallyImplyLeading: true,
      bottomOpacity: 1.0,
      brightness: brightness,
      centerTitle: centerTitle,
      elevation: 4.0,
      flexibleSpace: flexibleSpace,
      iconTheme: iconTheme,
      leading: leading,
      primary: true,
      textTheme: textTheme,
      titleSpacing: NavigationToolbar.kMiddleSpacing,
      toolbarOpacity: 1.0,
      actionsIconTheme: actionsIconTheme,
      shape: shape,
    );

  }

}

class IOSAppBar extends StatelessWidget implements ObstructingPreferredSizeWidget {

  IOSAppBar({
    Key key,
    this.widgetKey,
    this.title,
    this.backgroundColor,
    this.leading,
    this.previousPageTitle,
    this.padding,
    this.trailing,
    this.actionsForegroundColor,
    this.heroTag
  }) : super(key: key);

  final Key widgetKey;
  final Widget title;
  final Color backgroundColor;
  final Widget leading;
  final Widget trailing;
  final Color actionsForegroundColor;
  final Object heroTag;
  final String previousPageTitle;
  final EdgeInsetsDirectional padding;

  @override
  bool get fullObstruction => backgroundColor == null ? null : backgroundColor.alpha == 0xFF;

  @override
  Size get preferredSize {
    return const Size.fromHeight(44.0);
  }

  @override
  Widget build(BuildContext context) {

    if (heroTag != null) {
      return CupertinoNavigationBar(
        key: widgetKey,
        middle: title,
        backgroundColor: backgroundColor,
        actionsForegroundColor: actionsForegroundColor,
        automaticallyImplyLeading: true,
        automaticallyImplyMiddle: true,
        previousPageTitle: previousPageTitle,
        padding: padding,
        border: Border(
          bottom: BorderSide(
            color: Color(0x4C000000),
            width: 0.0,
            style: BorderStyle.solid,
          ),
        ),
        leading: leading,
        trailing: trailing,
        transitionBetweenRoutes: true,
        heroTag: heroTag,
      );
    }

    return CupertinoNavigationBar(
      key: widgetKey,
      middle: title,
      backgroundColor: backgroundColor,
      actionsForegroundColor: actionsForegroundColor,
      automaticallyImplyLeading: true,
      automaticallyImplyMiddle: true,
      previousPageTitle: previousPageTitle,
      padding: padding,
      border: Border(
        bottom: BorderSide(
          color: Color(0x4C000000),
          width: 0.0,
          style: BorderStyle.solid,
        ),
      ),
      leading: leading,
      trailing: trailing,
      transitionBetweenRoutes: true,
    );

  }

}
