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
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    Gender,
    Configs,
    UserOptions,
    isCupertino;
import 'package:long_life_burning/screen/app.dart';

Future<void> main() async {
  if (isCupertino) {
    await FitKit.requestPermissions(DataType.values).then((result) => Configs.fitkit_permissions = result);
  }
  await SharedPreferences.getInstance().then((_pref) {
    if (_pref != null) {
      Configs.pref = _pref;
    }
  });
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await checkAuth();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(App());
}

Future<void> checkAuth() async {
  await Configs.auth.currentUser().then((user) async {
    if (user != null) {
      UserOptions.user = user;
      await Configs.store
        .collection(UserOptions.collection)
        .where(
          UserOptions.uid_field,
          isEqualTo: user.uid,
        )
        .snapshots()
        .listen((data) {
          if (data.documents.isNotEmpty) {
            UserOptions.name = data.documents[0].data[UserOptions.name_field];
            UserOptions.weight = data.documents[0].data[UserOptions.weight_field];
            UserOptions.height = data.documents[0].data[UserOptions.height_field];
            UserOptions.dateOfBirth = DateTime.fromMicrosecondsSinceEpoch(data.documents[0].data[UserOptions.dateOfBirth_field].microsecondsSinceEpoch);
            UserOptions.gender = data.documents[0].data[UserOptions.gender_field].toLowerCase() != 'female' ? Gender.MALE : Gender.FEMALE;
          }
        });
      Configs.login = true;
    }
  });
}
