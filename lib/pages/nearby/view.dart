import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/constants/platform.dart';

class NearbyView extends StatefulWidget {
  @override
  _NearbyViewState createState() => _NearbyViewState();
}

class _NearbyViewState extends State<NearbyView> {

  @override
  Widget build(BuildContext context) {

    if ( Platforms.isIOS ) {
      return CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CupertinoColors.darkBackgroundGray,
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: true,
          middle: Text(
            'Nearby',
            style: TextStyle(color: CupertinoColors.white),
          ),
          backgroundColor: CupertinoColors.black,
          border: Border(
            bottom: BorderSide(
              color: Color(0x4C000000),
              width: 0.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Nearby Page',
                style: TextStyle(color: CupertinoColors.white),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text(
          'Nearby',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 4.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nearby Page',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );

  }

}