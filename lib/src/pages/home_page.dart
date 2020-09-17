import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_04/src/bloc/scans_bloc.dart';
import 'package:flutter_04/src/models/scan_model.dart';
import 'package:flutter_04/src/pages/locations_page.dart';
import 'package:flutter_04/src/pages/maps_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final scanBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRScaner'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              scanBloc.deleteAllScan();
            },
          )
        ],
      ),
      body: _loadPage(_currentPage),
      bottomNavigationBar: _renderBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR() async {
    // https://music.youtube.com/
    //geo:40.69638688855688,-73.91564741572269
    dynamic futureString = 'https://music.youtube.com/';

    // try{
    //   futureString = await BarcodeScanner.scan();
    // }catch(err){
    //   futureString = err.toString();
    // }
    //
    // print(futureString.rawContent);
    //
    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      scanBloc.saveScan(scan);

      final scan2 = ScanModel(value: 'geo:40.69638688855688,-73.91564741572269');
      scanBloc.saveScan(scan2);
    }
  }

  Widget _renderBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      onTap: (value) {
        setState(() {
          _currentPage = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Maps")),
        BottomNavigationBarItem(
            icon: Icon(Icons.history), title: Text("History")),
      ],
    );
  }

  Widget _loadPage(int actualPage) {
    switch (actualPage) {
      case 0:
        return MapsPage();
      case 1:
        return LocationsPage();
      default:
        return MapsPage();
    }
  }
}
