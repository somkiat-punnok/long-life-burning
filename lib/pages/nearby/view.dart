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
      appBar:  PlatformAppBar(
        title: Text('Nearby'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nearby Page',
            ),
          ],
        ),
      ),
    );
  }
}