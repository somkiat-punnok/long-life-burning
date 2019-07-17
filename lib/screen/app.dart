import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/screen/index.dart';
import 'package:long_life_burning/constants/platform.dart';
import 'package:long_life_burning/constants/constant.dart';
import 'package:long_life_burning/routes/route.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {

    if ( Platforms.isIOS ) {
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.activeBlue,
        ),
        home: Index(),
        routes: Routes.route,
        //initialRoute: Constants.Index_Page,
      );
    }
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Index(),
      routes: Routes.route,
      //initialRoute: Constants.Index_Page,
    );

  }

}
