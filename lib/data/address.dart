// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

class Address {
  Address({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data? data;
  String message;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.addresses,
  });

  List<AddressElement> addresses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        addresses: json["addresses"] == null
            ? []
            : List<AddressElement>.from(
                json["addresses"].map((x) => AddressElement.fromJson(x))),
      );
}

class AddressElement {
  AddressElement({
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

  int id;
  String title;
  String latitude;
  String longitude;
  String address;
  int cityId;
  String cityTitle;
  int areaId;
  String areaTitle;
  bool addressDefault;
  int building;
  int floor;
  int door;

  factory AddressElement.fromJson(Map<String, dynamic> json) => AddressElement(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        address: json["address"] == null ? null : json["address"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        cityTitle: json["city_title"] == null ? null : json["city_title"],
        areaId: json["area_id"] == null ? null : json["area_id"],
        areaTitle: json["area_title"] == null ? null : json["area_title"],
        addressDefault: json["default"] == null ? null : json["default"],
        building: json["building"] == null ? null : json["building"],
        floor: json["floor"] == null ? null : json["floor"],
        door: json["door"] == null ? null : json["door"],
      );
}
