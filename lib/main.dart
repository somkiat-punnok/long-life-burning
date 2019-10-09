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
    Configs,
    UserOptions,
    isCupertino;
import 'package:long_life_burning/screen/app.dart';

Future<void> main() async {
  await checkAuth().then((_) async {
    await FitKit.requestPermissions(DataType.values).then((result) => Configs.fitkit_permissions = result);
    await SharedPreferences.getInstance().then((_pref) {
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
  });
}

Future<void> checkAuth() async {
  await Configs.auth
    .currentUser()
    .then((user) async {
      if (user != null) {
        await Configs.store
          .collection(UserOptions.collection)
          .where(
            UserOptions.uid_field,
            isEqualTo: user.uid,
          )
          .getDocuments()
          .then((data) {
            if (data.documents.isNotEmpty) {
              UserOptions.user = user;
              Configs.login = true;
              Configs.setUser(
                n: data.documents[0].data[UserOptions.name_field],
                w: data.documents[0].data[UserOptions.weight_field],
                h: data.documents[0].data[UserOptions.height_field],
                d: data.documents[0].data[UserOptions.dateOfBirth_field],
                g: data.documents[0].data[UserOptions.gender_field],
              );
            }
          });
          // .snapshots()
          // .listen((data) {
          //   if (data.documents.isNotEmpty) {
          //     UserOptions.user = user;
          //     Configs.login = true;
          //     Configs.setUser(
          //       n: data.documents[0].data[UserOptions.name_field],
          //       w: data.documents[0].data[UserOptions.weight_field],
          //       h: data.documents[0].data[UserOptions.height_field],
          //       d: data.documents[0].data[UserOptions.dateOfBirth_field],
          //       g: data.documents[0].data[UserOptions.gender_field],
          //     );
          //   }
          // });
      }
    });
}
