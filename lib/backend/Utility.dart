import 'package:http/http.dart' as http;

Future<http.Response> fetchDeliveryStatus(id) {
  return http.get('api-eu.dhl.com/track/shipments?trackingNumber=' + id);
}

