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
    String _category = "";
    MAP_CATEGORIES.forEach((key, value) {
      if (value == event?.category) _category = key;
    });
    return GestureDetector(
      onTap: this.onClick != null ? () => this.onClick(event) : () {},
      child: Card(
        elevation: 2.0,
        shape: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
        child: Container(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(0.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  title: Text(
                    event?.title?.toString() ?? "",
                  ),
                  subtitle: Text(
                    event?.subtitle?.toString() ?? "",
                  ),
                  trailing: Text(
                    "Time: ${event?.date?.hour?.toString()?.padLeft(2, "0") ?? "00"}:${event?.date?.minute?.toString()?.padLeft(2, "0") ?? "00"}",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        "Province: ${event?.province ?? ""}",
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        "Category: ${_category ?? ""}",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}