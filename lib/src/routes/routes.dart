import 'package:flutter/cupertino.dart';
import 'package:flutter_04/src/pages/home_page.dart';
import 'package:flutter_04/src/pages/map_page.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => HomePage(),
  '/map': (context) => MapPage(),
};
