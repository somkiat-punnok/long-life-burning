library feedback;

import 'package:flutter/material.dart';

part './rating.dart';

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
