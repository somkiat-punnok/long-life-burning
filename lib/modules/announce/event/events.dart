library event;

import 'dart:convert';
import 'package:flutter/material.dart';

part 'event_card.dart';
part 'event_list.dart';

class Event {

  final String id;
  final String detail;
  final DateTime date;
  
  Event({
    this.id,
    this.detail,
    this.date,
  });

  factory Event.fromMap(Map<String, dynamic> map) => Event(
    id: map["id"],
    detail: map["detail"],
  );

  factory Event.fromJson(String str) {
    final jsonData = json.decode(str);
    return Event.fromMap(jsonData);
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "detail": detail,
  };

  String toJson(Event data) {
    final Map<String, dynamic> dyn = data.toMap();
    return json.encode(dyn);
  }

}

class EventToList {

  static final Map<DateTime, List> events = {
    DateTime(2019, 7, 29): [Event(detail: 'Event A0'), Event(detail: 'Event B0'), Event(detail: 'Event C0')],
    DateTime(2019, 8, 1): [Event(detail: 'Event A1')],
    DateTime(2019, 8, 8): [Event(detail: 'Event A2'), Event(detail: 'Event B2'), Event(detail: 'Event C2'), Event(detail: 'Event D2')],
    DateTime(2019, 8, 12): [Event(detail: 'Event A3'), Event(detail: 'Event B3')],
    DateTime(2019, 8, 18): [Event(detail: 'Event A4'), Event(detail: 'Event B4'), Event(detail: 'Event C4')],
    DateTime(2019, 8, 24): [Event(detail: 'Event A5'), Event(detail: 'Event B5'), Event(detail: 'Event C5')],
    DateTime(2019, 8, 26): [Event(detail: 'Event A6'), Event(detail: 'Event B6')],
    DateTime(2019, 8, 28): [Event(detail: 'Event A7'), Event(detail: 'Event B7'), Event(detail: 'Event C7'), Event(detail: 'Event D7')],
    DateTime(2019, 8, 29): [Event(detail: 'Event A8'), Event(detail: 'Event B8'), Event(detail: 'Event C8'), Event(detail: 'Event D8')],
    DateTime(2019, 8, 30): [Event(detail: 'Event SK1'), Event(detail: 'Event SK2'), Event(detail: 'Event SK3'), Event(detail: 'Event SK4')],
    DateTime(2019, 9, 1): [Event(detail: 'Event A9'), Event(detail: 'Event B9'), Event(detail: 'Event C9')],
    DateTime(2019, 9, 5): [Event(detail: 'Event A10'), Event(detail: 'Event B10'), Event(detail: 'Event C10')],
    DateTime(2019, 9, 8): [Event(detail: 'Event A11'), Event(detail: 'Event B11')],
    DateTime(2019, 9, 15): [Event(detail: 'Event A12'), Event(detail: 'Event B12'), Event(detail: 'Event C12'), Event(detail: 'Event D12')],
    DateTime(2019, 9, 20): [Event(detail: 'Event A13'), Event(detail: 'Event B13')],
    DateTime(2019, 9, 24): [Event(detail: 'Event A14'), Event(detail: 'Event B14'), Event(detail: 'Event C14')],
  };
  
}

class EventView extends StatelessWidget {

  final List events;
  final VoidCallback onClick;
  final void Function(bool) onDown;
  final ScrollController controller;

  EventView({
    Key key,
    @required this.events,
    this.onClick,
    this.onDown,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener(
        onNotification: (Notification notify) {
          if (notify is UserScrollNotification) {
            if (notify.direction.toString() == 'ScrollDirection.forward') {
              onDown(true);
            }
            else {
              onDown(false);
            }
          }
          return true;
        },
        child: ListView(
          controller: controller,
          physics: BouncingScrollPhysics(),
          children: events.map((event) => EventCard(
            event: event,
            onClick: onClick,
          ))
          .toList(),
        ),
      ),
    );
  }
  
}
