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
    amount = int.parse(recharge.price);
    msisdn = recharge.number;
    otp = "";
    name = recharge.method;
    type = "mobile_money";
    countryIsoCode = "";
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
