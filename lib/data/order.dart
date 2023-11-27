import 'dart:convert';

Orders? OrdersFromJson(String str) => Orders.fromJson(json.decode(str));

class Orders {
  Orders({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  List<OrderElement> data;
  String? message;

  factory Orders.fromJson(Map<String, dynamic> json) {
    print('Orders.fromJson');
    return Orders(
      success: json["success"],
      data: json["data"] == null
          ? []
          : List<OrderElement>.from(
              json["data"]!.map((x) => OrderElement.fromJson(x))),
      message: json["message"],
    );
  }
}

class OrderElement {
  OrderElement({
    required this.id,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.phoneNumber,
    required this.description,
    required this.providre,
    required this.address,
    required this.images,
  });

  int? id;
  String? title;
  bool? status;
  String? createdAt;
  String? phoneNumber;
  String? description;
  Providre? providre;

  OrderAddress? address;
  List<OrderImage?>? images;

  factory OrderElement.fromJson(Map<String, dynamic> json) {
    print('OrderElement.fromJson');

    return OrderElement(
      id: json["id"],
      title: json["title"],
      status: json["status"],
      createdAt: json["created_at"].toString(),
      phoneNumber: json["phone_number"],
      description: json["description"],
      providre: Providre.fromJson(json["providre"]),
      address: OrderAddress.fromJson(json["address"]),
      images: json["images"] == null
          ? []
          : List<OrderImage?>.from(
              json["images"]!.map((x) => OrderImage.fromJson(x))),
    );
  }
}

class Providre {
  Providre({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.userType,
    required this.providerType,
    required this.brandName,
    required this.language,
    required this.callCenter,
    required this.cityName,
    required this.areaName,
    required this.availableOrder,
    required this.pointPercentage,
  });

  String? id;
  String? name;
  String? address;
  String? phoneNumber;
  String? email;
  String? latitude;
  String? longitude;
  int? userType;
  int? providerType;
  String? brandName;
  String? language;
  int? callCenter;
  String? cityName;
  String? areaName;
  bool? availableOrder;
  int? pointPercentage;

  factory Providre.fromJson(Map<String, dynamic> json) => Providre(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        userType: json["user_type"],
        providerType: json["provider_type"],
        brandName: json["brandName"],
        language: json["language"],
        callCenter: json["call_center"],
        cityName: json["cityName"],
        areaName: json["areaName"],
        availableOrder: json["available_order"],
        pointPercentage: json["point_percentage"],
      );
}

class OrderAddress {
  OrderAddress({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.cityId,
    required this.cityTitle,
    required this.areaId,
    required this.areaTitle,
    required this.addressDefault,
    required this.building,
    required this.floor,
    required this.door,
  });

  int? id;
  String? title;
  String? latitude;
  String? longitude;
  String? address;
  int? cityId;
  String? cityTitle;
  int? areaId;
  String? areaTitle;
  bool? addressDefault;
  int? building;
  int? floor;
  int? door;

  factory OrderAddress.fromJson(Map<String, dynamic> json) {
    print('OrderAddress.fromJson');

    return OrderAddress(
      id: json["id"],
      title: json["title"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      address: json["address"],
      cityId: json["city_id"],
      cityTitle: json["city_title"],
      areaId: json["area_id"],
      areaTitle: json["area_title"],
      addressDefault: json["default"],
      building: json["building"],
      floor: json["floor"],
      door: json["door"],
    );
  }
}

class OrderImage {
  OrderImage({
    required this.id,
    required this.image,
  });

  int? id;
  String? image;

  factory OrderImage.fromJson(Map<String, dynamic> json) => OrderImage(
        id: json["id"],
        image: json["image"],
      );
}
