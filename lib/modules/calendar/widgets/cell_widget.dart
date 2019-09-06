part of calendar;

class _CellWidget extends StatelessWidget {

  final String text;
  final bool isUnavailable;
  final bool isSelected;
  final bool isToday;
  final bool isWeekend;
  final bool isOutsideMonth;
  final CalendarStyle calendarStyle;

  const _CellWidget({
    Key key,
    @required this.text,
    @required this.calendarStyle,
    this.isUnavailable = false,
    this.isSelected = false,
    this.isToday = false,
    this.isWeekend = false,
    this.isOutsideMonth = false,
  })  : assert(text != null),
        assert(calendarStyle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      decoration: _buildCellDecoration(),
      margin: EdgeInsets.all(6.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: _buildCellTextStyle(),
      ),
    );
  }

  Decoration _buildCellDecoration() {
    if (isSelected && calendarStyle.renderSelectedFirst) {
      return BoxDecoration(
        shape: BoxShape.circle,
        color: calendarStyle.selectedColor,
      );
    } else if (isToday) {
      return BoxDecoration(
        shape: BoxShape.circle,
        color: calendarStyle.todayColor,
      );
    } else if (isSelected) {
      return BoxDecoration(
        shape: BoxShape.circle,
        color: calendarStyle.selectedColor,
      );
    } else {
      return BoxDecoration(
        shape: BoxShape.circle,
      );
    }
  }

  TextStyle _buildCellTextStyle() {
    if (isUnavailable) {
      return calendarStyle.unavailableStyle;
    } else if (isSelected && calendarStyle.renderSelectedFirst) {
      return calendarStyle.selectedStyle;
    } else if (isToday) {
      return calendarStyle.todayStyle;
    } else if (isSelected) {
      return calendarStyle.selectedStyle;
    } else if (isOutsideMonth && isWeekend) {
      return calendarStyle.outsideWeekendStyle;
    } else if (isOutsideMonth) {
      return calendarStyle.outsideStyle;
    } else if (isWeekend) {
      return calendarStyle.weekendStyle;
    } else {
      return calendarStyle.weekdayStyle;
    }
  }
  
}
