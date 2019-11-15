
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/stepcount/db/src/common_import.dart';
// import 'package:long_life_burning/modules/announce/event/events.dart';
// import 'package:long_life_burning/utils/helper/constants.dart';
import 'package:long_life_burning/utils/providers/all.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({ Key key }) : super(key: key);
  static const String routeName = '/statistic';
  
  @override
  _StatisticPageState createState() => _StatisticPageState();
  
}

class EventData {
  EventData(this.year, this.event);
  final String year;
  final double event;
}

// class EventRecordUser {
//   final String eventId;
//   final num calories;
//   final num distance;
//   final TimeRecordUser avgpace;
//   final TimeRecordUser duration;
//   final String year;

//   EventRecordUser({
//     this.year,
//     this.eventId,
//     this.calories,
//     this.distance,
//     this.avgpace,
//     this.duration,
//   });

//   factory EventRecordUser.fromMap(Map<String, dynamic> map) => EventRecordUser(
//     eventId: map["eventId"],
//     calories: map["calories"],
//     distance: map["distance"],
//     avgpace: TimeRecordUser.fromMap(map["avgpace"]),
//     duration: TimeRecordUser.fromMap(map["duration"]),
//   );

//   factory EventRecordUser.fromJson(String s) => EventRecordUser.fromMap(json.decode(s));

//   Map<String, dynamic> toMap() => <String, dynamic>{
//     "eventId": this.eventId,
//     "calories": this.calories,
//     "distance": this.distance,
//     "avgpace": this.avgpace.toMap(),
//     "duration": this.duration.toMap(),
//   };

//   String toJson() => json.encode(this.toMap());

//   @override
//   bool operator ==(Object other) =>
//     identical(this, other) ||
//       other is EventRecordUser &&
//         runtimeType == other.runtimeType &&
//         eventId == other.eventId &&
//         calories == other.calories &&
//         distance == other.distance &&
//         avgpace == other.avgpace &&
//         duration == other.duration;

//   @override
//   int get hashCode => (
//     eventId.hashCode ^
//     calories.hashCode ^
//     distance.hashCode ^
//     avgpace.hashCode ^
//     duration.hashCode
//   );

//   @override
//   String toString() {
//     return '$runtimeType{id: $eventId, calories: $calories, distance: $distance}';
//   }
// }

class _StatisticPageState extends State<StatisticPage> {
  List<Widget> charts = [
  Center(
          child:SingleChildScrollView(
          child:Column(
            children:<Widget>[
        Container(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Events for month'), 
          legend: Legend(isVisible: true),
          series: <LineSeries<EventData, String>>[
            LineSeries<EventData, String>(
                enableTooltip: true,
              name: "Events",
               color: Colors.red,
              dataSource: [
                EventData('Jan', 2),
                EventData('Feb', 3),
                EventData('Mar', 1),
                EventData('Apr', 0),
                EventData('May', 3),
                EventData('Jun', 1),
                EventData('Jul', 1),
                EventData('Aug', 2),
                EventData('Sep', 1),
                EventData('Oct', 2),
                EventData('Nov', 0),
                EventData('Dec', 0),
              ],
              xValueMapper: (EventData events, _) => events.year,
              yValueMapper: (EventData events, _) => events.event,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            ),
          ]
        ),
      ),
      Divider(height: 24.0,),
     
        Container(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Statistics for month'), 
          legend: Legend(isVisible: true), 
          series: <LineSeries<EventData, String>>[
            LineSeries<EventData, String>(
                enableTooltip: true,
              name: "Calorie/kcal.",
               color: Colors.green,
              dataSource: [
                EventData('Jan,', 50),
                EventData('Feb', 70),
                EventData('Mar', 60),
                EventData('Apr', 20),
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
              yValueMapper: (EventData events, _) => events.event,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            ),
          ]
        ),
            ),
             Divider(height: 24.0,),
     
        Container(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Distance for month'), 
          legend: Legend(isVisible: true), 
          series: <LineSeries<EventData, String>>[
            LineSeries<EventData, String>(
                enableTooltip: true,
              name: "Distance/km.",
               color: Colors.blue,
              dataSource: [
                EventData('Jan,', 50),
                EventData('Feb', 70),
                EventData('Mar', 60),
                EventData('Apr', 20),
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
              yValueMapper: (EventData events, _) => events.event,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            ),
          ]
        ),
            ),
            ]
          )
        )
        ),
  
