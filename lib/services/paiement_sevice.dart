import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tagxisuperuser/models/paiementSentToserver.dart';
import '../functions/functions.dart';
import '../models/paiementApiModel.dart';
import '../models/paiementApiResponse.dart';
import '../models/recharge.dart';

class PaiementService {
  String paiemenApitUrl =
      "http://217.76.58.38:30030/api/Transactionsts/Payment";

  String schedulerApitUrl = "https://gochap.app/api/v1/user/add-credit";

  static String userNumberKey = "userNumber";
  static String tokenSent = '${bearerToken[0].token}';
  dynamic paimentapirest;

  static Map<String, String> header = {
    "x-apikey":
        "BDDFCDFEC2F47595B7231657DAFB23E4BC297CA98E69ACF2DF1A6410BE016849",
    "x-merchantId": "9b59dd11-df6e-4fab-951e-4aef5dcfdcbf",
    "Content-Type": "application/json",
    "environnment": "production",
    'x-token': '${bearerToken[0].token}',
  };

  Future<bool> addRecharge(Recharge recharge) async {
    var rep = await sendToPaiementApi(recharge);
    if (rep.success!) {
      return true;
    }
    return false;
  }

  Future<PaiementApiResponse> sendToPaiementApi(Recharge recharge) async {
    //  var code = userDetails['country_code'].toString();

    //data from PaiementApiModel
    var paiement = PaiementApiModel.fromRecharge(recharge);
    /*var countryResponse = await http.get(Uri.parse(
        "https://api.worldbank.org/v2/country/#?format=json"
            .replaceAll("#", code.toLowerCase())));
    var temp = jsonDecode(countryResponse.body)[1];
    var isocode = temp[0]["id"];*/
    paiement.countryIsoCode = 'TGO';
    paiement.msisdn = countries[phcode]['dial_code'] + recharge.number;
    var data = jsonEncode(paiement.toJson());
    debugPrint(data);
    var httpResponse =
        await http.post(Uri.parse(paiemenApitUrl), body: data, headers: header);

    //data from the paiementSentToServer
    var tosendtoserver = ApiRensponseSentToServer.fromRecharge(recharge);
    tosendtoserver.phoneNumber =
        countries[phcode]['dial_code'] + recharge.number;
    tosendtoserver.id = userDetails['id'];
    tosendtoserver.userPhoneNumber = userDetails['mobile'];
    var dataToServer = jsonEncode(tosendtoserver.toJson());

    if (httpResponse.statusCode == 201) {
      var data = jsonDecode(httpResponse.body);
      Map<String, dynamic> jsonDataToServer = jsonDecode(dataToServer);

      var ourReference = data["ourReference"];
      debugPrint(ourReference);
      jsonDataToServer["reference"] = ourReference;

      String jsonDataToServerJson = jsonEncode(jsonDataToServer);
      debugPrint(jsonDataToServerJson);
      http.post(
        Uri.parse(schedulerApitUrl),
        body: jsonDataToServerJson,
        headers: header,
      );
      return PaiementApiResponse.fromJson(data);
    }
    return PaiementApiResponse(success: false);
  }

  /* storeUserNumber(String number) async {
    var pref = await SharedPreferences.getInstance();
    String userNumbers = "";
    if (pref.containsKey(userNumberKey)) {
      userNumbers = pref.getString(userNumbers) as String;
      if (!userNumbers.contains(number)) {
        userNumbers = userNumbers + ", $number";
      }
    } else {
      userNumbers = number;
    }
    pref.setString(userNumberKey, userNumbers);
  }
*/
  getUserNumber() async {
    var pref = await SharedPreferences.getInstance();
    String userNumbers = "";
    if (pref.containsKey(userNumberKey)) {
      userNumbers = pref.getString(userNumberKey) as String;
      if (userNumbers.contains(", ")) return userNumbers.split(", ").toList();
      return [userNumbers];
    }
    return [];
  }
}
