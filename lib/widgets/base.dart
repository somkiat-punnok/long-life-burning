import 'package:flutter/widgets.dart';
import 'package:long_life_burning/constants/platform.dart';

typedef T Builders<T>(BuildContext context);

abstract class Base<I extends Widget, A extends Widget> extends StatelessWidget {

  Base({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (Platforms.isAndroid) {
      return androidrun(context);
    } else if (Platforms.isIOS) {
      return iOSrun(context);
    }

    return throw new UnsupportedError(
      'This platform is not supported: ' + Platforms.os);
  }

  I iOSrun(BuildContext context);

  A androidrun(BuildContext context);
}