library record_events;

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:long_life_burning/utils/helper/constants.dart'
  show
    RecordState,
    AlignMessage;
import 'package:long_life_burning/utils/providers/all.dart'
  show
    Provider,
    StepCountProvider,
    StopWatchProvider;

part './tooltip.dart';
part './widgets.dart';

class RecordEvent extends StatelessWidget {
  RecordEvent({ Key key }) : super(key: key);
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
              await Navigator.of(context).maybePop();
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
                  await Navigator.of(context).maybePop();
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
