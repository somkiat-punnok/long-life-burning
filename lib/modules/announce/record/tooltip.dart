part of record_events;

class CustomTooltip extends StatefulWidget {
  const CustomTooltip({
    Key key,
    @required this.message,
    this.align = AlignMessage.CENTER,
    this.height,
    this.padding,
    this.margin,
    this.verticalOffset,
    this.preferBelow,
    this.excludeFromSemantics,
    this.decoration,
    this.textStyle,
    this.waitDuration,
    this.showDuration,
    this.child,
  }) : assert(message != null),
       super(key: key);

  final String message;
  final AlignMessage align;
  final double height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double verticalOffset;
  final bool preferBelow;
  final bool excludeFromSemantics;
  final Widget child;
  final Decoration decoration;
  final TextStyle textStyle;
  final Duration waitDuration;
  final Duration showDuration;

  @override
  _CustomTooltipState createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> with SingleTickerProviderStateMixin {
  static const double _defaultTooltipHeight = 32.0;
  static const double _defaultVerticalOffset = 24.0;
  static const bool _defaultPreferBelow = true;
  static const EdgeInsetsGeometry _defaultPadding = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsetsGeometry _defaultMargin = EdgeInsets.all(0.0);
  static const Duration _fadeInDuration = Duration(milliseconds: 150);
  static const Duration _fadeOutDuration = Duration(milliseconds: 75);
  static const Duration _defaultShowDuration = Duration(milliseconds: 1500);
  static const Duration _defaultWaitDuration = Duration(milliseconds: 0);
  static const bool _defaultExcludeFromSemantics = false;

  double height;
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry margin;
  Decoration decoration;
  TextStyle textStyle;
  double verticalOffset;
  bool preferBelow;
  bool excludeFromSemantics;
  AnimationController _controller;
  OverlayEntry _entry;
  Timer _hideTimer;
  Timer _showTimer;
  Duration showDuration;
  Duration waitDuration;
  bool _mouseIsConnected;
  bool _longPressActivated = false;

  @override
  void initState() {
    super.initState();
    _mouseIsConnected = RendererBinding.instance.mouseTracker.mouseIsConnected;
    _controller = AnimationController(
      duration: _fadeInDuration,
      reverseDuration: _fadeOutDuration,
      vsync: this,
    )
      ..addStatusListener(_handleStatusChanged);
    RendererBinding.instance.mouseTracker.addListener(_handleMouseTrackerChange);
    GestureBinding.instance.pointerRouter.addGlobalRoute(_handlePointerEvent);
  }

  void _handleMouseTrackerChange() {
    if (!mounted) {
      return;
    }
    final bool mouseIsConnected = RendererBinding.instance.mouseTracker.mouseIsConnected;
    if (mouseIsConnected != _mouseIsConnected) {
      setState((){
        _mouseIsConnected = mouseIsConnected;
      });
    }
  }

  void _handleStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      _hideTooltip(immediately: true);
    }
  }

  void _hideTooltip({ bool immediately = false }) {
    _showTimer?.cancel();
    _showTimer = null;
    if (immediately) {
      _removeEntry();
      return;
    }
    if (_longPressActivated) {
      _hideTimer ??= Timer(showDuration, _controller.reverse);
    } else {
      _controller.reverse();
    }
    _longPressActivated = false;
  }

  void _showTooltip({ bool immediately = false }) {
    _hideTimer?.cancel();
    _hideTimer = null;
    if (immediately) {
      ensureTooltipVisible();
      return;
    }
    _showTimer ??= Timer(waitDuration, ensureTooltipVisible);
  }

  bool ensureTooltipVisible() {
    _showTimer?.cancel();
    _showTimer = null;
    if (_entry != null) {
      _hideTimer?.cancel();
      _hideTimer = null;
      _controller.forward();
      return false;
    }
    _createNewEntry();
    _controller.forward();
    return true;
  }

  void _createNewEntry() {
    final RenderBox box = context.findRenderObject();
    final Offset target = box.localToGlobal(_buildAlign(box));
    final Widget overlay = _CustomTooltipOverlay(
      message: widget.message,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration,
      textStyle: textStyle,
      animation: CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
    );
    _entry = OverlayEntry(builder: (BuildContext context) => overlay);
    Overlay.of(context, debugRequiredFor: widget).insert(_entry);
    SemanticsService.tooltip(widget.message);
  }

  Offset _buildAlign(RenderBox box) {
    switch (widget.align) {
      case AlignMessage.TOP:
        return box.size.topCenter(Offset.zero);
        break;
      case AlignMessage.TOPLEFT:
        return box.size.topLeft(Offset.zero);
        break;
      case AlignMessage.TOPRIGHT:
        return box.size.topRight(Offset.zero);
        break;
      case AlignMessage.BOTTOM:
        return box.size.bottomCenter(Offset.zero);
        break;
      case AlignMessage.BOTTOMLEFT:
        return box.size.bottomLeft(Offset.zero);
        break;
      case AlignMessage.BOTTOMRIGHT:
        return box.size.bottomRight(Offset.zero);
        break;
      case AlignMessage.CENTER:
        return box.size.center(Offset.zero);
        break;
      case AlignMessage.CENTERLEFT:
        return box.size.centerLeft(Offset.zero);
        break;
      case AlignMessage.CENTERRIGHT:
        return box.size.centerRight(Offset.zero);
        break;
      default:
        return box.size.center(Offset.zero);
    }
  }

  void _removeEntry() {
    _hideTimer?.cancel();
    _hideTimer = null;
    _showTimer?.cancel();
    _showTimer = null;
    _entry?.remove();
    _entry = null;
  }

  void _handlePointerEvent(PointerEvent event) {
    if (_entry == null) {
      return;
    }
    if (event is PointerUpEvent || event is PointerCancelEvent) {
      _hideTooltip();
    } else if (event is PointerDownEvent) {
      _hideTooltip(immediately: true);
    }
  }

  @override
  void deactivate() {
    if (_entry != null) {
      _hideTooltip(immediately: true);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    GestureBinding.instance.pointerRouter.removeGlobalRoute(_handlePointerEvent);
    RendererBinding.instance.mouseTracker.removeListener(_handleMouseTrackerChange);
    if (_entry != null)
      _removeEntry();
    _controller.dispose();
    super.dispose();
  }

  void _handleLongPress() {
    _longPressActivated = true;
    final bool tooltipCreated = ensureTooltipVisible();
    if (tooltipCreated)
      Feedback.forLongPress(context);
  }

  @override
  Widget build(BuildContext context) {
    assert(Overlay.of(context, debugRequiredFor: widget) != null);
    final ThemeData theme = Theme.of(context);
    final TooltipThemeData tooltipTheme = TooltipTheme.of(context);
    TextStyle defaultTextStyle;
    BoxDecoration defaultDecoration;
    if (theme.brightness == Brightness.dark) {
      defaultTextStyle = theme.textTheme.body1.copyWith(
        color: Colors.black,
      );
      defaultDecoration = BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      );
    } else {
      defaultTextStyle = theme.textTheme.body1.copyWith(
        color: Colors.white,
      );
      defaultDecoration = BoxDecoration(
        color: Colors.grey[700].withOpacity(0.9),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      );
    }

    height = widget.height ?? tooltipTheme.height ?? _defaultTooltipHeight;
    padding = widget.padding ?? tooltipTheme.padding ?? _defaultPadding;
    margin = widget.margin ?? tooltipTheme.margin ?? _defaultMargin;
    verticalOffset = widget.verticalOffset ?? tooltipTheme.verticalOffset ?? _defaultVerticalOffset;
    preferBelow = widget.preferBelow ?? tooltipTheme.preferBelow ?? _defaultPreferBelow;
    excludeFromSemantics = widget.excludeFromSemantics ?? tooltipTheme.excludeFromSemantics ?? _defaultExcludeFromSemantics;
    decoration = widget.decoration ?? tooltipTheme.decoration ?? defaultDecoration;
    textStyle = widget.textStyle ?? tooltipTheme.textStyle ?? defaultTextStyle;
    waitDuration = widget.waitDuration ?? tooltipTheme.waitDuration ?? _defaultWaitDuration;
    showDuration = widget.showDuration ?? tooltipTheme.showDuration ?? _defaultShowDuration;

    Widget result = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleLongPress,
      onDoubleTap: _handleLongPress,
      excludeFromSemantics: true,
      child: Semantics(
        label: excludeFromSemantics ? null : widget.message,
        child: widget.child,
      ),
    );

    if (_mouseIsConnected) {
      result = MouseRegion(
        onEnter: (PointerEnterEvent event) => _showTooltip(),
        onExit: (PointerExitEvent event) => _hideTooltip(),
        child: result,
      );
    }

    return result;
  }
}

