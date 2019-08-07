part of settings;

class SettingLink extends SettingWidget {

  final String text;
  final VoidCallback pressed;

  SettingLink(
    this.text,
    this.pressed, {
    SettingWidgetStyle style = DEFAULT_STYLE,
  }) : super(
    CupertinoButton(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: style.color ?? SETTING_TEXT_COLOR,
              fontSize: style.fontSize ?? SETTING_HEADER_FONT_SIZE,
            )
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black26,
          ),
        ],
      ),
      onPressed: pressed,
    ),
    style: style,
  );

}
