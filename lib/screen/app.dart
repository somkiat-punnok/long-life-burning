import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:long_life_burning/constants/constant.dart';
import 'package:long_life_burning/routes/route.dart';
import 'splash.dart';

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
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      home: SplashScreen(),
      routes: Routes.route,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en", "US"),
      ],
    );
  }
}
