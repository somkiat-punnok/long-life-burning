import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/constants/platform.dart';
import 'package:long_life_burning/widgets/scaffold.dart';
import 'package:long_life_burning/widgets/appbar.dart';

class NearbyView extends StatefulWidget {
  @override
  _NearbyViewState createState() => _NearbyViewState();
}

class _NearbyViewState extends State<NearbyView> {

  @override
  Widget build(BuildContext context) {

    if ( Platforms.isIOS ) {
      return IOSScaffold(
        appBar: IOSAppBar(
          title: Text(
            'Nearby',
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
                'Nearby Page',
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
          'Nearby',
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
              'Nearby Page',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );

  }

}