class _CustomTooltipPositionDelegate extends SingleChildLayoutDelegate {
  _CustomTooltipPositionDelegate({
    @required this.target,
    @required this.verticalOffset,
    @required this.preferBelow,
  }) : assert(target != null),
       assert(verticalOffset != null),
       assert(preferBelow != null);

  final Offset target;
  final double verticalOffset;
  final bool preferBelow;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) => constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
    );
  }

  @override
  bool shouldRelayout(_CustomTooltipPositionDelegate oldDelegate) {
    return target != oldDelegate.target
        || verticalOffset != oldDelegate.verticalOffset
        || preferBelow != oldDelegate.preferBelow;
  }
}

class _CustomTooltipOverlay extends StatelessWidget {
  const _CustomTooltipOverlay({
    Key key,
    this.message,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.textStyle,
    this.animation,
    this.target,
    this.verticalOffset,
    this.preferBelow,
  }) : super(key: key);

  final String message;
  final double height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Decoration decoration;
  final TextStyle textStyle;
  final Animation<double> animation;
  final Offset target;
  final double verticalOffset;
  final bool preferBelow;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomSingleChildLayout(
          delegate: _CustomTooltipPositionDelegate(
            target: target,
            verticalOffset: verticalOffset,
            preferBelow: preferBelow,
          ),
          child: FadeTransition(
            opacity: animation,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: height),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.body1,
                child: Container(
                  decoration: decoration,
                  padding: padding,
                  margin: margin,
                  child: Center(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Text(
                      message,
                      style: textStyle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
