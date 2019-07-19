import 'package:flutter/material.dart';

typedef void SwipeCallback(SwipeDirection direction);
enum SwipeDirection { left, right, up, down }
class SimpleGestureDetector extends StatefulWidget {

  final Widget child;
  final SimpleSwipeConfig swipeConfig;
  final HitTestBehavior behavior;
  final SwipeCallback onVerticalSwipe;
  final SwipeCallback onHorizontalSwipe;

  const SimpleGestureDetector({
    Key key,
    @required this.child,
    this.swipeConfig = const SimpleSwipeConfig(),
    this.behavior = HitTestBehavior.deferToChild,
    this.onVerticalSwipe,
    this.onHorizontalSwipe,
  })  : assert(child != null),
        assert(swipeConfig != null),
        super(key: key);

  @override
  _SimpleGestureDetectorState createState() => _SimpleGestureDetectorState();

}

class _SimpleGestureDetectorState extends State<SimpleGestureDetector> {

  Offset _initialSwipeOffset;
  Offset _finalSwipeOffset;
  SwipeDirection _previousDirection;

  void _onVerticalDragStart(DragStartDetails details) {
    _initialSwipeOffset = details.globalPosition;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    _finalSwipeOffset = details.globalPosition;

    if (widget.swipeConfig.swipeDetectionBehavior == SwipeDetectionBehavior.singularOnEnd) {
      return;
    }

    if (_initialSwipeOffset != null) {
      final offsetDifference = _initialSwipeOffset.dy - _finalSwipeOffset.dy;

      if (offsetDifference.abs() > widget.swipeConfig.verticalThreshold) {
        _initialSwipeOffset =
            widget.swipeConfig.swipeDetectionBehavior == SwipeDetectionBehavior.singular ? null : _finalSwipeOffset;

        final direction = offsetDifference > 0 ? SwipeDirection.up : SwipeDirection.down;

        if (widget.swipeConfig.swipeDetectionBehavior == SwipeDetectionBehavior.continuous ||
            _previousDirection == null ||
            direction != _previousDirection) {
          _previousDirection = direction;
          widget.onVerticalSwipe(direction);
        }
      }
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (widget.swipeConfig.swipeDetectionBehavior == SwipeDetectionBehavior.singularOnEnd) {
      if (_initialSwipeOffset != null) {
        final offsetDifference = _initialSwipeOffset.dy - _finalSwipeOffset.dy;

        if (offsetDifference.abs() > widget.swipeConfig.verticalThreshold) {
          final direction = offsetDifference > 0 ? SwipeDirection.up : SwipeDirection.down;
          widget.onVerticalSwipe(direction);
        }
      }
    }

    _initialSwipeOffset = null;
    _previousDirection = null;
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    _initialSwipeOffset = details.globalPosition;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _finalSwipeOffset = details.globalPosition;

    if (widget.swipeConfig.swipeDetectionBehavior == SwipeDetectionBehavior.singularOnEnd) {
      return;
    }

    if (_initialSwipeOffset != null) {
      final offsetDifference = _initialSwipeOffset.dx - _finalSwipeOffset.dx;

      if (offsetDifference.abs() > widget.swipeConfig.horizontalThreshold) {
        _initialSwipeOffset =
            widget.swipeConfig.swipeDetectionBehavior == SwipeDetectionBehavior.singular ? null : _finalSwipeOffset;

        final direction = offsetDifference > 0 ? SwipeDirection.left : SwipeDirection.right;

        if (widget.swipeConfig.swipeDetectionBehavior == SwipeDetectionBehavior.continuous ||
            _previousDirection == null ||
            direction != _previousDirection) {
          _previousDirection = direction;
          widget.onHorizontalSwipe(direction);
        }
      }
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (widget.swipeConfig.swipeDetectionBehavior == SwipeDetectionBehavior.singularOnEnd) {
      if (_initialSwipeOffset != null) {
        final offsetDifference = _initialSwipeOffset.dx - _finalSwipeOffset.dx;

        if (offsetDifference.abs() > widget.swipeConfig.horizontalThreshold) {
          final direction = offsetDifference > 0 ? SwipeDirection.left : SwipeDirection.right;
          widget.onHorizontalSwipe(direction);
        }
      }
    }

    _initialSwipeOffset = null;
    _previousDirection = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      child: widget.child,
      onVerticalDragStart: widget.onVerticalSwipe != null ? _onVerticalDragStart : null,
      onVerticalDragUpdate: widget.onVerticalSwipe != null ? _onVerticalDragUpdate : null,
      onVerticalDragEnd: widget.onVerticalSwipe != null ? _onVerticalDragEnd : null,
      onHorizontalDragStart: widget.onHorizontalSwipe != null ? _onHorizontalDragStart : null,
      onHorizontalDragUpdate: widget.onHorizontalSwipe != null ? _onHorizontalDragUpdate : null,
      onHorizontalDragEnd: widget.onHorizontalSwipe != null ? _onHorizontalDragEnd : null,
    );
  }

}

enum SwipeDetectionBehavior {
  singular,
  singularOnEnd,
  continuous,
  continuousDistinct,
}

class SimpleSwipeConfig {

  final double verticalThreshold;
  final double horizontalThreshold;
  final SwipeDetectionBehavior swipeDetectionBehavior;

  const SimpleSwipeConfig({
    this.verticalThreshold = 50.0,
    this.horizontalThreshold = 50.0,
    this.swipeDetectionBehavior = SwipeDetectionBehavior.singularOnEnd,
  })  : assert(verticalThreshold != null),
        assert(horizontalThreshold != null),
        assert(swipeDetectionBehavior != null);
        
}
