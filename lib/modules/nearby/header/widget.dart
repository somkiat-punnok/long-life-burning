part of header;

/// Stick Header Widget
///
/// Will layout the [header] above the [content] unless the [overlapHeaders] boolean is set to true.
/// The [header] will remain stuck to the top of its parent [Scrollable] content.
///
/// Place this widget inside a [ListView], [GridView], [CustomScrollView], [SingleChildScrollView] or similar.
///
class StickyHeader extends MultiChildRenderObjectWidget {
  /// Constructs a new [StickyHeader] widget.
  StickyHeader({
    Key key,
    @required this.header,
    @required this.content,
    this.overlapHeaders: false,
    this.callback,
  }) : super(
          key: key,
          // Note: The order of the children must be preserved for the RenderObject.
          children: [content, header],
        );

  /// Header to be shown at the top of the parent [Scrollable] content.
  final Widget header;

  /// Content to be shown below the header.
  final Widget content;

  /// If true, the header will overlap the Content.
  final bool overlapHeaders;

  /// Optional callback with stickyness value. If you think you need this, then you might want to
  /// consider using [StickyHeaderBuilder] instead.
  final RenderStickyHeaderCallback callback;

  @override
  RenderStickyHeader createRenderObject(BuildContext context) {
    var scrollable = Scrollable.of(context);
    assert(scrollable != null);
    return new RenderStickyHeader(
      scrollable: scrollable,
      callback: this.callback,
      overlapHeaders: this.overlapHeaders,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderStickyHeader renderObject) {
    renderObject
      ..scrollable = Scrollable.of(context)
      ..callback = this.callback
      ..overlapHeaders = this.overlapHeaders;
  }
}

/// Sticky Header Builder Widget.
///
/// The same as [StickyHeader] but instead of supplying a Header view, you supply a [builder] that
/// constructs the header with the appropriate stickyness.
///
/// Place this widget inside a [ListView], [GridView], [CustomScrollView], [SingleChildScrollView] or similar.
///
class StickyHeaderBuilder extends StatefulWidget {
  /// Constructs a new [StickyHeaderBuilder] widget.
  const StickyHeaderBuilder({
    Key key,
    @required this.builder,
    this.content,
    this.overlapHeaders: false,
  }) : super(key: key);

  /// Called when the sticky amount changes for the header.
  /// This builder must not return null.
  final StickyHeaderWidgetBuilder builder;

  /// Content to be shown below the header.
  final Widget content;

  /// If true, the header will overlap the Content.
  final bool overlapHeaders;

  @override
  _StickyHeaderBuilderState createState() => new _StickyHeaderBuilderState();
}

class _StickyHeaderBuilderState extends State<StickyHeaderBuilder> {
  double _stuckAmount;

  @override
  Widget build(BuildContext context) {
    return new StickyHeader(
      overlapHeaders: widget.overlapHeaders,
      header: new LayoutBuilder(
        builder: (context, _) => widget.builder(context, _stuckAmount ?? 0.0),
      ),
      content: widget.content,
      callback: (double stuckAmount) {
        if (_stuckAmount != stuckAmount) {
          _stuckAmount = stuckAmount;
          WidgetsBinding.instance.endOfFrame.then((_) {
            if(mounted){
              setState(() {});
            }
          });
        }
      },
    );
  }
}
