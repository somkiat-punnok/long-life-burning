import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/announce/event/events.dart' show Event;
import 'package:long_life_burning/utils/helper/constants.dart' show SizeConfig;

class EventDetailPage extends StatefulWidget {
  EventDetailPage({Key key}) : super(key: key);
  static const String routeName = '/event';
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    brightness: Brightness.dark,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(40.0),
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Icon(
                          Icons.directions_car,
                          color: Colors.white,
                          size: 40.0,
                        ),
                        Container(
                          width: 90.0,
                          child: Divider(color: Colors.green),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '${event.title}',
                          style: TextStyle(color: Colors.white, fontSize: 24.0),
                        ),
                        Text(
                          '${event.subtitle}',
                          style: TextStyle(color: Colors.white, fontSize: 24.0),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      '${event.detail}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      width: SizeConfig.screenWidth,
                      child: RaisedButton(
                        onPressed: () async => Navigator.of(context).popUntil(ModalRoute.withName('/')),
                        color: Color.fromRGBO(58, 66, 86, 1.0),
                        child: Text(
                          "TAKE THIS LESSON",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
