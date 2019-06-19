import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/constants/platform.dart';
import 'package:long_life_burning/widgets/scaffold.dart';
import 'package:long_life_burning/widgets/appbar.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {

  @override
  Widget build(BuildContext context) {
    
    if ( Platforms.isIOS ) {
      return IOSScaffold(
        appBar: IOSAppBar(
          title: Text(
            'About',
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
                'About Page',
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
          'About',
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
              'About Page',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );

  }

}