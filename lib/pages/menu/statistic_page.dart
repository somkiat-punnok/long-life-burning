import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({ Key key }) : super(key: key);
  static const String routeName = '/statistic';
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class DataEvent {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }
  getData() async {
    Firestore.instance.collection('users').document().collection('events').document().snapshots();
     builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
     };
  }
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Statistic',
          style: TextStyle(
            color: Colors.black,
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Exit',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          
        ],
      ),
        body:
        Container(
          child:SingleChildScrollView(
          child:Column(
            children:<Widget>[
        Container(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Events for year/event'), 
          legend: Legend(isVisible: true), 
          series: <LineSeries<EventData, String>>[
            LineSeries<EventData, String>(
               color: Colors.red,
              dataSource: [
                EventData('Jan,', 150),
                EventData('Feb', 28),
                EventData('Mar', 34),
                EventData('Apr', 1),
                EventData('May', 40),
                EventData('Jun', 100),
                EventData('Jul', 40),
                EventData('Aug', 90),
                EventData('Sep', 80),
                EventData('Oct', 20),
                EventData('Nov', 120),
                EventData('Dec', 300),
              ],
              xValueMapper: (EventData events, _) => events.year,
              yValueMapper: (EventData events, _) => events.clories,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            ),
             LineSeries<EventData, String>(
               color: Colors.green,
              dataSource: [
                EventData('Jan,', 20),
                EventData('Feb', 100),
                EventData('Mar', 60),
                EventData('Apr', 80),
                EventData('May', 200),
                EventData('Jun', 150),
                EventData('Jul', 40),
                EventData('Aug', 70),
                EventData('Sep', 15),
                EventData('Oct', 250),
                EventData('Nov', 110),
                EventData('Dec', 50),
              ],
              xValueMapper: (EventData events, _) => events.year,
              yValueMapper: (EventData events, _) => events.clories,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            ),
             LineSeries<EventData, String>(
                color: Colors.blue,
              dataSource: [
                EventData('Jan,', 50),
                EventData('Feb', 150),
                EventData('Mar', 60),
                EventData('Apr', 80),
                EventData('May', 55),
                EventData('Jun', 250),
                EventData('Jul', 130),
                EventData('Aug', 40),
                EventData('Sep', 120),
                EventData('Oct', 70),
                EventData('Nov', 75),
                EventData('Dec', 80),
              ],
              xValueMapper: (EventData events, _) => events.year,
              yValueMapper: (EventData events, _) => events.clories,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            )
          ]
        ),
        
      ),
      Divider(height: 24.0,),
     
        Container(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Events for month/event'), 
          legend: Legend(isVisible: true), 
          series: <LineSeries<EventData, String>>[
            LineSeries<EventData, String>(
               color: Colors.red,
              dataSource: [
                EventData('Jan,', 150),
                EventData('Feb', 28),
                EventData('Mar', 34),
                EventData('Apr', 1),
                EventData('May', 40),
                EventData('Jun', 100),
                EventData('Jul', 40),
                EventData('Aug', 90),
                EventData('Sep', 80),
                EventData('Oct', 20),
                EventData('Nov', 120),
                EventData('Dec', 300),
              ],
              xValueMapper: (EventData events, _) => events.year,
              yValueMapper: (EventData events, _) => events.clories,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            ),
             LineSeries<EventData, String>(
               color: Colors.green,
              dataSource: [
                EventData('Jan,', 20),
                EventData('Feb', 100),
                EventData('Mar', 60),
                EventData('Apr', 80),
                EventData('May', 200),
                EventData('Jun', 150),
                EventData('Jul', 40),
                EventData('Aug', 70),
                EventData('Sep', 15),
                EventData('Oct', 250),
                EventData('Nov', 110),
                EventData('Dec', 50),
              ],
              xValueMapper: (EventData events, _) => events.year,
              yValueMapper: (EventData events, _) => events.clories,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            ),
             LineSeries<EventData, String>(
                color: Colors.blue,
              dataSource: [
                EventData('Jan,', 50),
                EventData('Feb', 150),
                EventData('Mar', 60),
                EventData('Apr', 80),
                EventData('May', 55),
                EventData('Jun', 250),
                EventData('Jul', 130),
                EventData('Aug', 40),
                EventData('Sep', 120),
                EventData('Oct', 70),
                EventData('Nov', 75),
                EventData('Dec', 80),
              ],
              xValueMapper: (EventData events, _) => events.year,
              yValueMapper: (EventData events, _) => events.clories,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            )
          ]
        ),
      ),
            ]
          )
        )
        )
        
     );
     
  }
}

class EventData {
  EventData(this.year, this.clories);
  final String year;
  final double clories;
}