import 'package:flutter/material.dart'
  show
    runApp,
    Colors;
import 'package:flutter/services.dart'
  show
    SystemChrome,
    SystemUiOverlayStyle,
    DeviceOrientation;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    isCupertino,
    Configs;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
  show
    FlutterLocalNotificationsPlugin;
import 'package:fit_kit/fit_kit.dart';
import 'package:long_life_burning/screen/app.dart';

Future<void> main() async {
  Configs.notifyPlugin = new FlutterLocalNotificationsPlugin();
  if (isCupertino) {
    await FitKit
      .requestPermissions(DataType.values)
      .then((result) async {
        Configs.fitkit_permissions = result;
      })
      .catchError((err) {
        print(err);
        return;
      });
  }
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
