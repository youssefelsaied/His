// To parse this JSON data, do
//
//     final branchesByBrands = branchesByBrandsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BranchesByBrands branchesByBrandsFromJson(String str) =>
    BranchesByBrands.fromJson(json.decode(str));

class BranchesByBrands {
  BranchesByBrands({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data? data;
  String message;

  factory BranchesByBrands.fromJson(Map<String, dynamic> json) =>
      BranchesByBrands(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.branches,
    required this.brandServices,
    required this.lastPage,
  });

  List<Branch> branches;
  List<BrandService> brandServices;
  int lastPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        branches: json["branches"] == null
            ? []
            : List<Branch>.from(
                json["branches"].map((x) => Branch.fromJson(x))),
        brandServices: json["brand_services"] == null
            ? []
            : List<BrandService>.from(
                json["brand_services"].map((x) => BrandService.fromJson(x))),
        lastPage: json["last_page"] == null ? null : json["last_page"],
      );
}

class Branch {
  Branch({
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
    required this.brandServices,
  });

  String id;
  String name;
  String address;
  String phoneNumber;
  String email;
  String latitude;
  String longitude;
  int userType;
  int providerType;
  String brandName;
  String language;
  int callCenter;
  String cityName;
  String areaName;
  bool availableOrder;
  int pointPercentage;
  List<BrandService> brandServices;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        email: json["email"] == null ? null : json["email"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        userType: json["user_type"] == null ? null : json["user_type"],
        providerType:
            json["provider_type"] == null ? null : json["provider_type"],
        brandName: json["brandName"] == null ? null : json["brandName"],
        language: json["language"] == null ? null : json["language"],
        callCenter: json["call_center"] == null ? null : json["call_center"],
        cityName: json["cityName"] == null ? null : json["cityName"],
        areaName: json["areaName"] == null ? null : json["areaName"],
        availableOrder:
            json["available_order"] == null ? null : json["available_order"],
        pointPercentage:
            json["point_percentage"] == null ? null : json["point_percentage"],
        brandServices: json["brand_services"] == null
            ? []
            : List<BrandService>.from(
                json["brand_services"].map((x) => BrandService.fromJson(x))),
      );
}

class BrandService {
  BrandService({
    required this.id,
    required this.discount,
    required this.serviceId,
    required this.serviceTitle,
    required this.serviceImage,
  });

  int id;
  String discount;
  int serviceId;
  String serviceTitle;
  String serviceImage;

  factory BrandService.fromJson(Map<String, dynamic> json) => BrandService(
        id: json["id"] == null ? null : json["id"],
        discount: json["discount"] == null ? null : json["discount"],
        serviceId: json["serviceId"] == null ? null : json["serviceId"],
        serviceTitle:
            json["serviceTitle"] == null ? null : json["serviceTitle"],
        serviceImage:
            json["serviceImage"] == null ? null : json["serviceImage"],
      );
}
