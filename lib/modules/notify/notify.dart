library notify;

import 'dart:convert';
import 'package:flutter/material.dart';

part './notify_card.dart';
part './notify_model.dart';

class NotifyWidget extends StatelessWidget {

  final List<Notify> notify;

  NotifyWidget({
    Key key,
    this.notify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.notify != null ? SingleChildScrollView(
      child: Column(
        children: List<Widget>.generate(
          this.notify.length,
          (int i) => NotifyCard(
            title: this.notify[i].title ?? "",
            body: this.notify[i].body ?? "",
          ),
        ),
      ),
    ) : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Hasn\'t notifications.',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
