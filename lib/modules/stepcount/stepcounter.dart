import 'package:flutter/material.dart';

export 'package:long_life_burning/modules/stepcount/diagnose/diagnose.dart';

const num kHeight = 170;
const num kWeight = 70;
final DateTime kDateOfBirth = DateTime(DateTime.now().year - 18, 1, 1);

class StepCount extends InheritedWidget {

  final Widget child;
  final num step;
  final num cal;
  final num dist;

  StepCount({
    Key key,
    @required this.child,
    this.step,
    this.cal,
    this.dist,
  }) :  assert(child != null),
        super(
          key: key,
          child: child,
        );

  static StepCount of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(StepCount) as StepCount;
  }

  @override
  bool updateShouldNotify(StepCount oldWidget) =>
    step != oldWidget.step ||
    cal != oldWidget.cal ||
    dist != oldWidget.dist;

}
