import 'package:flutter/material.dart';
import 'package:long_life_burning/utils/helper/constants.dart';

class EventDetailPage extends StatefulWidget {
  static const String routeName = '/event';
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: Column(
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
                  elevation: 0.0,
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
                      SizedBox(height: 80.0),
                      Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      Container(
                        width: 90.0,
                        child: new Divider(color: Colors.green),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'lesson.title',
                        style: TextStyle(color: Colors.white, fontSize: 45.0),
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
                    'lesson.content',
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
    );
  }

}