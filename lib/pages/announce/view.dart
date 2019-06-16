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
      android: (_) => MaterialScaffoldData(
        appBar: AppBar(
          title: Text(
            'Announce',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.blue[200],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Announce Page',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      ios: (_) => CupertinoPageScaffoldData(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            'Announce',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Announce Page',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}