   Center(
          child:SingleChildScrollView(
          child:Column(
            children:<Widget>[
        Container(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Events for years'), 
          legend: Legend(isVisible: true), 
          series: <LineSeries<EventData, String>>[
            LineSeries<EventData, String>(
                enableTooltip: true,
               color: Colors.red,
               name: "Event",
              dataSource: [
                EventData('2015,', 10),
                EventData('2016', 12),
                EventData('2017', 14),
                EventData('2018', 20),
                EventData('2019', 30),
              ],
              xValueMapper: (EventData events, _) => events.year,
              yValueMapper: (EventData events, _) => events.event,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            ),
          ]
        ),
      ),
      Divider(height: 24.0,),
     
        Container(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Calories for years'), 
          legend: Legend(isVisible: true), 
          series: <LineSeries<EventData, String>>[
            LineSeries<EventData, String>(
                enableTooltip: true,
              name: "Calories/kcal.",
               color: Colors.green,
              dataSource: [
                EventData('2015,', 5000),
                EventData('2016', 2000),
                EventData('2017', 1500),
                EventData('2018', 1450),
                EventData('2019', 1600),
              ],
              xValueMapper: (EventData events, _) => events.year,
              yValueMapper: (EventData events, _) => events.event,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            ),
          ]
        ),
            ),
             Divider(height: 24.0,),
     
        Container(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Distance for years'), 
          legend: Legend(isVisible: true), 
          series: <LineSeries<EventData, String>>[
             LineSeries<EventData, String>(
                 enableTooltip: true,
              name: "Distance/km.",
               color: Colors.blue,
              dataSource: [
                EventData('2015,', 3000),
                EventData('2016', 1500),
                EventData('2017', 4000),
                EventData('2018', 1700),
                EventData('2019', 2000),
              ],
              xValueMapper: (EventData events, _) => events.year,
              yValueMapper: (EventData events, _) => events.event,
              dataLabelSettings: DataLabelSettings(isVisible: true) 
            ),
          ]
        ),
            ),
     ]
   )
 )
   )
  ];

  @override
  Widget build(BuildContext context) {
    
  final UserProvider provider = Provider.of<UserProvider>(context);
  provider?.record?.forEach((r) => r.eventId);
    return DefaultTabController(
      length:2,
     child: Scaffold(
       resizeToAvoidBottomInset: false,
       resizeToAvoidBottomPadding: false,
       backgroundColor: Colors.white,
       appBar: AppBar(
         automaticallyImplyLeading: false,
         centerTitle: false,
         brightness: Brightness.light,
         backgroundColor: Colors.white,
         title: Text('Statistic',
         style: TextStyle(
           color: Colors.black,
           fontSize: 36.0,
           fontWeight: FontWeight.bold,
         ),),
         bottom: TabBar(
           indicatorColor: Colors.black,
           labelColor: Colors.grey,
           unselectedLabelColor: Colors.black,
           unselectedLabelStyle: TextStyle(fontSize: 20.0),
           tabs: <Widget>[
             Tab(
               text: 'Montly',
             ),
             Tab(
               text: 'Yearly',
             )
           ],
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
       body: TabBarView(
         children: charts,
       ),
      )
     );    
  }
//     List<Widget> charts = [
//   Center(
//           child:SingleChildScrollView(
//           child:Column(
//             children:<Widget>[
//         Container(
//         child: SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           title: ChartTitle(text: 'Events for month'), 
//           legend: Legend(isVisible: true),
//           series: <LineSeries<EventRecordUser, String>>[
//             LineSeries<EventRecordUser, String>(
//               enableTooltip: true,
//               name: "Events",
//                color: Colors.red,
//               dataSource: [
//                 EventRecordUser(),
//               ],
//               xValueMapper: (EventRecordUser events, _) => events.year,
//               yValueMapper: (EventRecordUser events, _) => events?.eventId ?? 0,
//               dataLabelSettings: DataLabelSettings(isVisible: true) 
//             ),
//           ]
//         ),
//       ),
//       Divider(height: 24.0,),
     
//         Container(
//         child: SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           title: ChartTitle(text: 'Statistics for month'), 
//           legend: Legend(isVisible: true), 
//           series: <LineSeries<EventRecordUser, String>>[
//             LineSeries<EventRecordUser, String>(
//               enableTooltip: true,
//               name: "Calorie",
//                color: Colors.green,
//               dataSource: [
//                 EventRecordUser(),
//               ],
//               xValueMapper: (EventRecordUser events, _) => events.year,
//               yValueMapper: (EventRecordUser events, _) => events.calories,
//               dataLabelSettings: DataLabelSettings(isVisible: true) 
//             ),
//           ]
//         ),
//             ),
//              Divider(height: 24.0,),
     
//         Container(
//         child: SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           title: ChartTitle(text: 'Distance for month'), 
//           legend: Legend(isVisible: true), 
//           series: <LineSeries<EventRecordUser, String>>[
//             LineSeries<EventRecordUser, String>(
//               enableTooltip: true,
//               name: "Distance",
//                color: Colors.blue,
//               dataSource: [
//                 EventRecordUser(),
//               ],
//               xValueMapper: (EventRecordUser events, _) => events.year,
//               yValueMapper: (EventRecordUser events, _) => events.distance,
//               dataLabelSettings: DataLabelSettings(isVisible: true) 
//             ),
//           ]
//         ),
//             ),
//              Divider(height: 24.0,),
     
//         Container(
//         child: SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           title: ChartTitle(text: 'Fast rate for month'), 
//           legend: Legend(isVisible: true), 
//           series: <LineSeries<EventRecordUser, String>>[
//             LineSeries<EventRecordUser, String>(
//               enableTooltip: true,
//               name: "Fast rate/hour",
//                color: Colors.amber,
//               dataSource: [
//                 EventRecordUser(),
//               ],
//               xValueMapper: (EventRecordUser events, _) => events.year,
//               yValueMapper: (EventRecordUser events, _) => events?.avgpace?.hour ?? 0,
//               dataLabelSettings: DataLabelSettings(isVisible: true) 
//             ),
//              LineSeries<EventRecordUser, String>(
//               enableTooltip: true,
//               name: "Fast rate/minute",
//                color: Colors.green,
//               dataSource: [
//                 EventRecordUser(),
//               ],
//               xValueMapper: (EventRecordUser events, _) => events.year,
//               yValueMapper: (EventRecordUser events, _) => events?.avgpace?.minute ?? 0,
//               dataLabelSettings: DataLabelSettings(isVisible: true) 
//             ),
//           ]
//         ),
//             ),
//             ]
//           )
//         )
//         ),
  
//    Center(
//           child:SingleChildScrollView(
//           child:Column(
//             children:<Widget>[
//         Container(
//         child: SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           title: ChartTitle(text: 'Events for years'), 
//           legend: Legend(isVisible: true), 
//           series: <LineSeries<EventRecordUser, String>>[
//             LineSeries<EventRecordUser, String>(
//               enableTooltip: true,
//                color: Colors.red,
//                name: "Event",
//               dataSource: [
//                 EventRecordUser(),
//               ],
//               xValueMapper: (EventRecordUser events, _) => events.year,
//               yValueMapper: (EventRecordUser events, _) => events?.eventId ?? 0,
//               dataLabelSettings: DataLabelSettings(isVisible: true) 
//             ),
//           ]
//         ),
//       ),
//       Divider(height: 24.0,),
     
//         Container(
//         child: SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           title: ChartTitle(text: 'Calories for years'), 
//           legend: Legend(isVisible: true), 
//           series: <LineSeries<EventRecordUser, String>>[
//             LineSeries<EventRecordUser, String>(
//               enableTooltip: true,
//               name: "Calories",
//                color: Colors.green,
//               dataSource: [
//                 EventRecordUser(),
//               ],
//               xValueMapper: (EventRecordUser events, _) => events.year,
//               yValueMapper: (EventRecordUser events, _) => events.calories,
//               dataLabelSettings: DataLabelSettings(isVisible: true) 
//             ),
//           ]
//         ),
//             ),
//              Divider(height: 24.0,),
     
//         Container(
//         child: SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           title: ChartTitle(text: 'Distance for years'), 
//           legend: Legend(isVisible: true), 
//           series: <LineSeries<EventRecordUser, String>>[
//              LineSeries<EventRecordUser, String>(
//                enableTooltip: true,
//               name: "Distance",
//                color: Colors.blue,
//               dataSource: [
//                 EventRecordUser(),
//               ],
//               xValueMapper: (EventRecordUser events, _) => events.year,
//               yValueMapper: (EventRecordUser events, _) => events.distance,
//               dataLabelSettings: DataLabelSettings(isVisible: true) 
//             ),
//           ]
//         ),
//             ),
//              Divider(height: 24.0,),
     
//         Container(
//         child: SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           title: ChartTitle(text: 'Fast rate for years'), 
//           legend: Legend(isVisible: true), 
//           series: <LineSeries<EventRecordUser, String>>[
//              LineSeries<EventRecordUser, String>(
//                enableTooltip: true,
//               name: "Fast rate/hour",
//                color: Colors.amber,
//               dataSource: [
//                 EventRecordUser(),
//               ],
//               xValueMapper: (EventRecordUser events, _) => events.year,
//               yValueMapper: (EventRecordUser events, _) => events?.avgpace?.hour ?? 0,
//               dataLabelSettings: DataLabelSettings(isVisible: true) 
//             ),
//              LineSeries<EventRecordUser, String>(
//               name: "Fast rate/minute",
//                color: Colors.green,
//               dataSource: [
//                 EventRecordUser(),
//               ],
//               xValueMapper: (EventRecordUser events, _) => events.year,
//               yValueMapper: (EventRecordUser events, _) => events?.avgpace?.minute ?? 0,
//               dataLabelSettings: DataLabelSettings(isVisible: true) 
//             ),
//           ]
//         ),
//       ),
//      ]
//    )
//  )
//      ),
// ];
//   @override
//   Widget build(BuildContext context) {
//      DateTime.now();
//   final UserProvider provider = Provider.of<UserProvider>(context);
//   provider?.record?.forEach((r) => r.eventId);
//     return DefaultTabController(
//       length:2,
//      child: Scaffold(
//        resizeToAvoidBottomInset: false,
//        resizeToAvoidBottomPadding: false,
//        backgroundColor: Colors.white,
//        appBar: AppBar(
//          automaticallyImplyLeading: false,
//          centerTitle: false,
//          brightness: Brightness.light,
//          backgroundColor: Colors.white,
//          title: Text('Statistic',
//          style: TextStyle(
//            color: Colors.black,
//            fontSize: 36.0,
//            fontWeight: FontWeight.bold,
//          ),),
//          bottom: TabBar(
//            indicatorColor: Colors.black,
//            labelColor: Colors.grey,
//            unselectedLabelColor: Colors.black,
//            unselectedLabelStyle: TextStyle(fontSize: 20.0),
//            tabs: <Widget>[
//              Tab(
//                text: 'Montly',
//              ),
//              Tab(
//                text: 'Yearly',
//              )
//            ],
//          ),
//          actions: <Widget>[
//           GestureDetector(
//             onTap: () => Navigator.of(context).maybePop(),
//             child: Container(
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//               ),
//               padding: EdgeInsets.all(12.0),
//               child: Text(
//                 'Exit',
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//             ),
//           ),
//          ],
//        ),
//        body:
//          TabBarView(
//          children: charts,
//        ),
//      )
//      );    
//   }
  }

