import 'package:uuid/uuid.dart';

import 'recharge.dart';

class PaiementApiModel {
  int? amount;
  String? msisdn;
  String otp = "";
  String? name;
  String? type;
  String reference = "R00foopppm0foooofrwrbec8";
  String? countryIsoCode;

  PaiementApiModel(
      {this.amount,
      this.msisdn,
      this.name,
      this.type,
      this.countryIsoCode});

  PaiementApiModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    msisdn = json['msisdn'];
    otp = json['otp'];
    name = json['name'];
    type = json['type'];
    countryIsoCode = json['countryIsoCode'];
  }


  PaiementApiModel.fromRecharge(Recharge recharge) {
    String prix = recharge.price;
    if(prix.contains(' Fcfa')){
      var index =  prix.indexOf(' Fcfa');
      prix = prix.substring(0, index);
    }
    amount = int.parse(prix);
    msisdn = recharge.number;
    otp = "";
    name = recharge.method.toLowerCase();
    type = "mobile_money";
    countryIsoCode = "";
    reference = Uuid().v1();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['msisdn'] = this.msisdn;
    data['otp'] = this.otp;
    data['name'] = this.name;
    data['type'] = this.type;
    data['reference'] = this.reference;
    data['countryIsoCode'] = this.countryIsoCode;
    return data;
  }
}
