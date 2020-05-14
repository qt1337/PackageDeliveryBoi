import 'package:http/http.dart' as http;

Future<http.Response> fetchDeliveryStatus(id) {
  var params = {'accept': 'application/json', 'DHL-API-Key': 'demo-key'};

  return http.get(('https://api-eu.dhl.com/track/shipments?trackingNumber=' + id + '&requesterCountryCode=DE&originCountryCode=DE&language=en'), headers: params);
}
