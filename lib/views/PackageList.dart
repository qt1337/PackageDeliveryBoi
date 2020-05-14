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
  Future<PLE.DeliveryStatus> futureDeliveryStatus;

  @override
  void initState() {
    super.initState();
    futureDeliveryStatus = PLE.fetchDeliveryStatus('00340434292135100094');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
          //getPackageListView(),
          FutureBuilder<PLE.DeliveryStatus>(
              future: futureDeliveryStatus,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.id + "\n" + snapshot.data.status);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: _buttonTestAction,
        tooltip: 'Add Package',
        child: Icon(Icons.add),
      ),
    );
  }

  void _buttonTestAction() {
    setState(() {
      Future<PLE.DeliveryStatus> test =
          PLE.fetchDeliveryStatus('00340434292135100094');
      print(test);
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
