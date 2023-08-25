// To parse this JSON data, do
//
//     final googleApiGeo = googleApiGeoFromJson(jsonString);

import 'dart:convert';

GoogleApiGeo googleApiGeoFromJson(String str) =>
    GoogleApiGeo.fromJson(json.decode(str));

String googleApiGeoToJson(GoogleApiGeo data) => json.encode(data.toJson());

class GoogleApiGeo {
  List<AddressComponent> addressComponents;
  String formattedAddress;

  List<String> types;

  GoogleApiGeo({
    required this.addressComponents,
    required this.formattedAddress,
    required this.types,
  });

  factory GoogleApiGeo.fromJson(Map<String, dynamic> json) => GoogleApiGeo(
        addressComponents: List<AddressComponent>.from(
            json["address_components"]
                .map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "address_components":
            List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "formatted_address": formattedAddress,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class AddressComponent {
  String longName;
  String shortName;
  List<String> types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}
