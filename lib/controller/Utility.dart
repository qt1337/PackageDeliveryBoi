import 'package:flutter/cupertino.dart';
import 'package:package_delivery_boi/controller/PackageListController.dart';
import 'package:package_delivery_boi/models/StatusModel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

// Get correct file Path
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

//Create Reference to file location
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/packagelist.txt');
}

//Write Data
Future<File> writeList(List<StatusModel> modelList) async {
  print("in writeList()");
  final file = await _localFile;

  // Convert to json
  List<Map> objList = List<Map>();
  for(StatusModel tmpObj in modelList){
    String status;
    Future<DeliveryStatus> futureDeliveryStatus = fetchDeliveryStatus(tmpObj.id);
    status = await futureDeliveryStatus.then((result) {
      return result.status;
      });

    print("____");
    print("WIR SIND HIER");
    print(status);
    print("WIR SIND HIER");
    print("____");
    var tmpMap = {
      'id': tmpObj.id,
      'status': status,
      'name': tmpObj.name,
      'category': tmpObj.category,
      'serviceCompany': tmpObj.serviceCompany
    };

    objList.add(tmpMap);
  }

  String objJson = JsonEncoder().convert(objList);

  // Write the file.
  return file.writeAsString(objJson);
}

//Read Data
Future<List<StatusModel>> readList() async {
  print('In readList()');
  try {
    final file = await _localFile;

    // Read the file.
    String contents = await file.readAsString();


    //Convert back to list
    List<StatusModel> resList = List<StatusModel>();
    List<dynamic> tmpList = JsonDecoder().convert(contents);

    
    for(Map tmpObj in tmpList){
      StatusModel tmpModel = new StatusModel(tmpObj['id'], tmpObj['status'], tmpObj['name'], tmpObj['category'], tmpObj['serviceCompany']);

      resList.add(tmpModel);
    }
    
    return resList;
  } catch (e) {
    // If encountering an error, return 0.
    return List<StatusModel>();
  }
}
