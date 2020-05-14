import 'package:flutter/material.dart';
import 'dart:developer';

class PackageList extends StatefulWidget {
  PackageList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PackageListState createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: getPackageListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _buttonTestAction,
        tooltip: 'Add Package',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _buttonTestAction(){
    log('Test');
  }
}

Widget getPackageListView() {
  var packageListView = ListView(
    children: <Widget>[

      ListTile(
        leading: Icon(Icons.tv),
        title: Text("Fernseher"),
        subtitle: Text("DHL"),
        trailing: Text("In Zustellung"),
      ),
      ListTile(
        leading: Icon(Icons.tv),
        title: Text("Fernseher"),
        subtitle: Text("DHL"),
        trailing: Text("In Zustellung"),
      ),
      ListTile(
        leading: Icon(Icons.tv),
        title: Text("Fernseher"),
        subtitle: Text("DHL"),
        trailing: Text("In Zustellung"),
      ),
    ],
  );
  return packageListView;
}
