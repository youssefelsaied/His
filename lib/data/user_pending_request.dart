import 'package:meta/meta.dart';
import 'dart:convert';

UserPendingRequests userPendingRequestsFromJson(String str) =>
    UserPendingRequests.fromJson(json.decode(str));

class UserPendingRequests {
  UserPendingRequests({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data? data;
  String message;

  factory UserPendingRequests.fromJson(Map<String, dynamic> json) =>
      UserPendingRequests(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.sent,
    required this.received,
  });

  List<FamilyRequest> sent;
  List<FamilyRequest> received;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sent: json["sent"] == null
            ? []
            : List<FamilyRequest>.from(
                json["sent"].map((x) => FamilyRequest.fromJson(x))),
        received: json["received"] == null
            ? []
            : List<FamilyRequest>.from(
                json["received"].map((x) => FamilyRequest.fromJson(x))),
      );
}

class FamilyRequest {
  FamilyRequest({
    required this.id,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.memberNum,
    required this.image,
  });

  int id;
  int status;
  String firstName;
  String lastName;
  String name;
  String phoneNumber;
  String email;
  String memberNum;
  String image;

  factory FamilyRequest.fromJson(Map<String, dynamic> json) => FamilyRequest(
        id: json["id"] == null ? null : json["id"],
        status: json["status"] == null ? null : json["status"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        email: json["email"] == null ? null : json["email"],
        memberNum: json["member_num"] == null ? null : json["member_num"],
        image: json["image"] == null ? null : json["image"],
      );
}
