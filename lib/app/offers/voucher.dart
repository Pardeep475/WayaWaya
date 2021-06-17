
import 'dart:convert';

Voucher voucherFromJson(String str) => Voucher.fromJson(json.decode(str));

String voucherToJson(Voucher data) => json.encode(data.toJson());

class Voucher {
  Voucher({
    this.discount,
    this.code,
  });

  int discount;
  String code;

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
    discount: json["discount"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "discount": discount,
    "code": code,
  };
}

// {"discount": 1, "code": "12sv5few25"}