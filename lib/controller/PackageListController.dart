import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_delivery_boi/controller/Utility.dart';
import 'package:package_delivery_boi/models/StatusModel.dart';
import 'package:package_delivery_boi/views/PackageView.dart';

Future<DeliveryStatus> fetchDeliveryStatus(id) async {
  final response =
      await http.get('https://api-eu.dhl.com/track/shipments?trackingNumber=' + id + '&requesterCountryCode=DE&originCountryCode=DE&language=en', headers: {'accept': 'application/json', 'DHL-API-Key': 'demo-key'});

  if (response.statusCode == 200) {
    return DeliveryStatus.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch data | statusCode: ' + response.statusCode.toString());
  }
}

class DeliveryStatus {
  String id;
  String status;
  DeliveryStatus(
      {this.id, this.status});

  factory DeliveryStatus.fromJson(Map<String, dynamic> json) {
    return DeliveryStatus(
        id: json['shipments'][0]['id'],
        status: json['shipments'][0]['status']['status']
    );
  }
}



Future<List<StatusModel>> fillList() async {
  readList().then((result) {
    writeList(result);
  });
  return await readList();
}


class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/PackageView';

  @override
  Widget build(BuildContext context) {
    final StatusModel args = ModalRoute.of(context).settings.arguments;

    return Package(args: args);
  }

}