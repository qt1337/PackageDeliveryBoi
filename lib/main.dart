import 'package:flutter/material.dart';
import 'views/PackageListView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Package Delivery Boi',
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
      ),
      home: PackageList(title: 'Packages'),
    );
  }
}
