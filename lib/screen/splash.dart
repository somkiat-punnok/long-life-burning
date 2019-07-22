import 'dart:async';
import 'package:flutter/material.dart';
import 'package:long_life_burning/constants/constant.dart';
import 'package:long_life_burning/modules/loader/dot_loader.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () async => Navigator.of(context).pushReplacementNamed('/index'));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
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
          )
        ],
      ),
    );
  }
}