class PaiementApiResponse {
  bool? success;
  String? ourReference;

  PaiementApiResponse({this.success, this.ourReference});

  PaiementApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    ourReference = json['ourReference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['ourReference'] = this.ourReference;
    return data;
  }
}
