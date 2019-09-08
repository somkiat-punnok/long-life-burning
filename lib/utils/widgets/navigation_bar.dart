import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {

  final bool reverse;
  final Curve curve;
  final Color activeColor;
  final Color inactiveColor;
  final Color indicatorColor;
  final int initialIndex;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  NavigationBar({
    Key key,
    this.reverse = false,
    this.curve = Curves.linear,
    this.onTap,
    @required this.items,
    this.activeColor,
    this.inactiveColor,
    this.indicatorColor,
    this.initialIndex = 0,
    this.currentIndex = 0,
  })  : assert(items != null),
        assert(items.length >= 2),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(
          items.every((BottomNavigationBarItem item) => item.icon != null) == true,
          'Every item must have a non-null icon',
        ),
        super(key: key);

  @override
  State createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> with SingleTickerProviderStateMixin {
  static const double BAR_HEIGHT = 60;
  static const double INDICATOR_HEIGHT = 2;

  bool get reverse => widget.reverse;

  Curve get curve => widget.curve;

  List<BottomNavigationBarItem> get items => widget.items;

  double width = 0;
  Color activeColor;
  Duration duration = Duration(milliseconds: 270);

  @override
  void initState() {
    _select(widget.currentIndex);
    super.initState();
  }

  double _getIndicatorPosition(int index) => (-1 + (2 / (items.length - 1) * index));

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    activeColor = widget.activeColor ?? Theme.of(context).indicatorColor;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: BAR_HEIGHT,
          width: width,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: INDICATOR_HEIGHT,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: items.map((item) {
                    var index = items.indexOf(item);
                    return GestureDetector(
                      onTap: () => _select(index),
                      child: _buildItemWidget(item, index == widget.currentIndex),
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                top: 0,
                width: width,
                child: AnimatedAlign(
                  alignment: Alignment(_getIndicatorPosition(widget.currentIndex), 0),
                  curve: curve,
                  duration: duration,
                  child: Container(
                    color: widget.indicatorColor ?? activeColor,
                    width: width / items.length,
                    height: INDICATOR_HEIGHT,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _select(int index) {
    widget.onTap(index);
    setState(() {});
  }

  Widget _buildIcon(BottomNavigationBarItem item) {
    return item.icon;
    // Icon(
    //   item.icon,
    //   color: reverse ? widget.inactiveColor : activeColor,
    // );
  }

  Widget _buildText(BottomNavigationBarItem item) {
    return item.title;
    // Text(
    //   item.title,
    //   style: TextStyle(color: reverse ? activeColor : widget.inactiveColor),
    // );
  }

  Widget _buildItemWidget(BottomNavigationBarItem item, bool isSelected) {
    return Container(
      color: item.backgroundColor,
      height: BAR_HEIGHT,
      width: width / items.length,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          AnimatedOpacity(
            opacity: isSelected ? 0.0 : 1.0,
            duration: duration,
            curve: curve,
            child: reverse ? _buildIcon(item) : _buildText(item),
          ),
          AnimatedAlign(
            duration: duration,
            alignment: isSelected ? Alignment.center : Alignment(0, 5.2),
            child: reverse ? _buildText(item) : _buildIcon(item),
          ),
        ],
      ),
    );
  }
}