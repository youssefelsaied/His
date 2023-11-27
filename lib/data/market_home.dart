// To parse this JSON data, do
//
//     final marketHome = marketHomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'address.dart';

MarketHome marketHomeFromJson(String str) =>
    MarketHome.fromJson(json.decode(str));

class MarketHome {
  MarketHome({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory MarketHome.fromJson(Map<String, dynamic> json) => MarketHome(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );
}

class Data {
  Data({
    required this.shotcuts,
    required this.categories,
    required this.adds,
    required this.offers,
  });

  List<HomeCategory> shotcuts;
  List<HomeCategory> categories;
  List<Add> adds;
  List<Offer> offers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        shotcuts: List<HomeCategory>.from(
            json["shotcuts"].map((x) => HomeCategory.fromJson(x))),
        categories: List<HomeCategory>.from(
            json["categories"].map((x) => HomeCategory.fromJson(x))),
        adds: List<Add>.from(json["adds"].map((x) => Add.fromJson(x))),
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
      );
}

class Add {
  Add({
    required this.id,
    required this.image,
    required this.marketPlaceShortcutId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String image;
  int marketPlaceShortcutId;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Add.fromJson(Map<String, dynamic> json) => Add(
        id: json["id"],
        image: json["image"],
        marketPlaceShortcutId: json["market_place_shortcut_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "market_place_shortcut_id": marketPlaceShortcutId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class HomeCategory {
  HomeCategory({
    required this.id,
    required this.title,
    required this.status,
    required this.image,
  });

  int id;
  String title;
  bool status;
  String image;

  factory HomeCategory.fromJson(Map<String, dynamic> json) => HomeCategory(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "image": image,
      };
}

class Seller {
  Seller({
    required this.id,
    required this.title,
    required this.status,
    required this.image,
  });

  String id;
  String title;
  bool status;
  String image;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        image: json["image"],
      );
}

class Offer {
  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.pointsTaken,
    required this.images,
    required this.items,
  });

  int id;
  String title;
  String description;
  String price;
  String pointsTaken;
  List<Image> images;
  List<Item> items;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        pointsTaken: json["points_taken"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Image {
  Image({
    required this.id,
    required this.image,
  });

  int id;
  String image;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class Item {
  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.priceBefore,
    required this.price,
    required this.pointsTaken,
    required this.brandId,
    required this.brand,
    required this.discoutPrecentage,
    required this.seller,
    required this.status,
    required this.stockAvailable,
    required this.images,
  });

  int id;
  String title;
  String description;
  String priceBefore;
  String price;
  int pointsTaken;
  int brandId;
  Brand brand;
  String discoutPrecentage;
  Seller seller;
  bool status;
  bool stockAvailable;
  List<dynamic> images;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        priceBefore: json["price_before"].toString(),
        price: json["price"],
        pointsTaken: json["points_taken"],
        brandId: json["brand_id"],
        brand: Brand.fromJson(json["brand"]),
        discoutPrecentage: json["discout_precentage"].toString(),
        seller: Seller.fromJson(json["seller"]),
        status: json["status"],
        stockAvailable: json["stock_available"],
        images: List<Image>.from(json["images"].map((x) => x)),
      );
}

MarketShortcutItems marketShortcutItemsFromJson(String str) =>
    MarketShortcutItems.fromJson(json.decode(str));

class MarketShortcutItems {
  MarketShortcutItems({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  ShortcutData data;
  String message;

  factory MarketShortcutItems.fromJson(Map<String, dynamic> json) =>
      MarketShortcutItems(
        success: json["success"],
        data: ShortcutData.fromJson(json["data"]),
        message: json["message"],
      );
}

class ShortcutData {
  ShortcutData({
    required this.items,
  });

  List<Item> items;

  factory ShortcutData.fromJson(Map<String, dynamic> json) => ShortcutData(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Brand {
  Brand({
    required this.id,
    required this.title,
    required this.image,
    required this.status,
  });

  int id;
  String title;
  String image;
  bool status;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        status: json["status"],
      );
}

MarketCategories marketCategoriesFromJson(String str) =>
    MarketCategories.fromJson(json.decode(str));

class MarketCategories {
  MarketCategories({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  CategoryData data;
  String message;

  factory MarketCategories.fromJson(Map<String, dynamic> json) =>
      MarketCategories(
        success: json["success"],
        data: CategoryData.fromJson(json["data"]),
        message: json["message"],
      );
}

class CategoryData {
  CategoryData({
    required this.category,
  });

  Category category;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        category: Category.fromJson(json["category"]),
      );
}

class Category {
  Category({
    required this.id,
    required this.title,
    required this.status,
    required this.image,
    required this.subCategories,
    required this.allItems,
  });

  int id;
  String title;
  bool status;
  String image;
  List<SubCategory> subCategories;
  List<Item> allItems;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        image: json["image"],
        subCategories: List<SubCategory>.from(
            json["sub_categories"].map((x) => SubCategory.fromJson(x))),
        allItems: [],
      );
}

class SubCategory {
  SubCategory({
    required this.id,
    required this.title,
    required this.status,
    required this.image,
    required this.items,
  });

  int id;
  String title;
  bool status;
  String image;
  List<Item> items;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        image: json["image"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class MarketOrder {
  MarketOrder({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  OrderData data;
  String message;

  factory MarketOrder.fromJson(Map<String, dynamic> json) => MarketOrder(
        success: json["success"],
        data: OrderData.fromJson(json["data"]),
        message: json["message"],
      );
}

class OrderData {
  OrderData({
    required this.orders,
  });

  List<MarketOrderElement> orders;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        orders: List<MarketOrderElement>.from(
            json["orders"].map((x) => MarketOrderElement.fromJson(x))),
      );
}

class MarketOrderElement {
  MarketOrderElement({
    required this.id,
    required this.userId,
    required this.address,
    required this.status,
    required this.date,
    required this.note,
    required this.transactionId,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.items,
  });

  int id;
  String userId;
  AddressElement? address;
  String status;
  String date;
  String note;
  String transactionId;
  bool paymentMethod;
  dynamic paymentStatus;
  List<Item> items;

  factory MarketOrderElement.fromJson(Map<String, dynamic> json) =>
      MarketOrderElement(
        id: json["id"],
        userId: json["user_id"],
        address: json["address"] == null
            ? null
            : AddressElement.fromJson(json["address"]),
        status: json["status"],
        date: json["date"],
        note: json["note"],
        transactionId: json["transaction_id"].toString(),
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}
