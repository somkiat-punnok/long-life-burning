library record;

import 'dart:io';
import 'dart:async';
import 'dart:convert';
// import 'dart:io' show Directory;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';

part 'db.dart';
part 'record_card.dart';

class Record {

  int id;
  String day;
  int step;
  double cal;
  double dist;
  String detail;
  
  Record({
    this.id,
    this.day,
    this.step,
    this.cal,
    this.dist,
    this.detail,
  });

  factory Record.fromMap(Map<String, dynamic> map) => Record(
    id: int.parse(map[columnId]),
    day: map[columnDay],
    step: int.parse(map[columnStep]),
    cal: double.parse(map[columnCal]),
    dist: double.parse(map[columnDist]),
    detail: map["detail"],
  );

  factory Record.fromJson(String s) => Record.fromMap(json.decode(s));

  Map<String, dynamic> toMap() => {
    columnId: this.id ?? 0,
    columnDay: this.day ?? '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}',
    columnStep: this.step ?? 0,
    columnCal: this.cal ?? 0.0,
    columnDist: this.dist ?? 0.0,
    "detail": this.detail,
  };

  String toJson(Record data) => json.encode(this.toMap());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Record &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              day == other.day &&
              step == other.step &&
              cal == other.cal &&
              dist == other.dist &&
              detail == other.detail;

  @override
  int get hashCode => id.hashCode ^ day.hashCode ^ step.hashCode ^ cal.hashCode ^ dist.hashCode ^ detail.hashCode;

  @override
  String toString() {
    return '$runtimeType{day: $day, step: $step, cal: $cal, dist: $dist}';
  }

}

class RecordToList extends StatelessWidget {

  final num step;
  final num cal;
  final num dist;

  RecordToList({
    Key key,
    this.step,
    this.cal,
    this.dist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ((step != null && step != 0) || (cal != null && cal != 0) || (dist != null && dist != 0))
          ? ListView(
              children: <Widget>[
                RecordCard(
                  value: '${NumberFormat('#,###', 'en_US').format(step)}',
                  name: 'steps',
                  unit: 'step',
                ),
                RecordCard(
                  value: '${NumberFormat('#,###.##', 'en_US').format(cal)}',
                  name: 'calories',
                  unit: 'kCal',
                ),
                RecordCard(
                  value: '${NumberFormat('#.##', 'en_US').format(dist/1000)}',
                  name: 'distances',
                  unit: 'km',
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'No Data',
                    style: TextStyle(
                      fontSize: 36.0,
                      color: CupertinoColors.darkBackgroundGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'No data recorded for this day.',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: CupertinoColors.darkBackgroundGray,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
  
}
