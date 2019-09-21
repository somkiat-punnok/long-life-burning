library login;

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'
  show
    showCupertinoModalPopup,
    CupertinoDatePickerMode,
    CupertinoDatePicker,
    CupertinoColors;
import 'package:intl/intl.dart' show DateFormat;
import 'package:long_life_burning/screen/index.dart';
import 'package:long_life_burning/utils/helper/constants.dart';

part './home.dart';
part './signin.dart';
part './signup.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {

  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 1, viewportFraction: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void gotoSignin() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  void gotoSignup() {
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      child: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          SignInPage(),
          HomePage(
            signin: gotoSignin,
            signup: gotoSignup,
          ),
          SignUpPage(
            signin: gotoSignin,
          ),
        ],
      ),
    );
  }

}
