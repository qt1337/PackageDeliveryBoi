import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<DeliveryStatus> fetchDeliveryStatus(id) async {
  final response =
      await http.get('api-eu.dhl.com/track/shipments?trackingNumber=' + id);

  if (response.statusCode == 200) {
    return DeliveryStatus.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch data');
  }
}

class DeliveryStatus {
  int id;

  DeliveryStatus(
      {this.id});

  factory DeliveryStatus.fromJson(Map<String, dynamic> json) {
    return DeliveryStatus(
        id: json['shipments'][0]['id']);
  }
}

void saveData(id, name) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('id', id);
  prefs.setString('name', name);
}

void readData() async {
  final prefs = await SharedPreferences.getInstance();

  final id = prefs.getString('id') ?? null;
  final name = prefs.getString('name') ?? null;
}
