import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AnnounceView extends StatefulWidget {
  @override
  _AnnounceViewState createState() => _AnnounceViewState();
}

class _AnnounceViewState extends State<AnnounceView> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar:  PlatformAppBar(
        title: Text('Announce'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Announce Page',
            ),
          ],
        ),
      ),
    );
  }
}