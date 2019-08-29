import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:flutter_localizations/flutter_localizations.dart'
  show
    GlobalMaterialLocalizations,
    GlobalCupertinoLocalizations,
    GlobalWidgetsLocalizations;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    Constants,
    isMaterial;

import 'login/login_screen.dart';
import 'index.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: isMaterial ? Colors.blue : CupertinoColors.activeBlue,
        textTheme: TextTheme(
          display1: TextStyle(
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => Index(),
        '/login': (BuildContext context) => LoginScreen(),
      },
      localizationsDelegates: <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        Locale("en", "US"),
      ],
    );
  }

}
