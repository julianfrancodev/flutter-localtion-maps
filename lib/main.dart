import 'package:flutter/material.dart';
import 'package:flutter_04/src/routes/routes.dart';

void main() {
  runApp(MaterialApp(
    title: 'QRPage',
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: routes,
    theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.deepPurple),
  ));
}
