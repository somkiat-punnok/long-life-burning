import 'package:flutter/material.dart';
import 'package:long_life_burning/utils/constants.dart' show Constants;

class EventDetailPage extends StatefulWidget {
  static const String routeName = '/event';
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 10.0),
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage(Constants.forestImage),
                      fit: BoxFit.cover,
                    ),
                  )),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.all(40.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 120.0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'lesson.level',
                                style: TextStyle(color: Colors.white),
                              )
                            )
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(7.0),
                              decoration: new BoxDecoration(
                                  border: new Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: new Text(
                                '\$lesson.price.toString()',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 8.0,
                top: 60.0,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.navigate_before, color: Colors.white),
                ),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
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
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      onPressed: () => {},
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