part of settings;

class SettingButton extends SettingWidget {

  final SettingButtonType type;
  final String text;
  final VoidCallback pressed;

  SettingButton(
    this.text,
    this.pressed, {
    Key key,
    this.type,
    SettingWidgetStyle style = DEFAULT_STYLE,
  }) : super(
    Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Container(
              alignment: type.alignment ?? AlignmentDirectional.centerStart,
              child: Text(
                text,
                style: TextStyle(
                  color: type.color ?? style.color ?? Colors.blue,
                  fontSize: style.fontSize ?? SETTING_HEADER_FONT_SIZE,
                )
              ),
            ),
            onPressed: pressed,
          ),
        ),
      ],
    ),
    key: key,
    style: style,
  );

}

class SettingButtonType {
  
  static const SettingButtonType DESTRUCTIVE = SettingButtonType(Colors.red, AlignmentDirectional.center);
  static const SettingButtonType DEFAULT = SettingButtonType(Colors.blue, AlignmentDirectional.centerStart);
  static const SettingButtonType DEFAULT_CENTER = SettingButtonType(Colors.blue, AlignmentDirectional.center);

  final Color color;
  final AlignmentGeometry alignment;

  const SettingButtonType(this.color, this.alignment);
  
}
