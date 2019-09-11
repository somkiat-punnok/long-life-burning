library login;

// import 'dart:math';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:long_life_burning/modules/login/login.dart';
import 'package:long_life_burning/screen/index.dart';
import 'package:long_life_burning/utils/helper/constants.dart';
// import 'package:long_life_burning/modules/login/Register.dart';

part './home.dart';
part './signin.dart';
part './signup.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {

  PageController _controller;

  @override
  void initState() { 
    super.initState();
    checkAuth();
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

  void checkAuth() async {
    await UserOptions.auth.currentUser().then((user) async {
      if (user != null) {
        UserOptions.user = user;
        print('user: ${UserOptions.user}');
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Index(),
          ),
        );
      }
    });
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
