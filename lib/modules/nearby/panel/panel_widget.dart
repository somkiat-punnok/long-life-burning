part of panel;

class SlidingUpPanel extends StatefulWidget {

  final Widget panel;
  final Widget collapsed;
  final double minHeight;
  final double maxHeight;
  final Border border;
  final BorderRadiusGeometry borderRadius;
  final List<BoxShadow> boxShadow;
  final Color color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool renderPanelSheet;
  final bool panelSnapping;
  final PanelController controller;
  final PanelSlideCallback onPanelSlide;
  final VoidCallback onPanelOpened;
  final VoidCallback onPanelClosed;

  SlidingUpPanel({
    Key key,
    @required this.panel,
    this.collapsed,
    this.minHeight = 100.0,
    this.maxHeight = 500.0,
    this.border,
    this.borderRadius,
    this.boxShadow = const <BoxShadow>[
      BoxShadow(
        blurRadius: 8.0,
        color: Color.fromRGBO(0, 0, 0, 0.25),
      )
    ],
    this.color = Colors.white,
    this.padding,
    this.margin,
    this.renderPanelSheet = true,
    this.panelSnapping = true,
    this.controller,
    this.onPanelSlide,
    this.onPanelOpened,
    this.onPanelClosed,
  }) : super(key: key);

  @override
  _SlidingUpPanelState createState() => _SlidingUpPanelState();
}

class _SlidingUpPanelState extends State<SlidingUpPanel> with SingleTickerProviderStateMixin {

  AnimationController _ac;

  bool _isPanelVisible = true;

  @override
  void initState(){
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener((){
      setState((){});
      if(widget.onPanelSlide != null) widget.onPanelSlide(_ac.value);
      if(widget.onPanelOpened != null && _ac.value == 1.0) widget.onPanelOpened();
      if(widget.onPanelClosed != null && _ac.value == 0.0) widget.onPanelClosed();
    });
    widget.controller?.addListeners(
      _close,
      _open,
      _hide,
      _show,
      _setPanelPosition,
      _animatePanelToPosition,
      _getPanelPosition,
      _isPanelAnimating,
      _isPanelOpen,
      _isPanelClosed,
      _isPanelShown,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(),
        !_isPanelVisible ? Container() : GestureDetector(
          onVerticalDragUpdate: _onDrag,
          onVerticalDragEnd: _onDragEnd,
          child: Container(
            height: _ac.value * (widget.maxHeight - widget.minHeight) + widget.minHeight,
            margin: widget.margin,
            padding: widget.padding,
            decoration: widget.renderPanelSheet ? BoxDecoration(
              border: widget.border,
              borderRadius: widget.borderRadius,
              boxShadow: widget.boxShadow,
              color: widget.color,
            ) : null,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0.0,
                  bottom: null,
                  width:  MediaQuery.of(context).size.width
                          - (widget.margin != null ? widget.margin.horizontal : 0)
                          - (widget.padding != null ? widget.padding.horizontal : 0),
                  child: Container(
                    height: widget.maxHeight,
                    child: widget.panel,
                  )
                ),
                Positioned(
                  top: 0.0,
                  bottom: null,
                  width:  MediaQuery.of(context).size.width
                          - (widget.margin != null ? widget.margin.horizontal : 0)
                          - (widget.padding != null ? widget.padding.horizontal : 0),
                  child: Container(
                    height: widget.minHeight,
                    child: Opacity(
                      opacity: 1.0 - _ac.value,
                      child: IgnorePointer(
                        ignoring: _isPanelOpen(),
                        child: widget.collapsed ?? Container(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose(){
    _ac.dispose();
    super.dispose();
  }

  void _onDrag(DragUpdateDetails details){
    _ac.value -= details.primaryDelta / (widget.maxHeight - widget.minHeight);
  }

  void _onDragEnd(DragEndDetails details){
    double minFlingVelocity = 365.0;
    if (_ac.isAnimating) return;
    if (details.velocity.pixelsPerSecond.dy.abs() >= minFlingVelocity) {
      double visualVelocity = - details.velocity.pixelsPerSecond.dy / (widget.maxHeight - widget.minHeight);
      if (widget.panelSnapping) {
        _ac.fling(velocity: visualVelocity);
      }
      else {
        _ac.animateTo(
          _ac.value + visualVelocity * 0.16,
          duration: Duration(milliseconds: 410),
          curve: Curves.decelerate,
        );
      }
      return;
    }
    if (widget.panelSnapping) {
      if(_ac.value > 0.5)
        _open();
      else
        _close();
    }
  }

  void _close(){
    _ac.fling(velocity: -1.0);
  }

  void _open(){
    _ac.fling(velocity: 1.0);
  }

  void _hide(){
    _ac.fling(velocity: -1.0).then((x){
      setState(() {
        _isPanelVisible = false;
      });
    });
  }

  void _show(){
    _ac.fling(velocity: -1.0).then((x){
      setState(() {
        _isPanelVisible = true;
      });
    });
  }

  void _setPanelPosition(double value){
    assert(0.0 <= value && value <= 1.0);
    _ac.value = value;
  }

  void _animatePanelToPosition(double value){
    assert(0.0 <= value && value <= 1.0);
    _ac.animateTo(value);
  }

  double _getPanelPosition(){
    return _ac.value;
  }

  bool _isPanelAnimating(){
    return _ac.isAnimating;
  }

  bool _isPanelOpen(){
    return _ac.value == 1.0;
  }

  bool _isPanelClosed(){
    return _ac.value == 0.0;
  }

  bool _isPanelShown(){
    return _isPanelVisible;
  }

}
