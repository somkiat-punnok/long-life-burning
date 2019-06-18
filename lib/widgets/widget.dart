import 'package:flutter/widgets.dart';
import 'package:long_life_burning/widgets/base.dart';

class Widgets extends Base<Widget, Widget> {

  Widgets({
    Key key,
    this.ios,
    this.android,
  }) : super(key: key);

  final Builders<Widget> android;
  final Builders<Widget> ios;

  @override
  Widget androidrun(BuildContext context) {
    if (android == null) {
      return Container();
    } else {
      return android(context);
    }
  }

  @override
  Widget iOSrun(BuildContext context) {
    if (ios == null) {
      return Container();
    } else {
      return ios(context);
    }
  }
}