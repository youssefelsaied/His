import 'dart:convert';

FamilyMembers familyMembersFromJson(String str) =>
    FamilyMembers.fromJson(json.decode(str));

class FamilyMembers {
  FamilyMembers({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data? data;
  String message;

  factory FamilyMembers.fromJson(Map<String, dynamic> json) => FamilyMembers(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.family,
  });

  List<FamilyMember> family;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        family: json["family"] == null
            ? []
            : List<FamilyMember>.from(
                json["family"].map((x) => FamilyMember.fromJson(x))),
      );
}

class FamilyMember {
  FamilyMember({
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

  String id;
  bool status;
  String firstName;
  String lastName;
  String name;
  String phoneNumber;
  String email;
  String memberNum;
  String image;

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
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
