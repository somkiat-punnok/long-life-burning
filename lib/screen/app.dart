import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/constants/platform.dart';
import 'package:long_life_burning/routes/route.dart';
import 'package:long_life_burning/screen/index.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    if ( Platforms.isIOS ) {
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: CupertinoColors.activeBlue,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        home: Index(),
        routes: Routes.route,
      );
    }
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          display1: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      home: Index(),
      routes: Routes.route,
    );

  }

}
