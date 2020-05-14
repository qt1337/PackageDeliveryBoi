import 'dart:html';
import 'dart:async';
import 'dart:convert';

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
