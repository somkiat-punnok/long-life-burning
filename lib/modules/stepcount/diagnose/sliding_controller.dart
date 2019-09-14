part of diagnose;

class SlidingRadialListController extends ChangeNotifier {

  final double firstItemAngle = -pi / SizeConfig.setWidth(5);
  final double lastItemAngle = pi / SizeConfig.setWidth(5);
  final double startSlidingAngle = 3 * pi / 4;

  final int itemCount;
  final AnimationController _slideController;
  final AnimationController _fadeController;
  final List<Animation<double>> _slidePositions;

  RadialListState _state = RadialListState.closed;
  Completer<Null> onOpenedCompleter;
  Completer<Null> onClosedCompleter;

  SlidingRadialListController({
    this.itemCount,
    vsync,
  }) :  _slideController = AnimationController(duration: Duration(milliseconds: 1500), vsync: vsync,),
        _fadeController = AnimationController(duration: Duration(milliseconds: 150), vsync: vsync,),
        _slidePositions = [] {
          _slideController
            ..addListener(() => notifyListeners())
            ..addStatusListener((AnimationStatus status) {
              switch (status) {
                case AnimationStatus.forward:
                  _state = RadialListState.slidingOpen;
                  notifyListeners();
                  break;
                case AnimationStatus.completed:
                  _state = RadialListState.open;
                  notifyListeners();
                  onOpenedCompleter.complete();
                  break;
                case AnimationStatus.reverse:
                case AnimationStatus.dismissed:
                  break;
              }
            });
          _fadeController
            ..addListener(() => notifyListeners())
            ..addStatusListener((AnimationStatus status) {
              switch (status) {
                case AnimationStatus.forward:
                  _state = RadialListState.fadingOut;
                  notifyListeners();
                  break;
                case AnimationStatus.completed:
                  _state = RadialListState.closed;
                  _slideController.value = 0.0;
                  _fadeController.value = 0.0;
                  notifyListeners();
                  onClosedCompleter.complete();
                  break;
                case AnimationStatus.reverse:
                case AnimationStatus.dismissed:
                  break;
              }
            });
          final delayInterval = 0.1;
          final slideInterval = 0.5;
          final angleDeltaPerItem = (lastItemAngle - firstItemAngle) / (itemCount - 1);
          for (var i = 0; i < itemCount; ++i) {
            final start = delayInterval * i;
            final end = start + slideInterval;
            final endSlidingAngle = firstItemAngle + (angleDeltaPerItem * i);
            _slidePositions.add(
              Tween(
                begin: startSlidingAngle,
                end: endSlidingAngle,
              ).animate(
                CurvedAnimation(
                  parent: _slideController,
                  curve: Interval(start, end, curve: Curves.easeInOut),
                )
              )
            );
          }
        }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  double getItemAngle(int index) {
    return _slidePositions[index].value;
  }

  double getItemOpacity(int index) {
    switch (_state) {
      case RadialListState.closed:
        return 0.0;
      case RadialListState.slidingOpen:
      case RadialListState.open:
        return 1.0;
      case RadialListState.fadingOut:
        return (1.0 - _fadeController.value);
      default:
        return 1.0;
    }
  }

  Future<Null> open() {
    if (_state == RadialListState.closed) {
      _slideController.forward();
      onOpenedCompleter = Completer();
      return onOpenedCompleter.future;
    }
    return null;
  }

  Future<Null> close() {
    if (_state == RadialListState.open) {
      _fadeController.forward();
      onClosedCompleter = Completer();
      return onClosedCompleter.future;
    }
    return null;
  }

  Future<Null> reopen() {
    _slideController.reset();
    _slideController.forward();
    onOpenedCompleter = Completer();
    return onOpenedCompleter.future;
  }

}
