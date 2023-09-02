import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../functions/functions.dart';
import '../models/paiementApiModel.dart';
import '../models/paiementApiResponse.dart';
import '../models/recharge.dart';

class PaiementService {
  String paiemenApitUrl =
      "http://31.220.95.109:30030/api/Transactionsts/Payment";
  String goChapApiUrl = "";
  static String userNumberKey = "userNumber";

  static Map<String, String> header = {
    "x-apikey":
        "4B7564CDB63A44B5C4C171996A1F4B7B9E1B56B262D1C0C4BDB7E2DED15EB0B5",
    "x-merchantId": "4db952ba-1405-4456-b68b-3837f361fb04",
    "Content-Type": "application/json",
    "environnment": "production",
  };

  Future<bool> addRecharge(Recharge recharge) async {
    sendToPaiementApi(recharge).then((value) {
      if (value.success!) {
        sendToGoChapApi(recharge).then((secondeValue) {
          if (secondeValue) {
            storeUserNumber(recharge.number);
            return true;
          }
        });
      }
    });
    return false;
  }

  Future<PaiementApiResponse> sendToPaiementApi(Recharge recharge) async {
    var code = userDetails['country_code'];
    await getCountryCode();
    var pays = countries.where((element) => element['code'] == code).first;
    var number = recharge.number;
    recharge.number = pays["code"] + number;
    var httpResponse = await http.post(Uri.parse(paiemenApitUrl),
        body: {PaiementApiModel.fromRecharge(recharge)}, headers: header);
    if (httpResponse.statusCode == 200) {
      var data = jsonDecode(httpResponse.body);
      return PaiementApiResponse.fromJson(data);
    }
    return PaiementApiResponse(success: false);
  }

  Future<bool> sendToGoChapApi(Recharge recharge) async {
    var httpResponse =
        await http.post(Uri.parse(goChapApiUrl), body: {recharge.toJson()});
    return httpResponse.statusCode == 200;
  }

  storeUserNumber(String number) async {
    var pref = await SharedPreferences.getInstance();
    String userNumbers = "";
    if (pref.containsKey(userNumberKey)) {
      userNumbers = pref.getString(userNumbers) as String;
    }
    userNumbers = userNumbers + ", $number";
    pref.setString(userNumberKey, number);
  }
}
