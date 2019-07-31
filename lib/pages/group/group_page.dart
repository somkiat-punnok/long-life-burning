import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  static const String routeName = '/';
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(
          'Group',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Group Page',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

}