import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class NotifyView extends StatefulWidget {
  @override
  _NotifyViewState createState() => _NotifyViewState();
}

class _NotifyViewState extends State<NotifyView> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar:  PlatformAppBar(
        title: Text('Notify'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Notify Page',
            ),
          ],
        ),
      ),
    );
  }
}