// import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:pedometer/pedometer.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

export 'package:long_life_burning/modules/stepcount/forecast/forecast.dart';
export 'package:long_life_burning/modules/stepcount/forecast/radial_list.dart';

class StepCount extends StatefulWidget {
  @override
  _StepCountState createState() => _StepCountState();
}

class _StepCountState extends State<StepCount> {

  //StreamSubscription<int> _subscription;
  //String _km = "Unknown";
  //String _calories = "Unknown";
  //String _stepCountValue = "Unknown";

  //double _number;
  //double _kmx;

  // @override
  // void initState() {
  //   super.initState();
  //   setUpPedometer();
  // }

  // void setUpPedometer() {
  //   Pedometer pedometer = Pedometer();
  //   _subscription = pedometer.stepCountStream.listen( _onData,
  //     onError: _onError, onDone: _onDone, cancelOnError: true );
  // }

  // void _onData(int stepCountValue) async {
  //   setState(() {
  //     _stepCountValue = "$stepCountValue";
  //   });
  //   var dist = stepCountValue;
  //   double y = (dist + .0);
  //   setState(() {
  //     _number = y;
  //   });
  //   getDistanceRun(_number);
  // }

  // void reset() {
  //   setState(() {
  //     int stepCountValue = 0;
  //     _stepCountValue = "$stepCountValue";
  //   });
  // }

  // void _onDone() {}

  // void _onError(error) {
  //   print("Flutter Pedometer Error: $error");
  // }

  // void getDistanceRun(double _number) {
  //   var distance = ((_number * 78) / 100000);
  //   distance = num.parse(distance.toStringAsFixed(2)); //dos decimales
  //   var distancekm = distance * 34;
  //   distancekm = num.parse(distancekm.toStringAsFixed(2));
  //   setState(() {
  //     _km = "$distance";
  //   });
  //   setState(() {
  //     _kmx = num.parse(distancekm.toStringAsFixed(2));
  //   });
  // }

  // 1 step = 0.732 meters.
  // void getBurnedRun() {
  //   setState(() {
  //     var calories = _kmx;
  //     _calories = "$calories";
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    //getBurnedRun();

    return Container(
      
    );

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Step Counter app'),
    //       backgroundColor: Colors.black54,
    //     ),
    //     body: ListView(
    //       padding: EdgeInsets.all(5.0),
    //       children: <Widget>[
    //         Container(
    //           padding: EdgeInsets.only(top: 10.0),
    //           width: 250, //ancho
    //           height: 250, //largo tambien por numero height: 300
    //           decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                 begin: Alignment
    //                     .bottomCenter, //cambia la iluminacion del degradado
    //                 end: Alignment.topCenter,
    //                 colors: [Color(0xFFA9F5F2), Color(0xFF01DFD7)],
    //               ),
    //               borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(27.0),
    //                 bottomRight: Radius.circular(27.0),
    //                 topLeft: Radius.circular(27.0),
    //                 topRight: Radius.circular(27.0),
    //               )),
    //                child: CircularPercentIndicator(
    //               radius: 200.0,
    //               lineWidth: 13.0,
    //               animation: true,
    //               center: Container(
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: <Widget>[
    //                     Container(
    //                       height: 50,
    //                       width: 50,
    //                       padding: EdgeInsets.only(left: 20.0),
    //                       child: Icon(
    //                         FontAwesomeIcons.walking,
    //                         size: 30.0,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                     Container(
    //                       //color: Colors.orange,
    //                       child: Text(
    //                         '$_stepCountValue',
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 20.0,
    //                             color: Colors.purpleAccent),
    //                       ),
    //                       // height: 50.0,
    //                       // width: 50.0,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               percent: 0.217,
    //               //percent: _convert,
    //               footer: Text(
    //                 "Pasos:  $_stepCountValue",
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 12.0,
    //                     color: Colors.purple),
    //               ),
    //               circularStrokeCap: CircularStrokeCap.round,
    //               progressColor: Colors.purpleAccent,
    //             ),
    //         ),
    //         Divider(
    //           height: 5.0,
    //         ),
    //         Container(
    //           width: 80,
    //           height: 100,
    //           padding: EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10.0),
    //           color: Colors.transparent,
    //           child: Row(
    //             children: <Widget>[
    //               Container(
    //                 child: Card(
    //                   child: Container(
    //                     height: 80.0,
    //                     width: 80.0,
    //                     decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                         image: AssetImage("assets/images/distance.png"),
    //                         fit: BoxFit.fitWidth,
    //                         alignment: Alignment.topCenter,
    //                       ),
    //                     ),
    //                     child: Text(
    //                       "$_km Km",
    //                       textAlign: TextAlign.right,
    //                       style: TextStyle(
    //                           fontWeight: FontWeight.bold, fontSize: 14.0),
    //                     ),
    //                   ),
    //                   color: Colors.white54,
    //                 ),
    //               ),
    //               VerticalDivider(
    //                 width: 20.0,
    //               ),
    //               Container(
    //                 child: Card(
    //                   child: Container(
    //                     height: 80.0,
    //                     width: 80.0,
    //                     decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                         image: AssetImage("assets/images/burned.png"),
    //                         fit: BoxFit.fitWidth,
    //                         alignment: Alignment.topCenter,
    //                       ),
    //                     ),
    //                   ),
    //                   color: Colors.transparent,
    //                 ),
    //               ),
    //               VerticalDivider(
    //                 width: 20.0,
    //               ),
    //               Container(
    //                 child: Card(
    //                   child: Container(
    //                     height: 80.0,
    //                     width: 80.0,
    //                     decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                         image: AssetImage("assets/images/step.png"),
    //                         fit: BoxFit.fitWidth,
    //                         alignment: Alignment.topCenter,
    //                       ),
    //                     ),
    //                   ),
    //                   color: Colors.transparent,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Divider(
    //           height: 2,
    //         ),
    //         Container(
    //           padding: EdgeInsets.only(top: 2.0),
    //           width: 150, //ancho
    //           height: 30, //largo tambien por numero height: 300
    //           color: Colors.transparent,
    //           child: Row(
    //             children: <Widget>[
    //               Container(
    //                 padding: EdgeInsets.only(left: 40.0),
    //                 child: Card(
    //                   child: Container(
    //                     child: Text(
    //                       "$_km Km",
    //                       textAlign: TextAlign.right,
    //                       style: TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 14.0,
    //                           color: Colors.white),
    //                     ),
    //                   ),
    //                   color: Colors.purple,
    //                 ),
    //               ),
    //               VerticalDivider(
    //                 width: 20.0,
    //               ),
    //               Container(
    //                 padding: EdgeInsets.only(left: 10.0),
    //                 child: Card(
    //                   child: Container(
    //                     child: Text(
    //                       "$_calories kCal",
    //                       textAlign: TextAlign.right,
    //                       style: TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 14.0,
    //                           color: Colors.white),
    //                     ),
    //                   ),
    //                   color: Colors.red,
    //                 ),
    //               ),
    //               VerticalDivider(
    //                 width: 5.0,
    //               ),
    //               Container(
    //                 padding: EdgeInsets.only(left: 10.0),
    //                 child: Card(
    //                   child: Container(
    //                     child: Text(
    //                       "$_stepCountValue Steps",
    //                       textAlign: TextAlign.right,
    //                       style: TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 14.0,
    //                           color: Colors.white),
    //                     ),
    //                   ),
    //                   color: Colors.black,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

}
