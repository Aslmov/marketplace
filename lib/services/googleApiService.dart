import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../functions/functions.dart';
import '../models/googleApiGeo.dart';

class GoogleApiService {
  static String url =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=#&key=#";
  static Future<String> getAdressFromLocation(LatLng latLng) async {
    var rep = "";
    var link = url
        .replaceFirst("#", "${latLng.latitude},${latLng.longitude}")
        .replaceFirst("#", mapkey);
    final response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == "OK") {
        var data = jsonDecode(response.body)["results"] as List?;
        var result =
            data!.map<GoogleApiGeo>((e) => GoogleApiGeo.fromJson(e)).toList();
        result.forEach((element) {
          if (element.types.contains("route")) {
            rep = element.formattedAddress;
          }
        });
      }
    }
    return rep;
  }
}
