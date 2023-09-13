import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../functions/functions.dart';
import '../models/paiementApiModel.dart';
import '../models/paiementApiResponse.dart';
import '../models/recharge.dart';

class PaiementService {
  String paiemenApitUrl =
      "https://5fb9-2c0f-f0f8-70b-1b05-c8be-3acb-b5db-3ef9.ngrok-free.app/api/Transactionsts/Payment";
  String goChapApiUrl = "";
  static String userNumberKey = "userNumber";

  static Map<String, String> header = {
    "x-apikey":
        "6F99E02CFA8D070A65F2350C2B319A75E62962122B6907031A3499A73F6CC05D",
    "x-merchantId": "2f7d981d-3a1f-49a4-b15a-ef6c2ada19f7",
    "Content-Type": "application/json",
    "environnment": "production",
    'x-token': '${bearerToken[0].token}',
  };

  Future<bool> addRecharge(Recharge recharge) async {
    var rep = await sendToPaiementApi(recharge);
    if(rep.success!){
      storeUserNumber(recharge.number);
      return true;
    }
    return false;
  }

  Future<PaiementApiResponse> sendToPaiementApi(Recharge recharge) async {
    var code = userDetails['country_code'].toString();
    await getCountryCode();
    var pays = countries.where((element) => element['code'] == code).first;
    var paiement = PaiementApiModel.fromRecharge(recharge);
    var countryResponse = await http.get(
        Uri.parse("https://api.worldbank.org/v2/country/#?format=json".replaceAll("#",code.toLowerCase())));
    var temp = jsonDecode(countryResponse.body)[1];
    var isocode = temp[0]["id"];
    paiement.countryIsoCode = isocode;
    paiement.msisdn = pays['dial_code'] + recharge.number;
    var data = jsonEncode(paiement.toJson());
    var httpResponse = await http.post(Uri.parse(paiemenApitUrl),
        body: data, headers: header);
    if (httpResponse.statusCode == 201) {
      var data = jsonDecode(httpResponse.body);
      return PaiementApiResponse.fromJson(data);
    }
    return PaiementApiResponse(success: false);
  }


  storeUserNumber(String number) async {
    var pref = await SharedPreferences.getInstance();
    String userNumbers = "";
    if (pref.containsKey(userNumberKey)) {
      userNumbers = pref.getString(userNumbers) as String;
      if(!userNumbers.contains(number)){
        userNumbers = userNumbers + ", $number";
      }
    }else{
      userNumbers = number;
    }
    pref.setString(userNumberKey, userNumbers);
  }
  getUserNumber() async {
    var pref = await SharedPreferences.getInstance();
    String userNumbers = "";
    if (pref.containsKey(userNumberKey)) {
      userNumbers = pref.getString(userNumberKey) as String;
      if(userNumbers.contains(", "))
        return userNumbers.split(", ").toList();
      return [userNumbers];
    }
    return [];
  }
}
