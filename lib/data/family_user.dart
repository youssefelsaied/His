// To parse this JSON data, do
//
//     final familyUser = familyUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FamilyUser familyUserFromJson(String str) =>
    FamilyUser.fromJson(json.decode(str));

class FamilyUser {
  FamilyUser({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory FamilyUser.fromJson(Map<String, dynamic> json) => FamilyUser(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.users,
  });

  List<FamilyUserMember> users;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: json["users"] == null
            ? []
            : List<FamilyUserMember>.from(
                json["users"].map((x) => FamilyUserMember.fromJson(x))),
      );
}

class FamilyUserMember {
  FamilyUserMember({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.phoneNumber,
    required this.image,
    required this.invitationStatus,
  });

  String id;
  String firstName;
  String lastName;
  String name;
  String phoneNumber;
  String image;
  int invitationStatus;

  factory FamilyUserMember.fromJson(Map<String, dynamic> json) =>
      FamilyUserMember(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        image: json["image"] == null ? null : json["image"],
        invitationStatus: json["invitation_status"] == null
            ? null
            : json["invitation_status"],
      );
}
