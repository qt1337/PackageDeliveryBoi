import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_delivery_boi/models/StatusModel.dart';

class Package extends StatefulWidget {
  final StatusModel args;

  Package({Key key, this.title, this.args}) : super(key: key);

  final String title;

  @override
  _PackageState createState() => _PackageState();

}

class _PackageState extends State<Package> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.name),
      ),
      body: Center(
        child: Text(widget.args.status),
      ),
    );
  }

}