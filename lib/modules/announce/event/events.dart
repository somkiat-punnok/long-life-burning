library event;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;

part './event_model.dart';
part './event_card.dart';
part './event_list.dart';

class Event {
  static final Map<DateTime, List> events = {
    DateTime(2019, 9, 29): [EventModel(detail: 'Event A0'), EventModel(detail: 'Event B0'), EventModel(detail: 'Event C0')],
    DateTime(2019, 10, 1): [EventModel(detail: 'Event A1')],
    DateTime(2019, 10, 8): [EventModel(detail: 'Event A2'), EventModel(detail: 'Event B2'), EventModel(detail: 'Event C2'), EventModel(detail: 'Event D2')],
    DateTime(2019, 10, 12): [EventModel(detail: 'Event A3'), EventModel(detail: 'Event B3')],
    DateTime(2019, 10, 18): [EventModel(detail: 'Event A4'), EventModel(detail: 'Event B4'), EventModel(detail: 'Event C4')],
    DateTime(2019, 10, 24): [EventModel(detail: 'Event A5'), EventModel(detail: 'Event B5'), EventModel(detail: 'Event C5')],
    DateTime(2019, 10, 26): [EventModel(detail: 'Event A6'), EventModel(detail: 'Event B6')],
    DateTime(2019, 10, 28): [EventModel(detail: 'Event A7'), EventModel(detail: 'Event B7'), EventModel(detail: 'Event C7'), EventModel(detail: 'Event D7')],
    DateTime(2019, 10, 29): [EventModel(detail: 'Event A8'), EventModel(detail: 'Event B8'), EventModel(detail: 'Event C8'), EventModel(detail: 'Event D8')],
    DateTime(2019, 10, 30): [
      EventModel(detail: 'Event SK1'),
      EventModel(detail: 'Event SK2'),
      EventModel(detail: 'Event SK3'),
      EventModel(detail: 'Event SK4'),
      EventModel(detail: 'Event SK5'),
      EventModel(detail: 'Event SK6'),
      EventModel(detail: 'Event SK7'),
      EventModel(detail: 'Event SK8'),
      EventModel(detail: 'Event SK9'),
      EventModel(detail: 'Event SK10'),
      EventModel(detail: 'Event SK11'),
      EventModel(detail: 'Event SK12'),
    ],
    DateTime(2019, 11, 1): [EventModel(detail: 'Event A9'), EventModel(detail: 'Event B9'), EventModel(detail: 'Event C9')],
    DateTime(2019, 11, 5): [EventModel(detail: 'Event A10'), EventModel(detail: 'Event B10'), EventModel(detail: 'Event C10')],
    DateTime(2019, 11, 8): [EventModel(detail: 'Event A11'), EventModel(detail: 'Event B11')],
    DateTime(2019, 11, 15): [EventModel(detail: 'Event A12'), EventModel(detail: 'Event B12'), EventModel(detail: 'Event C12'), EventModel(detail: 'Event D12')],
    DateTime(2019, 11, 20): [EventModel(detail: 'Event A13'), EventModel(detail: 'Event B13')],
    DateTime(2019, 11, 24): [EventModel(detail: 'Event A14'), EventModel(detail: 'Event B14'), EventModel(detail: 'Event C14')],
  };
}

class EventView extends StatelessWidget {

  final List events;
  final VoidCallback onClick;

  EventView({
    Key key,
    @required this.events,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: events.isNotEmpty
        ? ListView(
            children: events.map((event) => EventCard(
              event: event,
              onClick: onClick,
            ))
            .toList(),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'No Event',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: CupertinoColors.darkBackgroundGray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'No event for this day.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: CupertinoColors.darkBackgroundGray,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
    );
  }

}
