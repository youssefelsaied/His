import 'dart:convert';

FamilyChildren familyChildrenFromJson(String str) =>
    FamilyChildren.fromJson(json.decode(str));

class FamilyChildren {
  FamilyChildren({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data? data;
  String message;

  factory FamilyChildren.fromJson(Map<String, dynamic> json) => FamilyChildren(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    required this.children,
  });

  List<Child> children;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        children: json["children"] == null
            ? []
            : List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
      );
}

class Child {
  Child({
    required this.id,
    required this.name,
    required this.birthday,
  });

  int id;
  String name;
  DateTime? birthday;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
      );
}
