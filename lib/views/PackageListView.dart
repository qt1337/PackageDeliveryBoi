import 'package:flutter/material.dart';
import 'package:package_delivery_boi/controller/PackageListController.dart'
    as PLE;
import 'package:package_delivery_boi/models/StatusModel.dart';

class PackageList extends StatefulWidget {
  PackageList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PackageListState createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  @override
  void initState() {
    super.initState();
  }

  static StatusModel test1 = new StatusModel("id1", "in Bearbeitung", "Handy", Icons.phone, "DHL");
  static StatusModel test2 = new StatusModel("id2", "in Zustellung", "Fernseher", Icons.tv, "Hermes");
  static StatusModel test3 = new StatusModel("id3", "Zugestellt", "Auto", Icons.directions_car, "UPS");

  List<StatusModel> listEntries = <StatusModel>[test1,test2,test3];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Builder(
          builder: (context) => getPackageListView(), // ListView
        ),
        floatingActionButton: // addButton
            Builder(
                builder: (context) => FloatingActionButton(
                      onPressed: () {
                        _openAddPackageDialog(context).then((onValue) {
                          _saveToList(onValue);
                          String package = onValue.name;
                          SnackBar mySnackbar = SnackBar(
                              content: Text("Package $package added."));
                          Scaffold.of(context).showSnackBar(mySnackbar);
                        });
                      },
                      tooltip: 'Add Package',
                      child: Icon(Icons.add),
                    )));
  }

  void _saveToList(StatusModel package) {
    setState(() {
      listEntries.add(package);
    });
  }

  Future<StatusModel> _openAddPackageDialog(BuildContext context) {
    TextEditingController customControllerName = new TextEditingController();
    TextEditingController customControllerId = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add a package"),
            content: getTextFieldsForDialog(
                customControllerName, customControllerId),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text("Add"),
                onPressed: () {
                  StatusModel newPackage = new StatusModel(
                      customControllerId.text.toString(),
                      "null",
                      customControllerName.text.toString(),
                      Icons.wb_sunny,
                      "Amazon");

                  Navigator.of(context).pop(newPackage);
                },
              )
            ],
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
          );
        },
        barrierDismissible: false);
  }

  Widget getTextFieldsForDialog(TextEditingController controllerName,
      TextEditingController controllerId) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Product"),
        TextField(
          controller: controllerName,
        ),
        Text("Package Number"),
        TextField(
          controller: controllerId,
        ),
      ],
    );
  }

  Widget getPackageListView() {
    var packageListView = ListView.separated(
      itemCount: listEntries.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(listEntries[index].category),
          title: Text(listEntries[index].name),
          subtitle: Text(listEntries[index].serviceCompany),
          trailing: Text(listEntries[index].status),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
    return packageListView;
  }
}
