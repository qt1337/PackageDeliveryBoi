import 'package:flutter/material.dart';
import 'package:package_delivery_boi/controller/PackageListController.dart'
    as PLE;
import 'package:package_delivery_boi/controller/Utility.dart';
import 'package:package_delivery_boi/models/StatusModel.dart';

class PackageList extends StatefulWidget {
  PackageList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PackageListState createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  List<StatusModel> listEntries = [];

  @override
  void initState() {
    super.initState();
    _fillList().then((result) {
      setState(() {
        listEntries.addAll(result);
      });
    });
  }

  Future<List<StatusModel>> _fillList() async {
    return await readList();
  }

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
    writeList(listEntries);
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
                      "FERNSEHER",
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
          leading: Icon(Icons.tv),
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
