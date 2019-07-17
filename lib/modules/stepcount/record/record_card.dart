import 'package:flutter/material.dart';
import 'record_info.dart';

class RecordCard extends StatelessWidget {

  final RecordInfo record;
  final void Function() onClick;

  RecordCard({
    Key key,
    this.record,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        title: Text(record.detail.toString()),
        onTap: onClick,
      ),
    );
  }
}