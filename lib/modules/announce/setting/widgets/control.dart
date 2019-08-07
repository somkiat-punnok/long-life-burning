part of settings;

class SettingControl extends SettingWidget {

  final String name;
  final Widget content;

  SettingControl(
    this.name,
    this.content, {
    Key key,
    SettingWidgetStyle style = DEFAULT_STYLE,
  }) : super(
    _ControlWidget(
      key: key,
      style: style,
      content: content,
      name: name,
    ),
    key: key,
    style: style,
  );
}

class _ControlWidget extends StatelessWidget {

  final String name;
  final Widget content;
  final SettingWidgetStyle style;

  _ControlWidget({
    Key key,
    this.style,
    this.content,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            color: style.color ?? SETTING_TEXT_COLOR,
            fontSize: style.fontSize ?? SETTING_HEADER_FONT_SIZE,
          )
        ),
        content,
      ],
    );
  }

}
