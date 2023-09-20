import 'recharge.dart';

class ApiRensponseSentToServer {
  String? userPhoneNumber;
  String? token;
  String? phoneNumber;
  ApiRensponseSentToServer(
      {this.userPhoneNumber, this.token, this.phoneNumber});

  ApiRensponseSentToServer.fromJson(Map<String, dynamic> json) {
    userPhoneNumber = json['numUser'];
    token = json['token'];
    phoneNumber = json['profilNum'];
  }

  ApiRensponseSentToServer.fromRecharge(Recharge recharge) {
    userPhoneNumber = recharge.number;
    token = "";
    phoneNumber = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataSent = new Map<String, dynamic>();
    dataSent['numUser'] = this.userPhoneNumber;
    dataSent['token'] = this.token;
    dataSent['profilNums'] = this.phoneNumber;
    return dataSent;
  }
}
