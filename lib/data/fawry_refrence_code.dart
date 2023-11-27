import 'dart:convert';

FawryRefrenceCode fawryRefrenceCodeFromJson(String str) =>
    FawryRefrenceCode.fromJson(json.decode(str));

class FawryRefrenceCode {
  FawryRefrenceCode({
    required this.type,
    required this.referenceNumber,
    required this.merchantRefNumber,
    required this.orderAmount,
    required this.paymentAmount,
    required this.fawryFees,
    required this.orderStatus,
    required this.paymentMethod,
    required this.expirationTime,
    required this.customerName,
    required this.customerMobile,
    required this.customerProfileId,
    required this.signature,
    required this.taxes,
    required this.statusCode,
    required this.statusDescription,
    required this.basketPayment,
  });

  String type;
  String referenceNumber;
  String merchantRefNumber;
  double orderAmount;
  double paymentAmount;
  double fawryFees;
  String orderStatus;
  String paymentMethod;
  int expirationTime;
  String customerName;
  String customerMobile;
  String customerProfileId;
  String signature;
  double taxes;
  int statusCode;
  String statusDescription;
  bool basketPayment;

  factory FawryRefrenceCode.fromJson(Map<String, dynamic> json) =>
      FawryRefrenceCode(
        type: json["type"],
        referenceNumber: json["referenceNumber"],
        merchantRefNumber: json["merchantRefNumber"],
        orderAmount: json["orderAmount"]?.toDouble(),
        paymentAmount: json["paymentAmount"]?.toDouble(),
        fawryFees: json["fawryFees"]?.toDouble(),
        orderStatus: json["orderStatus"],
        paymentMethod: json["paymentMethod"],
        expirationTime: json["expirationTime"],
        customerName: json["customerName"],
        customerMobile: json["customerMobile"],
        customerProfileId: json["customerProfileId"],
        signature: json["signature"],
        taxes: json["taxes"],
        statusCode: json["statusCode"],
        statusDescription: json["statusDescription"],
        basketPayment: json["basketPayment"],
      );
}
