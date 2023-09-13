class Recharge {
  String number;
  String price;
  String method;
  Recharge({required this.number, required this.method, required this.price});

  Map<String, dynamic> toJson() => {
        "number": number,
        "short_name": price,
        "method": method,
      };

  factory Recharge.fromJson(Map<String, dynamic> json) => Recharge(
        number: json["number"],
        price: json["price"],
        method: json["method"],
      );
}
