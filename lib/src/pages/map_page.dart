import 'package:flutter/material.dart';
import 'package:flutter_04/src/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  String typeMap ='streets';

  final mapController = new MapController();

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              mapController.move(scan.getLatLng(), 10);
            },
          )
        ],
      ),
      body:_renderFlutterMap(scan),
      floatingActionButton: _renderFloatingButton(context)
    );
  }

  Widget _renderFloatingButton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if(typeMap == 'streets'){
          typeMap = 'dark';
        }else if(typeMap == 'dark'){
          typeMap = 'light';
        }else{
          typeMap = 'streets';
        }
       setState(() {});
      },
    );
  }

  Widget _renderFlutterMap(ScanModel scanModel){
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scanModel.getLatLng(),
        zoom: 15,
       ),
      layers: [
        _renderMap(),
        _renderMarker(scanModel),
      ],
    );
  }

  _renderMap(){
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/styles/v1/'
            '{id}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoianVsaWFuZnJhbmNvYWx2YXJhZG8iLCJhIjoiY2tmNzlrbWU3MDA5dTMxbXY5YXBnN2Z3NiJ9.of6WhCbnukPIEsLcxHUElw',
        'id': 'mapbox/${typeMap}-v10'
      }
    );
  }

  _renderMarker(ScanModel scanModel){
    return MarkerLayerOptions(
      markers: [
        Marker(
          width: 100,
          height: 100,
          point: scanModel.getLatLng(),
          builder: (context) => Container(
            child: Icon(Icons.location_on, size: 30,color: Theme.of(context).primaryColor,),
          )
        ),
      ]
    );
  }
}
