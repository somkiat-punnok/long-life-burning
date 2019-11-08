part of record_events;

class ButtonWidget extends StatelessWidget {

  final StepCountProvider provider;
  final StopWatchProvider stopwatch;
  final VoidCallback onEnd;

  ButtonWidget({
    Key key,
    @required this.provider,
    @required this.stopwatch,
    this.onEnd,
  }) :  assert(provider != null),
        assert(stopwatch != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (provider.state) {
      case RecordState.INIT:
        return GestureDetector(
          onTap: () {
            provider.startListening();
            stopwatch.start();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            constraints: BoxConstraints.tightFor(
              width: 108.0,
              height: 108.0,
            ),
            child: Center(
              child: Text(
                "GO",
                style: TextStyle(
                  fontSize: 48.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
        break;
      case RecordState.START:
        return CustomTooltip(
          message: "Hold on button for finish",
          align: AlignMessage.BOTTOM,
          child: GestureDetector(
            onLongPress: () {
              provider.stopListening();
              stopwatch.stop();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints.tightFor(
                width: 108.0,
                height: 108.0,
              ),
              child: Center(
                child: Icon(
                  Icons.stop,
                  size: 64.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
        break;
      case RecordState.STOP:
        return Container(
          child: OutlineButton(
            onPressed: this.onEnd ?? () {
              provider.reset();
              stopwatch.reset();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Record Data and Exit".toUpperCase(),
              ),
            ),
          ),
        );
        break;
      default:
        return Container(
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          constraints: BoxConstraints.tightFor(
            width: 108.0,
            height: 108.0,
          ),
          child: Center(
            child: Text(
              "GO",
              style: TextStyle(
                fontSize: 48.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
    }
  }
}

class DataWidget extends StatelessWidget {

  final String title;
  final String value;

  DataWidget({
    Key key,
    @required this.title,
    @required this.value,
  }) :  assert(title != null),
        assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              this.value ?? "",
              style: TextStyle(
                color: Colors.black,
                fontSize: 32.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              this.title ?? "",
              style: TextStyle(
                color: CupertinoColors.inactiveGray,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
