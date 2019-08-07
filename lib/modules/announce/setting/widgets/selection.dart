part of settings;

class SettingSelection extends StatefulWidget {
  final List<String> items;
  final SelectionCallback onSelected;
  final int currentSelect;
  final SettingWidgetStyle style;

  SettingSelection(
    this.items,
    this.onSelected, {
    this.currentSelect = 0,
    this.style = DEFAULT_STYLE,
  });

  @override
  SettingSelectionState createState() => SettingSelectionState();
}

class SettingSelectionState extends State<SettingSelection> {

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = <Widget>[];
    for (int i = 0; i < widget.items.length; i++) {
      widgets.add(createItem(context, widget.items[i], i));
    }
    return Column(
      children: widgets,
    );
  }

  Widget createItem(BuildContext context, String name, int index) {
    return SettingWidget(
      CupertinoButton(
        onPressed: () {
          if (index != widget.currentSelect) {
            setState(() {});
            widget.onSelected(index);
          }
        },
        pressedOpacity: 1.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: widget.style.color ?? SETTING_TEXT_COLOR,
                  fontSize: widget.style.fontSize ?? SETTING_HEADER_FONT_SIZE,
                ),
              ),
            ),
            Icon(
              Icons.check,
              color: (index == widget.currentSelect
                  ? widget.style.color ?? SETTING_CHECK_COLOR
                  : Colors.transparent),
              size: SETTING_CHECK_SIZE,
            ),
          ],
        )
      )
    );
  }
}
