import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
// Modules
import 'package:long_life_burning/pages/about/view.dart';
import 'package:long_life_burning/pages/announce/view.dart';
import 'package:long_life_burning/pages/chart/view.dart';
import 'package:long_life_burning/pages/group/view.dart';
import 'package:long_life_burning/pages/nearby/view.dart';
import 'package:long_life_burning/pages/notify/view.dart';
import 'package:long_life_burning/pages/stepcount/view.dart';

var aboutHandler = new Handler(

  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new AboutView();
  }

);

var announceHandler = new Handler(

  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new AnnounceView();
  }

);

var chartHandler = new Handler(

  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new ChartView();
  }

);

var groupHandler = new Handler(

  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new GroupView();
  }

);

var nearbyHandler = new Handler(

  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new NearbyView();
  }

);

var notifyHandler = new Handler(

  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new NotifyView();
  }

);

var stepHandler = new Handler(

  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new StepCountView();
  }

);
