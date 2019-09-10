part of record;

final String tableName = 'record';
final String columnId = 'id';
final String columnDay = 'day';
final String columnStep = 'step';
final String columnCal = 'cal';
final String columnDist = 'dist';

class DBProvider {

  DBProvider._internal();

  static DBProvider _shared = DBProvider._internal();
  static DBProvider get shared => _shared;

  Database db;

  Future<Database> init() async {
    final String name = 'record.db';
    Database db;
    await initDeleteDb(name).then(
      (String path) async {
        Database db = await openDatabase(path, version: 1, onCreate: _create);
        this.db = db;
      }
    );
    return db;
  }

  Future<void> _create(Database db, int version) async {
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
      return Record.fromMap(maps.first);
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

  Future<void> close() async => await db.close();

}

Future<String> initDeleteDb(String dbName) async {
  final String databasePath = await getDatabasesPath();
  final String path = join(databasePath, dbName);
  if (await Directory(dirname(path)).exists()) {
    await deleteDatabase(path);
  } else {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      print(e);
    }
  }
  return path;
}

// class DBProvider {
//   DBProvider._();

//   static final DBProvider db = DBProvider._();

//   Database _database;

//   Future<Database> get database async {
//     if (_database != null) return _database;
//     // if _database is null we instantiate it
//     _database = await initDB();
//     return _database;
//   }

//   initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "TestDB.db");
//     return await openDatabase(path, version: 1, onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//       await db.execute("CREATE TABLE Client ("
//           "id INTEGER PRIMARY KEY,"
//           "first_name TEXT,"
//           "last_name TEXT,"
//           "blocked BIT"
//           ")");
//     });
//   }

//   newClient(Client newClient) async {
//     final db = await database;
//     //get the biggest id in the table
//     var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
//     int id = table.first["id"];
//     //insert to the table using the new id
//     var raw = await db.rawInsert(
//         "INSERT Into Client (id,first_name,last_name,blocked)"
//         " VALUES (?,?,?,?)",
//         [id, newClient.firstName, newClient.lastName, newClient.blocked]);
//     return raw;
//   }

//   blockOrUnblock(Client client) async {
//     final db = await database;
//     Client blocked = Client(
//         id: client.id,
//         firstName: client.firstName,
//         lastName: client.lastName,
//         blocked: !client.blocked);
//     var res = await db.update("Client", blocked.toMap(),
//         where: "id = ?", whereArgs: [client.id]);
//     return res;
//   }

//   updateClient(Client newClient) async {
//     final db = await database;
//     var res = await db.update("Client", newClient.toMap(),
//         where: "id = ?", whereArgs: [newClient.id]);
//     return res;
//   }

//   getClient(int id) async {
//     final db = await database;
//     var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
//     return res.isNotEmpty ? Client.fromMap(res.first) : null;
//   }

//   Future<List<Client>> getBlockedClients() async {
//     final db = await database;

//     print("works");
//     // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
//     var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

//     List<Client> list =
//         res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
//     return list;
//   }

//   Future<List<Client>> getAllClients() async {
//     final db = await database;
//     var res = await db.query("Client");
//     List<Client> list =
//         res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
//     return list;
//   }

//   deleteClient(int id) async {
//     final db = await database;
//     return db.delete("Client", where: "id = ?", whereArgs: [id]);
//   }

//   deleteAll() async {
//     final db = await database;
//     db.rawDelete("Delete * from Client");
//   }
// }

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