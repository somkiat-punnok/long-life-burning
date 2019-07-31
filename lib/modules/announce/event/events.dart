import 'package:flutter/material.dart';
import 'event_card.dart';

class Event {

  final String id,detail;
  
  Event({
    this.id,
    this.detail,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json["id"],
      detail: json["detail"],
    );
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["detail"] = detail;
    return map;
  }

  factory Event.fromDB(Map<String, dynamic> map) {
    return Event(
      id: map["id"],
      detail: map["detail"],
    );
  }

}

class EventList {

  static final Map<DateTime, List> events = {
    DateTime(2019, 5, 29): [Event(detail: 'Event A0'), Event(detail: 'Event B0'), Event(detail: 'Event C0')],
    DateTime(2019, 6, 1): [Event(detail: 'Event A1')],
    DateTime(2019, 6, 8): [Event(detail: 'Event A2'), Event(detail: 'Event B2'), Event(detail: 'Event C2'), Event(detail: 'Event D2')],
    DateTime(2019, 6, 12): [Event(detail: 'Event A3'), Event(detail: 'Event B3')],
    DateTime(2019, 6, 18): [Event(detail: 'Event A4'), Event(detail: 'Event B4'), Event(detail: 'Event C4')],
    DateTime(2019, 6, 24): [Event(detail: 'Event A5'), Event(detail: 'Event B5'), Event(detail: 'Event C5')],
    DateTime(2019, 6, 26): [Event(detail: 'Event A6'), Event(detail: 'Event B6')],
    DateTime(2019, 6, 28): [Event(detail: 'Event A7'), Event(detail: 'Event B7'), Event(detail: 'Event C7'), Event(detail: 'Event D7')],
    DateTime(2019, 6, 29): [Event(detail: 'Event A8'), Event(detail: 'Event B8'), Event(detail: 'Event C8'), Event(detail: 'Event D8')],
    DateTime(2019, 6, 30): [Event(detail: 'Event SK1'), Event(detail: 'Event SK2'), Event(detail: 'Event SK3'), Event(detail: 'Event SK4')],
    DateTime(2019, 7, 1): [Event(detail: 'Event A9'), Event(detail: 'Event B9'), Event(detail: 'Event C9')],
    DateTime(2019, 7, 5): [Event(detail: 'Event A10'), Event(detail: 'Event B10'), Event(detail: 'Event C10')],
    DateTime(2019, 7, 8): [Event(detail: 'Event A11'), Event(detail: 'Event B11')],
    DateTime(2019, 7, 15): [Event(detail: 'Event A12'), Event(detail: 'Event B12'), Event(detail: 'Event C12'), Event(detail: 'Event D12')],
    DateTime(2019, 7, 20): [Event(detail: 'Event A13'), Event(detail: 'Event B13')],
    DateTime(2019, 7, 24): [Event(detail: 'Event A14'), Event(detail: 'Event B14'), Event(detail: 'Event C14')],
  };
  
}

class EventToList extends StatelessWidget {

  final List events;
  final VoidCallback onClick;

  EventToList({
    Key key,
    this.events,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: events.map((event) => EventCard(
          event: event,
          onClick: onClick,
        ))
        .toList(),
      ),
    );
  }
  
}
