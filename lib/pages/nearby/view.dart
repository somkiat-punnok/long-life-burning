import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class NearbyView extends StatefulWidget {
  @override
  _NearbyViewState createState() => _NearbyViewState();
}

class _NearbyViewState extends State<NearbyView> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      android: (_) => MaterialScaffoldData(),
      ios: (_) => CupertinoPageScaffoldData(),
      appBar:  PlatformAppBar(
        title: Text(
          'Nearby',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange[200],
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