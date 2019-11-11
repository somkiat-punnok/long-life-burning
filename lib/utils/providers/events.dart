part of providers;

class EventProvider extends ChangeNotifier {
  List<Event> _events = <Event>[];

  List<Event> get events => _events;

  set events(List<Event> newValue) {
    _events = newValue;
  }
}
