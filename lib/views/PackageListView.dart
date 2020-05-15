import 'package:flutter/material.dart';
import 'package:package_delivery_boi/controller/PackageListController.dart' as PLE;

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
      body: Builder(
        builder: (context) =>
          getPackageListView(),
      ),
      floatingActionButton:
        Builder(
          builder: (context) =>
            FloatingActionButton(
              onPressed: () {
                _openAddPackageDialog(context).then((onValue) {
                  SnackBar mySnackbar = SnackBar(content: Text("Package $onValue added."));
                  Scaffold.of(context).showSnackBar(mySnackbar);
                });
              },
              tooltip: 'Add Package',
              child: Icon(Icons.add),
            )
        )
    );
  }

  Future<String> _openAddPackageDialog(BuildContext context) {

    TextEditingController customController = new TextEditingController();

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Package name"),
        content: TextField(
          controller: customController,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text("Add"),
            onPressed: () {

              Navigator.of(context).pop(customController.text.toString());

            },
          )
        ],
      );
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
          leading: Icon(Icons.phone),
          title: Text("Handy"),
          subtitle: Text("DHL"),
          trailing: Text("In Bearbeitung"),
        ),
        ListTile(
          leading: Icon(Icons.tv),
          title: Text("Fernseher"),
          subtitle: Text("UPS"),
          trailing: Text("Zugestellt"),
        ),
      ],
    );
    return packageListView;
  }
}
