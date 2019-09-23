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

part './db.dart';
part './record_model.dart';
part './record_card.dart';

final String tableName = 'record';
final String columnId = 'id';
final String columnDay = 'day';
final String columnStep = 'step';
final String columnCal = 'cal';
final String columnDist = 'dist';

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
