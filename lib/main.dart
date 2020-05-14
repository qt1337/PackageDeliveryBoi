import 'package:flutter/material.dart';
import 'views/PackageList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Package Delivery Boi',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PackageList(title: 'Packages'),
    );
  }
}