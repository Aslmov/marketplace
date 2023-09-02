class PaiementApiResponse {
  bool? success;
  String? message;
  String? yourReference;
  String? ourReference;

  PaiementApiResponse(
      {this.success, this.message, this.yourReference, this.ourReference});

  PaiementApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    yourReference = json['yourReference'];
    ourReference = json['ourReference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['yourReference'] = this.yourReference;
    data['ourReference'] = this.ourReference;
    return data;
  }
}
