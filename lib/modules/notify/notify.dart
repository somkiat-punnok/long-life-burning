import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notification {

  FlutterLocalNotificationsPlugin notify;
  
  Notification(){
    _initNotify();
  }

  void _initNotify() {
    notify = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings initSettingsAndroid = AndroidInitializationSettings('secondary_icon');
    IOSInitializationSettings initSettingsIOS = IOSInitializationSettings();
    InitializationSettings initSettings = InitializationSettings(initSettingsAndroid, initSettingsIOS);
    notify.initialize(initSettings, onSelectNotification: _onSelectNotify);
  }

  Future showNotification(int id, String title, String body, String payload) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('GTF', 'Long Burn', 'Long Life Burning', importance: Importance.Max, priority: Priority.High);
    IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await notify.show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  Future _onSelectNotify(String payload) async {
    if (payload != null) {
      print('notification payload pressed: ' + payload);
    }
  }

}