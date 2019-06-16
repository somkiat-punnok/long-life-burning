import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
//import 'package:long_life_burning/modules/stepcount/stepcounter.dart';

class StepCountView extends StatefulWidget {
  @override
  _StepCountViewState createState() => _StepCountViewState();
}

class _StepCountViewState extends State<StepCountView> {

  //StepCounter step = new StepCounter();

  @override
  Widget build(BuildContext context) {

    return PlatformScaffold(
      android: (_) => MaterialScaffoldData(),
      ios: (_) => CupertinoPageScaffoldData(),
      appBar:  PlatformAppBar(
        title: Text(
          'Step Count',
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
              'Step Count Page',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}