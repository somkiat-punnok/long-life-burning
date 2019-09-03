part of event;

class EventCard extends StatelessWidget {

  final Event event;
  final void Function() onClick;

  EventCard({
    Key key,
    this.event,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        title: Text(event.detail.toString()),
        onTap: onClick,
      ),
    );
  }
}