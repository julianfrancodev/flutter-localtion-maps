import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_04/src/models/scan_model.dart';
export 'package:flutter_04/src/models/scan_model.dart';

class DbProvider {
  static Database _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, 'ScannsDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY,'
          'type TEXT,'
          'value TEXT'
          ')');
    });
  }

  // INSERT

  newScanRaw(ScanModel scanModel) async {
    final db = await database;

    final result = await db.rawInsert("INSERT Into Scans( id, type, value) "
        "VALUES (${scanModel.id},' ${scanModel.type}', '${scanModel.value}')");

    return result;
  }

  newScan(ScanModel scanModel) async {
    final db = await database;

    final result = await db.insert('Scans', scanModel.toJson());

    return result;
  }

  // SELECT

  Future<ScanModel> getScanById(int id) async {
    final db = await database;

    final result = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return result.isEmpty ? ScanModel.fromJson(result.first) : null;
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;

    final result = await db.query('Scans');

    List<ScanModel> scanList = result.isNotEmpty
        ? result.map((e) => ScanModel.fromJson(e)).toList()
        : [];

    return scanList;
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;

    final result =
        await db.query('Scans', where: 'type = ?', whereArgs: [type]);

    List<ScanModel> scanList = result.isNotEmpty
        ? result.map((e) => ScanModel.fromJson(e)).toList()
        : [];

    return scanList;
  }

  Future<int> updateScan(ScanModel scanModel) async {
    final db = await database;

    final result = await db.update('Scans', scanModel.toJson(),where: 'id = ?', whereArgs: [scanModel.id]);

    return result;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;

    final result = await db.delete('Scans',where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<int> deleteAllScan() async {
    final db = await database;

    final result = await db.delete('Scans');

    return result;
  }
}
