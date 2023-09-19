import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../functions/functions.dart';
import '../models/paiementApiModel.dart';
import '../models/paiementApiResponse.dart';
import '../models/recharge.dart';

class PaiementService {
  String paiemenApitUrl =
      "http://217.76.58.38:30030/api/Transactionsts/Payment";
  String goChapApiUrl = "";
  static String userNumberKey = "userNumber";

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
    var code = userDetails['country_code'].toString();
    await getCountryCode();
    var pays = countries.where((element) => element['code'] == code).first;
    var paiement = PaiementApiModel.fromRecharge(recharge);
    /*var countryResponse = await http.get(Uri.parse(
        "https://api.worldbank.org/v2/country/#?format=json"
            .replaceAll("#", code.toLowerCase())));
    var temp = jsonDecode(countryResponse.body)[1];
    var isocode = temp[0]["id"];*/
    paiement.countryIsoCode = 'TGO';
    paiement.msisdn = pays['dial_code'] + recharge.number;
    var data = jsonEncode(paiement.toJson());
    var httpResponse =
        await http.post(Uri.parse(paiemenApitUrl), body: data, headers: header);
    if (httpResponse.statusCode == 201) {
      var data = jsonDecode(httpResponse.body);
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
