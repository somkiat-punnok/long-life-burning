import 'dart:async';
import 'package:flutter/material.dart';
import 'package:long_life_burning/utils/constants.dart';
import 'package:long_life_burning/modules/loader/dot_loader.dart';
import 'index.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () async => await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => Index(),
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Constants.forestImage),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: DotLoader(
                    radius: SizeConfig.setWidth(30.0),
                    dotRadius: SizeConfig.setWidth(12.0),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              brightness: Brightness.dark,
              elevation: 0.0,
            ),
          ),
        ],
      ),
    );
  }
}