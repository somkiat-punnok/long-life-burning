import 'dart:async';
// import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:long_life_burning/modules/stepcount/record/record_card.dart';

final String tableName = 'record';
final String columnId = 'id';
final String columnDay = 'day';
final String columnStep = 'step';
final String columnCal = 'cal';
final String columnDist = 'dist';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnDay: day ?? '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}',
      columnStep: step ?? 0,
      columnCal: cal ?? 0.0,
      columnDist: dist ?? 0.0,
      "detail": detail,
    };
  }

  Record.fromDB(Map<String, dynamic> map)
    : id = map[columnId],
      day = map[columnDay],
      step = map[columnStep],
      cal = map[columnCal],
      dist = map[columnDist],
      detail = map["detail"];

}

class RecordProvider {

  RecordProvider._internal();

  static RecordProvider _shared = RecordProvider._internal();
  static RecordProvider get shared => _shared;

  Database db;

  Future init() async {
    final String name = 'record.db';
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, name);
    Database db = await openDatabase(path, version: 1, onCreate: _create);
    print('DB INITIATED WITH PATH : $path');
    this.db = db;
    return db;
  }

  Future _create(Database db, int version) async {
    await db.transaction((t) async {
      await t.execute('''
        CREATE TABLE IF NOT EXISTS $tableName (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnDay TEXT NOT NULL,
          $columnStep INTEGER NOT NULL,
          $columnCal REAL NOT NULL,
          $columnDist REAL NOT NULL
        );
      ''');
    });
  }

  Future<Record> insert(Record record) async {
    record.id = await db.insert(tableName, record.toMap());
    return record;
  }

  Future<Record> getRecord(int id) async {
    List<Map> maps = await db.query(
      tableName,
      columns: [columnDay, columnStep, columnCal, columnDist],
      where: '$columnId = ?',
      whereArgs: [id]
    );
    if (maps.length > 0) {
      return Record.fromDB(maps.first);
    }
    return null;
  }

  Future<int> update(Record record) async => await db.update(
    tableName,
    record.toMap(),
    where: '$columnId = ?',
    whereArgs: [record.id]
  );

  Future<int> delete(int id) async => await db.delete(
    tableName,
    where: '$columnId = ?',
    whereArgs: [id]
  );

  Future close() async => db.close();

}

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io' show Directory;
// import 'package:sqflite/sqflite.dart';
// import 'package:uuid/uuid.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// class DatabaseManage {

//   DatabaseManage._internal();

//   static DatabaseManage _shared = DatabaseManage._internal();
//   static DatabaseManage get shared => _shared;

//   Database db;

//   Future init({
//     String name = 'test.db',
//     int version = 1,
//     String create = '''
//       CREATE TABLE IF NOT EXISTS run (
//         id INT PRIMARY KEY,
//         data_uint BLOB NOT NULL,
//         data_utf BLOB NOT NULL
//       );
//     ''',
//   }) async {
//     final Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     final String path = join(documentsDirectory.path, name);
//     if (version != 1) {
//       await deleteDatabase(path);
//     }
//     Database db = await openDatabase(path, version: version, onCreate: _create);
//     print('DB INITIATED WITH PATH : $path');
//     this.db = db;
//     return db;
//   }

//   Future _create(Database db, int version) async {
//     await db.transaction((t) async {
//       await t.execute('''
//         CREATE TABLE IF NOT EXISTS run (
//           id TEXT PRIMARY KEY,
//           data_uint BLOB NOT NULL,
//           data_utf BLOB NOT NULL
//       );
//       ''');
//     });
//   }

//   Future close() async => await db.close();

//   Future<bool> saveData() async {
//     final id = Uuid().v1();
//     final dataUtf = utf8.encode(id);
//     print('$id - $dataUtf');
//     try {
//       print('$id - $dataUtf');
//       final _ = await db.rawQuery('''
//         INSERT OR REPLACE INTO run
//         (id, data_uint, data_utf) VALUES (?, ?, ?)''', [id, dataUtf, dataUtf]);
//       print(' DATA SAVED');
//       return true;
//     } catch (e) {
//       print('FAILED SAVING DATA: ${e.toString()}');
//       return false;
//     }
//   }

//   Future<List<Map<String, dynamic>>> fetchData() async {
//     try {
//       final res = db.rawQuery('SELECT * FROM run');
//       return res;
//     } catch (e) {
//       print('FAILED FETCH DATA: ${e.toString()}');
//       return [];
//     }
//   }

// }
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
