import 'recharge.dart';

class ApiRensponseSentToServer {
  String? reference;
  int? id;
  String? userPhoneNumber;
  String? phoneNumber;
  String? statusCode;
  String? source;
  ApiRensponseSentToServer(
      {this.reference,
      this.userPhoneNumber,
      this.id,
      this.phoneNumber,
      this.statusCode,
      this.source});

  ApiRensponseSentToServer.fromJson(Map<String, dynamic> json) {
    reference = json["reference"];
    id = json['user_Id'];
    userPhoneNumber = json['userPhoneNumber'];
    phoneNumber = json['phoneNumber'];
    statusCode = json['status'];
    source = json['source'];
  }

  ApiRensponseSentToServer.fromRecharge(Recharge recharge) {
    reference = "";
    userPhoneNumber = recharge.number;
    id;
    phoneNumber = "";
    statusCode = "03";
    source = "user";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataSent = new Map<String, dynamic>();
    dataSent['reference'] = this.reference;
    dataSent['user_Id'] = this.id;
    dataSent['userPhoneNumber'] = this.userPhoneNumber;
    dataSent['phoneNumber'] = this.phoneNumber;
    dataSent['statusCode'] = this.statusCode;
    dataSent['source'] = this.source;
    return dataSent;
  }
}
