import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/constants/platform.dart';
import 'package:long_life_burning/widgets/scaffold.dart';
import 'package:long_life_burning/widgets/appbar.dart';

class GroupView extends StatefulWidget {
  @override
  _GroupViewState createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  
  @override
  Widget build(BuildContext context) {
    
    if ( Platforms.isIOS ) {
      return IOSScaffold(
        appBar: IOSAppBar(
          title: Text(
            'Group',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black87,
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

    return AndroidScaffold(
      appBar:  AndroidAppBar(
        title: Text(
          'Group',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black87,
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