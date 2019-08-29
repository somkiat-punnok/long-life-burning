library record;

import 'dart:async';
import 'dart:convert';
// import 'dart:io' show Directory;
import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';
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
    id: map[columnId],
    day: map[columnDay],
    step: map[columnStep],
    cal: map[columnCal],
    dist: map[columnDist],
    detail: map["detail"],
  );

  factory Record.fromJson(String str) {
    final jsonData = json.decode(str);
    return Record.fromMap(jsonData);
  }

  Map<String, dynamic> toMap() => {
    columnDay: day ?? '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}',
    columnStep: step ?? 0,
    columnCal: cal ?? 0.0,
    columnDist: dist ?? 0.0,
    "detail": detail,
  };

  String toJson(Record data) {
    final Map<String, dynamic> dyn = data.toMap();
    return json.encode(dyn);
  }

}

class RecordList {

  static final Map<DateTime, List<Record>> records = {
    _buildSub(1): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildSub(2): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildSub(3): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildSub(4): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildSub(5): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildSub(6): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildSub(7): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildSub(8): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildSub(9): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildSub(10): [Record(step: 0, cal: 0.0, dist: 0.0)],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildAdd(1): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildAdd(2): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildAdd(3): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildAdd(4): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildAdd(5): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildAdd(6): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildAdd(7): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildAdd(8): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildAdd(9): [Record(step: 0, cal: 0.0, dist: 0.0)],
    _buildAdd(10): [Record(step: 0, cal: 0.0, dist: 0.0)],
  };

  static DateTime _buildSub(int i) {
    DateTime temp = DateTime.now().subtract(Duration(days: i));
    return DateTime(temp.year, temp.month, temp.day);
  }

  static DateTime _buildAdd(int i) {
    DateTime temp = DateTime.now().add(Duration(days: i));
    return DateTime(temp.year, temp.month, temp.day);
  }
  
}

class RecordToList extends StatelessWidget {

  final List records;
  final int step;
  final double cal;
  final double dist;

  RecordToList({
    Key key,
    this.records,
    this.step,
    this.cal,
    this.dist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: (records != null && records.isNotEmpty) || (step != null && cal != null && dist != null)
            ? <Widget>[
              RecordCard(
                value: step != null ? step.toString() : records.first.step.toString(),
                name: 'steps',
                unit: 'step',
              ),
              RecordCard(
                value: cal != null ? cal.toString() : records.first.cal.toString(),
                name: 'calories',
                unit: 'kCal',
              ),
              RecordCard(
                value: dist != null ? dist.toString() : records.first.dist.toString(),
                name: 'distances',
                unit: 'km',
              ),
            ]
          : <Widget>[],
      ),
    );
  }
  
}
