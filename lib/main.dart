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
import 'package:long_life_burning/utils/helper/constants.dart' show Configs;
import 'package:long_life_burning/screen/app.dart';

Future<void> main() async {
  await FitKit
    .requestPermissions(DataType.values)
    .then((result) async {
      Configs.fitkit_permissions = result;
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
    })
    .catchError((err) {
      print(err);
      return;
    });
}
