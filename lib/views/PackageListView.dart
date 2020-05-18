import 'package:flutter/material.dart';
import 'package:package_delivery_boi/controller/PackageListController.dart';
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

  bool _validate = true;

  @override
  void initState() {
    super.initState();
    fillList().then((result) {
      setState(() {
        listEntries.addAll(result);
      });
    });
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

  void _saveToList(StatusModel package) async {
    try {
      Future<DeliveryStatus> futureDeliveryStatus =
          fetchDeliveryStatus(package.id);
      package.status = await futureDeliveryStatus.then((result) {
        return result.status;
      });
    } catch (e) {
      package.status = e.toString();
    }

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
              FloatingActionButton(
                elevation: 5.0,
                child: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    customControllerId.text.length > 4
                        ? _validate = true
                        : _validate = false;
                  });
                  if (_validate) {
                    StatusModel newPackage = new StatusModel(
                        customControllerId.text.toString(),
                        "null",
                        customControllerName.text.toString(),
                        "FERNSEHER",
                        "Amazon");

                    Navigator.of(context).pop(newPackage);
                  }
                },
              )
            ],
            backgroundColor: Colors.white,
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
        TextFormField(
          controller: controllerName,
          cursorColor: Colors.black,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: "Product"),
        ),
        TextFormField(
          controller: controllerId,
          cursorColor: Colors.black,
          decoration: new InputDecoration(
              errorText: _validate ? null : "Enter a valid tracking number!",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: "Tracking Number"),
        ),
      ],
    );
  }

  Widget getPackageListView() {
    var packageListView = ListView.separated(
      itemCount: listEntries.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          // Each Dismissible must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key(listEntries[index].name),
          // Provide a function that tells the app
          // what to do after an item has been swiped away.
          onDismissed: (direction) {
            // Remove the item from the data source.
            setState(() {
              listEntries.removeAt(index);
              writeList(listEntries);
            });

            // Show a snackbar. This snackbar could also contain "Undo" actions.
            Scaffold
                .of(context)
                .showSnackBar(SnackBar(content: Text(listEntries[index].name  + "deleted")));
          },
          child: ListTile(
            leading: Icon(Icons.tv),
            title: Text(listEntries[index].name),
            subtitle: Text(listEntries[index].serviceCompany),
            trailing: Container(
              width: 200.0,
              child: Text(
                listEntries[index].status == null
                    ? "ValueIsNull"
                    : listEntries[index].status,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                ExtractArgumentsScreen.routeName,
                arguments: listEntries[index],
              );
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
    return packageListView;
  }

}




