import 'package:flutter/material.dart';
import 'package:long_life_burning/widgets/platform_widgets.dart';

class NotifyPage extends StatefulWidget {
  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {

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
          'Notify',
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
              'Notify Page',
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