import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:long_life_burning/constants/constant.dart' show SizeConfig;
import 'package:long_life_burning/modules/stepcount/generic_widgets/radial_position.dart';

class SlidingRadialList extends StatelessWidget {

  final RadialListViewModel radialList;
  final SlidingRadialListController controller;

  SlidingRadialList({
    this.radialList,
    this.controller,
  });

  List<Widget> _radialListItems(double height, double width) {
    int index = 0;
    return radialList.items.map((RadialListItemViewModel viewModel) {
      final listItem = _radialListItem(
        viewModel,
        controller.getItemAngle(index),
        controller.getItemOpacity(index),
        height,
        width,
      );
      ++index;
      return listItem;
    }).toList();
  }

  Widget _radialListItem(RadialListItemViewModel viewModel, double angle, double opacity, double height, double width) {
    return Transform(
      transform: Matrix4.translationValues(
        width / 18.0,
        height / 2.175,
        0.0,
      ),
      child: RadialPosition(
        radius: width / 3 + 75.0,
        angle: angle,
        child: Opacity(
          opacity: opacity,
          child: RadialListItem(
            listItem: viewModel,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Stack(
          children: _radialListItems(
            SizeConfig.screenHeight,
            SizeConfig.screenWidth,
          ),
        );
      },
    );
  }
}

class SlidingRadialListController extends ChangeNotifier {

  final double firstItemAngle = -pi / 5;
  final double lastItemAngle = pi / 5;
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
  }) : _slideController = AnimationController(duration: Duration(milliseconds: 1500), vsync: vsync,),
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

}

enum RadialListState {
  closed,
  slidingOpen,
  open,
  fadingOut,
}

class RadialListItem extends StatelessWidget {

  final RadialListItemViewModel listItem;

  RadialListItem({
    this.listItem,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(-30.0, -30.0, 0.0),
      child: Row(
        children: <Widget>[
          Container(
            height: SizeConfig.setHeight(60.0),
            width: SizeConfig.setWidth(60.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: Colors.white,
                width: SizeConfig.setWidth(1.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.setWidth(8.0)),
              child: Image(
                image: listItem.icon,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.setWidth(5.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  listItem.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: SizeConfig.setWidth(20.0),
                  ),
                ),
                Text(
                  listItem.subtitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: SizeConfig.setWidth(18.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class RadialListViewModel {

  final List<RadialListItemViewModel> items;

  RadialListViewModel({
    this.items = const [],
  });

}

class RadialListItemViewModel {

  final ImageProvider icon;
  final String title;
  final String subtitle;

  RadialListItemViewModel({
    this.icon,
    this.title = '',
    this.subtitle = '',
  });

}