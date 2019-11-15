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
    List<Notify> _notify = this.notify.where((n) => 0 > (n?.date?.difference(DateTime.now())?.inSeconds ?? 0)).toList();
    return _notify != null && _notify.isNotEmpty ? SingleChildScrollView(
      child: Column(
        children: List<Widget>.generate(
          _notify.length,
          (int i) => NotifyCard(
            title: _notify[i].title ?? "",
            body: _notify[i].body ?? "",
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
