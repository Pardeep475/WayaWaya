
import 'dart:convert';

Voucher voucherFromJson(String str) => Voucher.fromJson(json.decode(str));

String voucherToJson(Voucher data) => json.encode(data.toJson());

class Voucher {
  Voucher({
    this.discount,
    this.code,
    this.displayMode,
    this.enabled =false,
    this.isCoupon = false,
    this.limit,
    this.redeemed,
    this.remaining,
    this.value,
  });

  int discount;
  String code;
  String displayMode;
  bool enabled;
  bool isCoupon;
  int limit;
  int redeemed;
  int remaining;
  int value;

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
    discount: json["discount"],
    code: json["code"],
    displayMode: json["display_mode"],
    enabled: json["enabled"],
    isCoupon: json["is_coupon"],
    limit: json["limit"],
    redeemed: json["redeemed"],
    remaining: json["remaining"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "discount": discount,
    "code": code,
    "display_mode": displayMode,
    "enabled": enabled,
    "is_coupon": isCoupon,
    "limit": limit,
    "redeemed": redeemed,
    "remaining": remaining,
    "value": value,
  };
}
