import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseEntry {
  final int id;
  final datetime;
  final String item;
  final double amt;
  final String desc;

  ExpenseEntry({this.id, this.datetime, this.item, this.amt, this.desc});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'datetime': datetime,
      'item': item,
      'amt': amt,
      'desc': desc,
    };
  }

  @override
  String toString() {
    return 'Entry{id: $id, datetime: $datetime, item: $item, amt: $amt, desc: $desc}';
  }
}

class ExpenseEntries {
  List<ExpenseEntry> listOfEntries = [];

  ExpenseEntries({this.listOfEntries});

  initData(String query) async {
    this.listOfEntries = await listEntriesByQuery(query);
  }

  void sortAmount(bool isAscending) {
    listOfEntries.sort((a, b) {
      double aAmt = a.amt ?? 0;
      double bAmt = b.amt ?? 0;
      return (aAmt - bAmt).floor() * (isAscending ? 1 : -1);
    });
  }

  getRecentData(int numRecords) async {
    String query = 'SELECT * FROM entries ORDER BY datetime DESC LIMIT $numRecords';
    this.listOfEntries = await listEntriesByQuery(query);
  }
}

Future<Database> getDatabase() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'expense_entries.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE entries(id INTEGER PRIMARY KEY, datetime TEXT, item TEXT, amt REAL, desc TEXT)",
      );
    },
    version: 1,
  );

  return database;
}

Future<void> insertEntry(ExpenseEntry entry) async {
  final Database db = await getDatabase();
  await db.insert('entries', entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<ExpenseEntry>> listEntries() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> maps = await db.query('entries');

  return List.generate(maps.length, (i) {
    return ExpenseEntry(
      id: maps[i]['id'],
      datetime: maps[i]['datetime'],
      item: maps[i]['item'],
      amt: maps[i]['amt'],
      desc: maps[i]['desc'],
    );
  });
}

Future<int> getDatabaseSize() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> maps = await db.query('entries');

  return maps.length;
}

Future<List<ExpenseEntry>> listEntriesByQuery(String query) async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> maps = await db.rawQuery(query);

  return List.generate(maps.length, (i) {
    return ExpenseEntry(
      id: maps[i]['id'],
      datetime: maps[i]['datetime'],
      item: maps[i]['item'],
      amt: maps[i]['amt'],
      desc: maps[i]['desc'],
    );
  });
}
