import 'dart:convert';

PaymentKey paymentKeyFromJson(String str) =>
    PaymentKey.fromJson(json.decode(str));

class PaymentKey {
  PaymentKey({
    required this.token,
  });

  String token;

  factory PaymentKey.fromJson(Map<String, dynamic> json) => PaymentKey(
        token: json["token"] == null ? null : json["token"],
      );
}
