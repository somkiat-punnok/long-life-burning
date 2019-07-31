import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:long_life_burning/screen/app.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    runApp(App());
  });
}
