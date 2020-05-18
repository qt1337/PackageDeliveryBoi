import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_delivery_boi/models/StatusModel.dart';
import 'package:package_delivery_boi/views/PackageListView.dart';

class Package extends StatefulWidget {
  Package({Key key, this.title, this.args, this.index}) : super(key: key);

  final StatusModel args;
  final int index;
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
        child: Column(
          children: [
            Text(widget.args.name),
            Text(widget.args.id),
            Text(widget.args.status),
            Text(widget.args.category),
            Text(widget.args.serviceCompany),
            FloatingActionButton(
              tooltip: 'Remove Package',
              child: Icon(Icons.remove),
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }

}