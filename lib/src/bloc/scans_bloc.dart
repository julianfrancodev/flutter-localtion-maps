import 'dart:async';
import 'package:flutter_04/src/provider/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._() {
    // get scans from database
    getScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  getScans() async {
    _scansController.sink.add(await DbProvider.db.getScans());
  }


  saveScan(ScanModel scanModel)async{
    await DbProvider.db.newScan(scanModel);
    getScans();
  }


  deleteScan(int id) async {
    await DbProvider.db.deleteScan(id);
    getScans();
  }

  deleteAllScan() async {
    await DbProvider.db.deleteAllScan();
    getScans();
  }
}
