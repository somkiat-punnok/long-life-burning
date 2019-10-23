import 'package:flutter/material.dart'
  show
    runApp,
    Colors;
import 'package:flutter/services.dart'
  show
    SystemChrome,
    SystemUiOverlayStyle,
    DeviceOrientation;
import 'package:fit_kit/fit_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show Configs;
import 'package:long_life_burning/screen/app.dart';

Future<void> main() async {
  await FitKit
    .requestPermissions(DataType.values)
    .then((result) => Configs.fitkit_permissions = result);
  await SharedPreferences
    .getInstance()
    .then((_pref) {
      if (_pref != null) {
        Configs.pref = _pref;
      }
    });
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(App());
}
