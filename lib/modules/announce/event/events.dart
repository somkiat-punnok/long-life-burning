library event;

import 'dart:convert';
import 'package:flutter/material.dart';

part './event_model.dart';
part './event_card.dart';
part './event_list.dart';

class Event {
  static final Map<DateTime, List> events = {
    DateTime(2019, 8, 29): [EventModel(detail: 'Event A0'), EventModel(detail: 'Event B0'), EventModel(detail: 'Event C0')],
    DateTime(2019, 9, 1): [EventModel(detail: 'Event A1')],
    DateTime(2019, 9, 8): [EventModel(detail: 'Event A2'), EventModel(detail: 'Event B2'), EventModel(detail: 'Event C2'), EventModel(detail: 'Event D2')],
    DateTime(2019, 9, 12): [EventModel(detail: 'Event A3'), EventModel(detail: 'Event B3')],
    DateTime(2019, 9, 18): [EventModel(detail: 'Event A4'), EventModel(detail: 'Event B4'), EventModel(detail: 'Event C4')],
    DateTime(2019, 9, 24): [EventModel(detail: 'Event A5'), EventModel(detail: 'Event B5'), EventModel(detail: 'Event C5')],
    DateTime(2019, 9, 26): [EventModel(detail: 'Event A6'), EventModel(detail: 'Event B6')],
    DateTime(2019, 9, 28): [EventModel(detail: 'Event A7'), EventModel(detail: 'Event B7'), EventModel(detail: 'Event C7'), EventModel(detail: 'Event D7')],
    DateTime(2019, 9, 29): [EventModel(detail: 'Event A8'), EventModel(detail: 'Event B8'), EventModel(detail: 'Event C8'), EventModel(detail: 'Event D8')],
    DateTime(2019, 9, 30): [EventModel(detail: 'Event SK1'), EventModel(detail: 'Event SK2'), EventModel(detail: 'Event SK3'), EventModel(detail: 'Event SK4')],
    DateTime(2019, 10, 1): [EventModel(detail: 'Event A9'), EventModel(detail: 'Event B9'), EventModel(detail: 'Event C9')],
    DateTime(2019, 10, 5): [EventModel(detail: 'Event A10'), EventModel(detail: 'Event B10'), EventModel(detail: 'Event C10')],
    DateTime(2019, 10, 8): [EventModel(detail: 'Event A11'), EventModel(detail: 'Event B11')],
    DateTime(2019, 10, 15): [EventModel(detail: 'Event A12'), EventModel(detail: 'Event B12'), EventModel(detail: 'Event C12'), EventModel(detail: 'Event D12')],
    DateTime(2019, 10, 20): [EventModel(detail: 'Event A13'), EventModel(detail: 'Event B13')],
    DateTime(2019, 10, 24): [EventModel(detail: 'Event A14'), EventModel(detail: 'Event B14'), EventModel(detail: 'Event C14')],
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
