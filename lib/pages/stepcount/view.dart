import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/constants/platform.dart';
import 'package:long_life_burning/widgets/scaffold.dart';
import 'package:long_life_burning/widgets/appbar.dart';
//import 'package:long_life_burning/modules/stepcount/stepcounter.dart';

class StepCountView extends StatefulWidget {
  @override
  _StepCountViewState createState() => _StepCountViewState();
}

class _StepCountViewState extends State<StepCountView> {

  //StepCounter step = new StepCounter();

  @override
  Widget build(BuildContext context) {

    if ( Platforms.isIOS ) {
      return IOSScaffold(
        appBar: IOSAppBar(
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

    return AndroidScaffold(
      appBar:  AndroidAppBar(
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