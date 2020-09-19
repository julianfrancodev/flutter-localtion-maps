
import 'package:flutter/cupertino.dart';
import 'package:flutter_04/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(ScanModel scanModel, BuildContext context) async {
   if(scanModel.type == 'http'){
     if (await canLaunch(scanModel.value)) {
       await launch(scanModel.value);
     } else {
       throw 'Could not launch ${scanModel.value}';
     }
   }else{
     Navigator.pushNamed(context, '/map', arguments: scanModel);
   }

}