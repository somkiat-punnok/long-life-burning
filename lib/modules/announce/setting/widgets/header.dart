part of settings;

class SettingHeader extends StatelessWidget {

  final String title;
  final SettingWidgetStyle style;

  SettingHeader(
    this.title, {
    this.style = DEFAULT_STYLE,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        top: 30.0,
        bottom: 5.0,
      ),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: style.color ?? SETTING_HEADER_TEXT_COLOR,
          fontSize: style.fontSize ?? SETTING_HEADER_FONT_SIZE
        ),
      ),
      decoration: BoxDecoration(
        color: style.backgroundColor ?? SETTING_HEADER_COLOR,
        border: Border(
          bottom: BorderSide(
            color: style.color ?? SETTING_BORDER_COLOR,
            width: 1.0,
          ),
        ),
      ),
    );
  }

}
