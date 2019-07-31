import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/stepcount/record/record_card.dart';

class Record {

  final String id,detail;
  
  Record({
    this.id,
    this.detail,
  });

  Record.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      detail = json["detail"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["detail"] = detail;
    return map;
  }

  Record.fromDB(Map<String, dynamic> map)
    : id = map["id"],
      detail = map["detail"];

}

class RecordList {

  static final Map<DateTime, List<Record>> records = {
    DateTime(2019, 5, 29): [Record(detail: 'STEP A0'), Record(detail: 'STEP B0'), Record(detail: 'STEP C0')],
    DateTime(2019, 6, 1): [Record(detail: 'STEP A1')],
    DateTime(2019, 6, 8): [Record(detail: 'STEP A2'), Record(detail: 'STEP B2'), Record(detail: 'STEP C2'), Record(detail: 'STEP D2')],
    DateTime(2019, 6, 12): [Record(detail: 'STEP A3'), Record(detail: 'STEP B3')],
    DateTime(2019, 6, 18): [Record(detail: 'STEP A4'), Record(detail: 'STEP B4'), Record(detail: 'STEP C4')],
    DateTime(2019, 6, 24): [Record(detail: 'STEP A5'), Record(detail: 'STEP B5'), Record(detail: 'STEP C5')],
    DateTime(2019, 6, 26): [Record(detail: 'STEP A6'), Record(detail: 'STEP B6')],
    DateTime(2019, 6, 28): [Record(detail: 'STEP A7'), Record(detail: 'STEP B7'), Record(detail: 'STEP C7'), Record(detail: 'STEP D7')],
    DateTime(2019, 6, 29): [Record(detail: 'STEP A8'), Record(detail: 'STEP B8'), Record(detail: 'STEP C8'), Record(detail: 'STEP D8')],
    DateTime(2019, 6, 30): [Record(detail: 'STEP SK1'), Record(detail: 'STEP SK2'), Record(detail: 'STEP SK3'), Record(detail: 'STEP SK4')],
    DateTime(2019, 7, 1): [Record(detail: 'STEP A9'), Record(detail: 'STEP B9'), Record(detail: 'STEP C9')],
    DateTime(2019, 7, 5): [Record(detail: 'STEP A10'), Record(detail: 'STEP B10'), Record(detail: 'STEP C10')],
    DateTime(2019, 7, 8): [Record(detail: 'STEP A11'), Record(detail: 'STEP B11')],
    DateTime(2019, 7, 15): [Record(detail: 'STEP A12'), Record(detail: 'STEP B12'), Record(detail: 'STEP C12'), Record(detail: 'STEP D12')],
    DateTime(2019, 7, 20): [Record(detail: 'STEP A13'), Record(detail: 'STEP B13')],
    DateTime(2019, 7, 24): [Record(detail: 'STEP A14'), Record(detail: 'STEP B14'), Record(detail: 'STEP C14')],
  };
  
}

class RecordToList extends StatelessWidget {

  final List records;

  RecordToList({
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
