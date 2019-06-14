/*import 'dart:math';
import 'dart:async';
import 'package:pedometer/pedometer.dart';

class StepCounter {
  String muestrePasos = "";
  String _km = "Unknown";
  String _calories = "Unknown";

  String _stepCountValue = 'Unknown';
  StreamSubscription<int> _subscription;

  double _numerox;
  double _convert;
  double _kmx;

  void setUpPedometer() {
    Pedometer pedometer = new Pedometer();
    _subscription = pedometer.stepCountStream.listen( _onData, onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onData(int stepCountValue) async {
    _stepCountValue = "$stepCountValue";

    var dist = stepCountValue;
    double y = (dist + .0);

    _numerox = y;

    var long3 = (_numerox);
    long3 = num.parse(y.toStringAsFixed(2));
    var long4 = (long3 / 10000);

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;

    getDistanceRun(_numerox);

    _convert = d;
  }

  void reset() {
    int stepCountValue = 0;
    _stepCountValue = "$stepCountValue";
  }

  void _onDone() {}

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  //function to determine the distance run in kilometers using number of steps
  void getDistanceRun(double _numerox) {
    var distance = ((_numerox * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2));
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    _km = "$distance";
    _kmx = num.parse(distancekmx.toStringAsFixed(2));
  }

  //function to determine the calories burned in kilometers using number of steps
  void getBurnedRun() {
    var calories = _kmx;
    _calories = "$calories";
  }
}*/