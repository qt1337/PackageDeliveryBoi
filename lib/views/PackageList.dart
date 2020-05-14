import 'package:flutter/material.dart';
import 'package:package_delivery_boi/backend/PackageListExtension.dart' as PLE;

class PackageList extends StatefulWidget {
  PackageList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PackageListState createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  int _counter = 0;

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
    setState(() {
      print(PLE.fetchDeliveryStatus('00340434292135100094'));
      _counter++;
    });
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
          subtitle: Text("$_counter"),
          trailing: Text("In Zustellung"),
        ),
      ],
    );
    return packageListView;
  }
}
