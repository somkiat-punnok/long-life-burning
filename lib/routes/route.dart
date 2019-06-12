import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:long_life_burning/contents/content.dart';
import 'package:long_life_burning/routes/route_handler.dart';

class Routes {

  static void configRoute(Router router) {

    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("ROUTE WAS NOT FOUND !!!");
      }
    );

    router.define(Content.ROOT, handler: stepHandler);
    router.define(Content.ABOUT, handler: aboutHandler);
    router.define(Content.ANNOUNCE, handler: announceHandler);
    router.define(Content.CHART, handler: chartHandler);
    router.define(Content.GROUP, handler: groupHandler);
    router.define(Content.NEARBY, handler: nearbyHandler);
    router.define(Content.NOTIFY, handler: notifyHandler);
    router.define(Content.STEPCOUNT, handler: stepHandler);

  }

}
