part of notify;

class NotifyCard extends StatelessWidget {

  final String title;
  final String body;

  NotifyCard({
    Key key,
    this.title,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: OutlineInputBorder(
        borderSide: BorderSide(width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0.0),
          title: Text(
            this.title ?? "",
          ),
          subtitle: Text(
            this.body ?? "",
          ),
        ),
      ),
    );
  }
}
