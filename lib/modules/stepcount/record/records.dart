import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/stepcount/record/record_info.dart';
import 'package:long_life_burning/modules/stepcount/record/record_card.dart';

export 'package:long_life_burning/modules/stepcount/record/record_info.dart';

class Record {

  static final Map<DateTime, List<RecordInfo>> records = {
    DateTime(2019, 5, 29): [RecordInfo(detail: 'STEP A0'), RecordInfo(detail: 'STEP B0'), RecordInfo(detail: 'STEP C0')],
    DateTime(2019, 6, 1): [RecordInfo(detail: 'STEP A1')],
    DateTime(2019, 6, 8): [RecordInfo(detail: 'STEP A2'), RecordInfo(detail: 'STEP B2'), RecordInfo(detail: 'STEP C2'), RecordInfo(detail: 'STEP D2')],
    DateTime(2019, 6, 12): [RecordInfo(detail: 'STEP A3'), RecordInfo(detail: 'STEP B3')],
    DateTime(2019, 6, 18): [RecordInfo(detail: 'STEP A4'), RecordInfo(detail: 'STEP B4'), RecordInfo(detail: 'STEP C4')],
    DateTime(2019, 6, 24): [RecordInfo(detail: 'STEP A5'), RecordInfo(detail: 'STEP B5'), RecordInfo(detail: 'STEP C5')],
    DateTime(2019, 6, 26): [RecordInfo(detail: 'STEP A6'), RecordInfo(detail: 'STEP B6')],
    DateTime(2019, 6, 28): [RecordInfo(detail: 'STEP A7'), RecordInfo(detail: 'STEP B7'), RecordInfo(detail: 'STEP C7'), RecordInfo(detail: 'STEP D7')],
    DateTime(2019, 6, 29): [RecordInfo(detail: 'STEP A8'), RecordInfo(detail: 'STEP B8'), RecordInfo(detail: 'STEP C8'), RecordInfo(detail: 'STEP D8')],
    DateTime(2019, 6, 30): [RecordInfo(detail: 'STEP SK1'), RecordInfo(detail: 'STEP SK2'), RecordInfo(detail: 'STEP SK3'), RecordInfo(detail: 'STEP SK4')],
    DateTime(2019, 7, 1): [RecordInfo(detail: 'STEP A9'), RecordInfo(detail: 'STEP B9'), RecordInfo(detail: 'STEP C9')],
    DateTime(2019, 7, 5): [RecordInfo(detail: 'STEP A10'), RecordInfo(detail: 'STEP B10'), RecordInfo(detail: 'STEP C10')],
    DateTime(2019, 7, 8): [RecordInfo(detail: 'STEP A11'), RecordInfo(detail: 'STEP B11')],
    DateTime(2019, 7, 15): [RecordInfo(detail: 'STEP A12'), RecordInfo(detail: 'STEP B12'), RecordInfo(detail: 'STEP C12'), RecordInfo(detail: 'STEP D12')],
    DateTime(2019, 7, 20): [RecordInfo(detail: 'STEP A13'), RecordInfo(detail: 'STEP B13')],
    DateTime(2019, 7, 24): [RecordInfo(detail: 'STEP A14'), RecordInfo(detail: 'STEP B14'), RecordInfo(detail: 'STEP C14')],
  };
  
}

class RecordList extends StatelessWidget {

  final List records;

  RecordList({
    Key key,
    this.records,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: records.map((record) => RecordCard(
          record: record,
          onClick: () => Navigator.pop(context),
        ))
        .toList(),
      ),
    );
  }
}
