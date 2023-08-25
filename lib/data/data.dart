// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class LocationLinkData {
  String data;
  late String longitude;
  late String latitude;

  LocationLinkData({required this.data}) {
    decodeData();
  }
  decodeData() {
    if (data.contains("maps.google.com/maps?q=")) {
      var link = Uri.decodeFull(data);
      try {
        var temp = link.substring(link.indexOf("=") + 1, link.indexOf("&"));
        longitude = temp.split(",")[0];
        latitude = temp.split(",")[1];
      } catch (e) {}
    } else if (data.contains("geo:")) {
      var temp = data.substring(data.indexOf("=") + 1);
      latitude = temp.split(",")[0];
      longitude = temp.split(",")[1];
    }
   
  }
}

class Repository {
  static LocationLinkData? receiveLocationLinkData = null;
}
