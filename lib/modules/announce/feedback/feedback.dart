library feedback;

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
  show
    Firestore,
    DocumentReference;
import 'package:long_life_burning/utils/helper/constants.dart' show Configs;

part './rating.dart';

Future<T> showFeedBackDialog<T>({ BuildContext context, String eventId }) async {
  num _rating;
  String _comment;
  return await showDialog<T>(
    context: context,
    builder: (BuildContext context) => FeedBack(
      title: "Feedback",
      subtitle: "Please send feedback",
      onRating: (double rate) => _rating = rate,
      onComment: (String message) => _comment = message,
      onSend: () async {
        final DocumentReference eventRef = Firestore.instance
            .collection(Configs.collection_event)
            .document(eventId);
        await eventRef.collection("feedback").add({
          "date": DateTime.now(),
          "rate": _rating ?? 0,
          "comment": _comment ?? "",
        });
        await Navigator.of(context).maybePop();
      },
      onCancel: () async => await Navigator.of(context).maybePop(),
    ),
  );
}

class FeedBack extends StatelessWidget {
  final String title;
  final String subtitle;
  final ValueChanged<double> onRating;
  final ValueChanged<String> onComment;
  final VoidCallback onSend;
  final VoidCallback onCancel;

  FeedBack({
    Key key,
    this.title,
    this.subtitle,
    this.onRating,
    this.onComment,
    this.onSend,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(8.0),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              this.title ?? "",
            ),
          ),
          Divider(),
        ],
      ),
      contentPadding: const EdgeInsets.all(8.0),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                this.subtitle ?? "",
              ),
            ),
            RatingStar(
              onRating: this.onRating,
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Feedback Comments",
                ),
                onChanged: this.onComment,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Wrap(
          alignment: WrapAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: this.onCancel ?? () {},
            ),
            FlatButton(
              child: Text("Send"),
              onPressed: this.onSend ?? () {},
            ),
          ],
        ),
      ],
    );
  }
}
