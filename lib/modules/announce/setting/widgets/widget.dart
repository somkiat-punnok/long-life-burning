part of settings;

class SettingWidget extends StatelessWidget {

  final Widget widget;
  final AlignmentGeometry alignment;
  final double height;
  final SettingWidgetStyle style;

  SettingWidget(
    this.widget, {
    Key key,
    this.alignment,
    this.height = SETTING_ITEM_HEIGHT,
    this.style = DEFAULT_STYLE,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (style.icon != null) {
      child = Row(
        children: <Widget>[
          Container(
            child: style.icon,
            padding: SETTING_ICON_PADDING,
          ),
          Expanded(
            child: widget,
          ),
        ],
      );
    } else {
      child = widget;
    }
    return Container(
      alignment: alignment,
      height: height,
      padding: SETTING_ITEM_PADDING,
      decoration: BoxDecoration(
        color: style.backgroundColor ?? Colors.white,
        border: Border(
          bottom: BorderSide(
            color: style.color ?? SETTING_BORDER_COLOR,
            width: 1.0,
          ),
        ),
      ),
      child: child,
    );
  }

}

class SettingWidgetStyle {

  final Icon icon;
  final double fontSize;
  final Color color;
  final Color backgroundColor;

  const SettingWidgetStyle({
    this.icon,
    this.fontSize,
    this.color,
    this.backgroundColor,
  });

}
