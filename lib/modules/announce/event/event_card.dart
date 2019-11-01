part of event;

class EventCard extends StatelessWidget {

  final Event event;
  final EventCallback onClick;

  EventCard({
    Key key,
    this.event,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: OutlineInputBorder(
        borderSide: BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: ListTile(
        title: Text(event.title.toString()),
        subtitle: Text(event.subtitle.toString()),
        onTap: () => this.onClick != null ? this.onClick(event) : () {},
      ),
    );
  }
}