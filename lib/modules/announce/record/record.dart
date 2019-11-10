library record_events;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:flutter/gestures.dart'
  show
    GestureBinding,
    PointerExitEvent,
    PointerEnterEvent;
import 'package:flutter/rendering.dart'
  show
    RendererBinding,
    SemanticsService;
import 'package:cloud_firestore/cloud_firestore.dart'
  show
    Firestore,
    DocumentReference;
import 'package:long_life_burning/screen/index.dart';
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    Configs,
    RecordState,
    AlignMessage;
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    StepCountProvider,
    StopWatchProvider;
import '../feedback/feedback.dart' show showFeedBackDialog;

part './tooltip.dart';
part './widgets.dart';

class RecordEvent extends StatelessWidget {

  final String userId;
  final String eventId;

  RecordEvent({
    Key key,
    this.userId = "",
    this.eventId = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StepCountProvider provider = Provider.of<StepCountProvider>(context);
    final StopWatchProvider stopwatch = Provider.of<StopWatchProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        actions: provider.state == RecordState.INIT ? <Widget>[
          GestureDetector(
            onLongPress: () async {
              provider.stopListening();
              provider.reset();
              stopwatch.stop();
              stopwatch.reset();
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Index(),
                ),
              );
            },
            child: CustomTooltip(
              message: "Hold on button for exit",
              align: AlignMessage.CENTERLEFT,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ] : null,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        provider?.distences?.toStringAsFixed(2) ?? "0.00",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 116.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Kilometers",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DataWidget(
                      title: "Calories",
                      value: provider?.calories?.toStringAsFixed(2) ?? "0",
                    ),
                    DataWidget(
                      title: "Duration",
                      value: (stopwatch?.hour ?? 0) > 0
                        ? "${stopwatch?.hour.toString().padLeft(2, "0") ?? "00"}:${stopwatch?.minute.toString().padLeft(2, "0") ?? "00"}:${stopwatch?.second.toString().padLeft(2, "0") ?? "00"}"
                        : "${stopwatch?.minute.toString().padLeft(2, "0") ?? "00"}:${stopwatch?.second.toString().padLeft(2, "0") ?? "00"}",
                    ),
                    DataWidget(
                      title: "Avg.Pace",
                      value: provider?.avgPace ?? "00:00",
                    ),
                  ],
                ),
              ),
              ButtonWidget(
                provider: provider,
                stopwatch: stopwatch,
                onEnd: () async {
                  await showFeedBackDialog(
                    context: context,
                    eventId: eventId,
                  );
                  final DocumentReference userRef = Firestore.instance
                      .collection(Configs.collection_user)
                      .document(userId)
                      .collection("events")
                      .document(eventId);
                  final List<String> _avgPace = provider?.avgPace?.split(":") ?? <String>[];
                  num _hour = 0, _minute = 0, _second = 0;
                  if (_avgPace.isNotEmpty) {
                    switch (_avgPace.length) {
                      case 2:
                        _minute = num.parse(_avgPace[0]) ?? 0;
                        _second = num.parse(_avgPace[1]) ?? 0;
                        break;
                      case 3:
                        _hour = num.parse(_avgPace[0]) ?? 0;
                        _minute = num.parse(_avgPace[1]) ?? 0;
                        _second = num.parse(_avgPace[2]) ?? 0;
                        break;
                      default:
                        _hour = 0;
                        _minute = 0;
                        _second = 0;
                    }
                  }
                  await userRef.setData({
                    "recordDate": DateTime.now(),
                    "duration": {
                      "hour": stopwatch?.hour ?? 0,
                      "minute": stopwatch?.minute ?? 0,
                      "second": stopwatch?.second ?? 0,
                    },
                    "avgpace": {
                      "hour": _hour ?? 0,
                      "minute": _minute ?? 0,
                      "second": _second ?? 0,
                    },
                    "calories": provider?.calories ?? 0.0,
                    "distance": provider?.distences ?? 0.0,
                  }, merge: true);
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Index(),
                    ),
                  );
                  provider?.reset();
                  stopwatch?.reset();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
