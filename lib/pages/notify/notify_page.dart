import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/notify/notify.dart' show NotifyWidget;

class NotifyPage extends StatefulWidget {
  NotifyPage({ Key key }) : super(key: key);
  static const String routeName = '/';
  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // body: NotifyWidget(
      //   notify: ,
      // ),
    );
  }
}
