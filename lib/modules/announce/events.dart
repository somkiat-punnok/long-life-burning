import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Event {

  static final Map<DateTime, List> events = {
    DateTime(2019, 5, 29): ['Event A0', 'Event B0', 'Event C0'],
    DateTime(2019, 6, 1): ['Event A1'],
    DateTime(2019, 6, 8): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
    DateTime(2019, 6, 12): ['Event A3', 'Event B3'],
    DateTime(2019, 6, 18): ['Event A4', 'Event B4', 'Event C4'],
    DateTime(2019, 6, 24): ['Event A5', 'Event B5', 'Event C5'],
    DateTime(2019, 6, 26): ['Event A6', 'Event B6'],
    DateTime(2019, 6, 28): ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
    DateTime(2019, 6, 29): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
    DateTime(2019, 6, 30): ['Event SK1', 'Event SK2', 'Event SK3', 'Event SK4'],
    DateTime(2019, 7, 1): ['Event A9', 'Event A9', 'Event B9'],
    DateTime(2019, 7, 5): ['Event A10', 'Event B10', 'Event C10'],
    DateTime(2019, 7, 8): ['Event A11', 'Event B11'],
    DateTime(2019, 7, 15): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
    DateTime(2019, 7, 20): ['Event A13', 'Event B13'],
    DateTime(2019, 7, 24): ['Event A14', 'Event B14', 'Event C14'],
  };
  
}

class EventList extends StatefulWidget {

  final List events;

  EventList({
    Key key,
    this.events,
  }) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: widget.events
          .map((event) => Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.8),
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              title: Text(event.toString()),
              onTap: () => print('$event tapped!'),
            ),
          ))
          .toList(),
      ),
    );
  }
}