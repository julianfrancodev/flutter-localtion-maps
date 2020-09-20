import 'package:flutter/material.dart';
import 'package:flutter_04/src/bloc/scans_bloc.dart';
import 'package:flutter_04/src/models/scan_model.dart';
import 'package:flutter_04/src/util/utils.dart';

class LocationsPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.getScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator() ,
          );
        }

        final scans = snapshot.data;

        if(scans.length == 0){
          return Center(child: Text("No Data Here!!"),);

        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, index){
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction){
                scansBloc.deleteScan(scans[index].id);
              },
              child: ListTile(
                title: Text(scans[index].value) ,
                leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor,),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey,),
                onTap: (){
                  launchURL(scans[index],context);
                },
              ),
            );
          },
        );
      },
    );
  }
}
