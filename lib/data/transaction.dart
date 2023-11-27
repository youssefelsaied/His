import 'dart:convert';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

class Transaction {
  Transaction({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.orders,
  });

  List<Order>? orders;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );
}

class Order {
  Order({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.serviceImage,
    required this.price,
    required this.finalPrice,
    required this.image,
    required this.providerId,
    required this.providerName,
    required this.providerPhoneNumber,
    required this.brandId,
    required this.brandName,
    required this.brandPhoneNumber,
    required this.brandImage,
    required this.transactionPoint,
    required this.createdAt,
  });

  int? id;
  int? serviceId;
  String? serviceName;
  String? serviceImage;
  String? price;
  String? finalPrice;
  String? image;
  String? providerId;
  String? providerName;
  String? providerPhoneNumber;
  String? brandId;
  String? brandName;
  String? brandPhoneNumber;
  String? brandImage;
  String? transactionPoint;
  DateTime? createdAt;

  factory Order.fromJson(Map<String?, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        serviceId: json["service_id"] == null ? null : json["service_id"],
        serviceName: json["service_name"] == null ? null : json["service_name"],
        serviceImage:
            json["service_image"] == null ? null : json["service_image"],
        price: json["price"] == null ? null : json["price"],
        finalPrice: json["final_price"] == null ? null : json["final_price"],
        image: json["image"] == null ? null : json["image"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        providerName:
            json["provider_name"] == null ? null : json["provider_name"],
        providerPhoneNumber: json["provider_phoneNumber"] == null
            ? null
            : json["provider_phoneNumber"],
        brandId: json["brand_id"] == null ? null : json["brand_id"],
        brandName: json["brand_name"] == null ? null : json["brand_name"],
        brandPhoneNumber: json["brand_phoneNumber"] == null
            ? null
            : json["brand_phoneNumber"],
        brandImage: json["brand_image"] == null ? null : json["brand_image"],
        transactionPoint: json["transaction_point"].toString(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );
}
