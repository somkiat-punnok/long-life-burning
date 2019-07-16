import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:long_life_burning/screen/app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.top,
    SystemUiOverlay.bottom,
  ]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(App());
}
