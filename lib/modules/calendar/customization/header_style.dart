part of calendar;

class HeaderStyle {

  final bool centerHeaderTitle;
  final TextBuilder titleTextBuilder;
  final TextStyle titleTextStyle;
  final EdgeInsets beforePadding;
  final EdgeInsets nextPadding;
  final EdgeInsets rightPadding1;
  final EdgeInsets rightPadding2;
  final EdgeInsets beforeMargin;
  final EdgeInsets nextMargin;
  final EdgeInsets rightMargin1;
  final EdgeInsets rightMargin2;
  final Icon beforeIcon;
  final Icon nextIcon;
  final Icon rightIcon1;
  final Icon rightIcon2;

  const HeaderStyle({
    this.centerHeaderTitle = false,
    this.titleTextBuilder,
    this.titleTextStyle = const TextStyle(fontSize: 18.0),
    this.beforePadding = const EdgeInsets.all(12.0),
    this.nextPadding = const EdgeInsets.all(12.0),
    this.rightPadding1 = const EdgeInsets.all(8.0),
    this.rightPadding2 = const EdgeInsets.all(8.0),
    this.beforeMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.nextMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.rightMargin1 = const EdgeInsets.symmetric(horizontal: 8.0),
    this.rightMargin2 = const EdgeInsets.symmetric(horizontal: 8.0),
    this.beforeIcon = const Icon(Icons.chevron_left, color: Colors.black),
    this.nextIcon = const Icon(Icons.chevron_right, color: Colors.black),
    this.rightIcon1 = const Icon(Icons.add, color: Colors.black),
    this.rightIcon2 = const Icon(Icons.add, color: Colors.black),
  });

}
