import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:long_life_burning/modules/event/event_info.dart';
import 'package:long_life_burning/modules/event/event_card.dart';

class Event {

  static final Map<DateTime, List<EventInfo>> events = {
    DateTime(2019, 5, 29): [EventInfo(detail: 'Event A0'), EventInfo(detail: 'Event B0'), EventInfo(detail: 'Event C0')],
    DateTime(2019, 6, 1): [EventInfo(detail: 'Event A1')],
    DateTime(2019, 6, 8): [EventInfo(detail: 'Event A2'), EventInfo(detail: 'Event B2'), EventInfo(detail: 'Event C2'), EventInfo(detail: 'Event D2')],
    DateTime(2019, 6, 12): [EventInfo(detail: 'Event A3'), EventInfo(detail: 'Event B3')],
    DateTime(2019, 6, 18): [EventInfo(detail: 'Event A4'), EventInfo(detail: 'Event B4'), EventInfo(detail: 'Event C4')],
    DateTime(2019, 6, 24): [EventInfo(detail: 'Event A5'), EventInfo(detail: 'Event B5'), EventInfo(detail: 'Event C5')],
    DateTime(2019, 6, 26): [EventInfo(detail: 'Event A6'), EventInfo(detail: 'Event B6')],
    DateTime(2019, 6, 28): [EventInfo(detail: 'Event A7'), EventInfo(detail: 'Event B7'), EventInfo(detail: 'Event C7'), EventInfo(detail: 'Event D7')],
    DateTime(2019, 6, 29): [EventInfo(detail: 'Event A8'), EventInfo(detail: 'Event B8'), EventInfo(detail: 'Event C8'), EventInfo(detail: 'Event D8')],
    DateTime(2019, 6, 30): [EventInfo(detail: 'Event SK1'), EventInfo(detail: 'Event SK2'), EventInfo(detail: 'Event SK3'), EventInfo(detail: 'Event SK4')],
    DateTime(2019, 7, 1): [EventInfo(detail: 'Event A9'), EventInfo(detail: 'Event B9'), EventInfo(detail: 'Event C9')],
    DateTime(2019, 7, 5): [EventInfo(detail: 'Event A10'), EventInfo(detail: 'Event B10'), EventInfo(detail: 'Event C10')],
    DateTime(2019, 7, 8): [EventInfo(detail: 'Event A11'), EventInfo(detail: 'Event B11')],
    DateTime(2019, 7, 15): [EventInfo(detail: 'Event A12'), EventInfo(detail: 'Event B12'), EventInfo(detail: 'Event C12'), EventInfo(detail: 'Event D12')],
    DateTime(2019, 7, 20): [EventInfo(detail: 'Event A13'), EventInfo(detail: 'Event B13')],
    DateTime(2019, 7, 24): [EventInfo(detail: 'Event A14'), EventInfo(detail: 'Event B14'), EventInfo(detail: 'Event C14')],
  };
  
}

class EventList extends StatelessWidget {

  final List events;

  EventList({
    Key key,
    this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: events.map((event) => EventCard(event: event,)).toList(),
      ),
    );
  }
}