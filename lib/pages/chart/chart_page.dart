import 'package:flutter/material.dart';
import 'package:long_life_burning/widgets/platform_widgets.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      android: (_) => MaterialScaffoldData(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
      ),
      ios: (_) => CupertinoPageScaffoldData(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomInsetTab: true,
      ),
      backgroundColor: Colors.black87,
      appBar: PlatformAppBar(
        title: Text(
          'Chart',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        android: (_) => MaterialAppBarData(
          brightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Chart Page',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

}