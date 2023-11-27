import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/Checkout/confirm_order.dart';
import 'package:m3ak_user/Locale/locale.dart';
import 'package:m3ak_user/data/branches_by_brand.dart';
import 'package:m3ak_user/data/brands_by_category.dart';
import 'package:m3ak_user/data/cart_item.dart';
import 'package:m3ak_user/data/favourite.dart';
import 'package:m3ak_user/data/market_home.dart' as mh;
import 'package:m3ak_user/data/menu.dart';
import 'package:m3ak_user/data/promo.dart';
import '../data/address.dart';
import '../data/heighlight_offer.dart';
import '../data/offer.dart';
import '../providers/request.dart';

class MenuProvider with ChangeNotifier {
  List<CartItem> myCart = [];
  Request request = Request();
  mh.Data? marketHome;
  mh.CategoryData? marketCategory;
  List<mh.Item> marketShortcutItems = [];
  List<mh.MarketOrderElement> marketOrders = [];
  List<Category> homeCategories = [];
  List<Brand> favouriteBrands = [];
  List<Brand> categoryBrands = [];
  List<Brand> searchBrands = [];
  List<Branch> brandBranches = [];
  List<BrandService> brandServices = [];
  List<OfferElement> offers = [];
  List<HighlightsOfferElement> highlightsOffers = [];
  Branch? callCenterBranch;
  Branch? selectedNonCallCenterBranch;
  String error = '';
  int brandPage = 1;
  int lastBrandPage = 10000000;
  int branchPage = 1;
  int lastBranchPage = 10000000;
  bool loading = false;

  void selectBranchToOrder(Branch b) {
    selectedNonCallCenterBranch = b;
    notifyListeners();
  }

  void addItemOrOfferToMycart(dynamic product) {
    CartItem cartItem = CartItem(count: 1, item: product);
    CartItem item = myCart.firstWhere(
        (element) => element.item.id == product.id && element.item == product,
        orElse: () => CartItem(count: 0, item: null));
    if (item.count == 0) {
      myCart.add(cartItem);
      print("New Item Added");
    } else {
      // myCart
      //     .firstWhere((element) =>
      //         element.item.id == product.id && element.item == product)
      //     .count++;
      item.count++;
      print("item added before");
      print(item.count);
    }
    print(myCart.length);
    notifyListeners();
  }

  void minusCount(dynamic product) {
    CartItem item = myCart.firstWhere(
        (element) => element.item.id == product.id && element.item == product,
        orElse: () => CartItem(count: 0, item: null));
    if (item.count == 0) {
      print("error");
    } else if (item.count > 1) {
      // myCart
      //     .firstWhere((element) =>
      //         element.item.id == product.id && element.item == product)
      //     .count--;
      item.count--;
      print("item plus");
    } else {
      myCart.remove(item);
    }
    notifyListeners();
  }

  void plusCount(dynamic product) {
    CartItem cartItem = CartItem(count: 1, item: product);
    CartItem item = myCart.firstWhere(
        (element) => element.item.id == product.id && element.item == product,
        orElse: () => CartItem(count: 0, item: null));
    if (item.count == 0) {
      myCart.add(cartItem);
      // print("error");
    } else {
      // myCart.firstWhere((element) => element.item.id == product.id).count++;
      item.count++;
      print("item plus");
    }
    notifyListeners();
  }

  double calculateSubTotalMoney() {
    double total = 0.0;
    myCart.forEach((element) {
      total =
          total + double.parse(element.item.price.toString()) * element.count;
    });
    return total;
  }

  double calculateTotalMoney() {
    double total = 0.0;
    if (usedPromoCode == null) {
      total = calculateSubTotalMoney();
    } else {
      total = (calculateSubTotalMoney() -
          (calculateSubTotalMoney() * usedPromoCode!.discount * .01));
    }
    return total;
  }

  int calculateTotalCount() {
    int total = 0;
    myCart.forEach((element) {
      total = total + element.count;
    });
    return total;
  }

  void clearselectedBranchToOrder() {
    selectedNonCallCenterBranch = null;
    notifyListeners();
  }

  void clearselectedCallCenterBranchToOrder() {
    callCenterBranch = null;
    notifyListeners();
  }

  void selectCallCenterBranchToOrder(Branch b) {
    callCenterBranch = b;
    notifyListeners();
  }

  void changeMenuLanguage(code) {
    request.code = code;
  }

  void clearSearchBrands() {
    searchBrands = [];
    notifyListeners();
  }

  void clearCart() {
    myCart = [];
    notifyListeners();
  }

  bool orderLoading = false;
  int placedOrderId = -1;

  Future<bool> marketPlaceOrder(AddressElement address, token, payment) async {
    try {
      var body = usedPromoCode == null
          ? {
              "address_id": address.id,
              "final_price": calculateSubTotalMoney(),
              "payment_method": payment,
              "items": myCart
                  .map(
                    (cartItem) => {
                      "market_place_item_id": cartItem.item.id,
                      "quantity": cartItem.count
                    },
                  )
                  .toList(),
            }
          : {
              "address_id": address.id,
              "final_price": calculateSubTotalMoney(),
              "payment_method": payment,
              "price_with_dscount": null,
              "promoCode_id": usedPromoCode!.id,
              "items": myCart
                  .map(
                    (cartItem) => {
                      "market_place_item_id": cartItem.item.id,
                      "quantity": cartItem.count
                    },
                  )
                  .toList(),
            };

      final response = await request.postRequest(
          route: 'user/marketplace/make/order', data: body, token: token);

      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode.toString().startsWith('2')) {
        placedOrderId = responseData["data"]["order_id"];
        return true;
      } else {
        error = responseData['detail'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw 'please try again later';
    }
  }

  PromoCode? usedPromoCode;

  Future<bool> marketCheckPromo(token, promo) async {
    try {
      var body = {
        "code": promo,
      };

      final response = await request.postRequest(
          route: 'user/check/promoCode', data: body, token: token);

      final responseData = json.decode(response.body);
      print(responseData);
      if (response.statusCode.toString().startsWith('2')) {
        usedPromoCode = Promo.fromJson(responseData).data.promoCode;
        return true;
      } else {
        // error = responseData['detail'];
        usedPromoCode = null;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw 'please try again later';
    }
  }

  // Future<bool> fetchMenu(token) async {
  //   // final deviceToken = await _firebaseMessaging.getToken();
  //   print("fetchMenu");
  //   try {
  //     // var locale = AppLocalizations.of(context)!;

  //     final response = await request.getRequest('user/home', token);
  //     final responseData = json.decode(response.body);
  //     print(responseData);
  //     var medCons =
  //         request.code == 'en' ? "Medication Advice" : "استشارات دوائية";
  //     homeCategories = [];
  //     homeCategories.add(
  //         Category(id: 1000000, title: medCons, image: "", subCategories: []));
  //     homeCategories.addAll(Menu.fromJson(responseData).data!.categories);
  //     // homeCategories = (Menu.fromJson(responseData).data!.categories!);
  //     notifyListeners();
  //     // notifyListeners();
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<bool> fetchMarketOrders(token) async {
  //   // final deviceToken = await _firebaseMessaging.getToken();
  //   print("fetchMenu");
  //   try {
  //     // var locale = AppLocalizations.of(context)!;

  //     final response =
  //         await request.getRequest('user/get/marketplace/make/order', token);
  //     final responseData = json.decode(response.body);
  //     print(responseData);
  //     marketOrders = mh.MarketOrder.fromJson(responseData).data.orders;
  //     notifyListeners();
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<bool> fetchMarketHome(token) async {
  //   // final deviceToken = await _firebaseMessaging.getToken();
  //   print("fetchMarketHome");
  //   try {
  //     // var locale = AppLocalizations.of(context)!;

  //     final response = await request.getRequest('user/home/marketplace', token);
  //     final responseData = json.decode(response.body);
  //     print(responseData);
  //     marketHome = mh.MarketHome.fromJson(responseData).data;
  //     notifyListeners();
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<bool> fetchMarketCategories(token, id) async {
    // final deviceToken = await _firebaseMessaging.getToken();
    print("fetchMarketHome");
    try {
      // var locale = AppLocalizations.of(context)!;

      final response = await request.postRequest(
          route: 'user/category/subcategoru/items',
          data: {"id": id},
          token: token);
      final responseData = json.decode(response.body);
      print(responseData);
      marketCategory = mh.MarketCategories.fromJson(responseData).data;
      List<mh.Item> allItems = [];
      marketCategory!.category.subCategories.forEach((element) {
        allItems.addAll(element.items);
      });
      marketCategory!.category.allItems = allItems;
      notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> fetchMarketShortcutItems(token, shortcutId) async {
    print("fetchMarketShortcutItems");
    try {
      marketShortcutItems = [];
      final response = await request.postRequest(data: {
        "id": shortcutId,
      }, route: 'user/shortcut/items', token: token);
      final responseData = json.decode(response.body);
      print(responseData);
      marketShortcutItems =
          mh.MarketShortcutItems.fromJson(responseData).data.items;
      notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> searchBrandsbyName(token, name, brandTypeId) async {
    // final deviceToken = await _firebaseMessaging.getToken();
    print("fetchFavourites");
    try {
      loading = true;
      notifyListeners();
      final response = await request.postRequest(
          data: {"name": name, "brand_type_id": brandTypeId},
          route: 'user/search',
          token: token);
      final responseData = json.decode(response.body);
      print(responseData);
      var data = BrandsByCategory.fromJson(responseData).data!;
      searchBrands = data.brands;
      loading = false;
      notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }

  // Future<bool> searchBrandsbyNameNoCatId(token, name) async {
  //   // final deviceToken = await _firebaseMessaging.getToken();
  //   print("fetchFavourites");
  //   try {
  //     loading = true;
  //     notifyListeners();
  //     final response = await request.postRequest(
  //         data: {"name": name}, route: 'user/search', token: token);
  //     final responseData = json.decode(response.body);
  //     print(responseData);
  //     var data = BrandsByCategory.fromJson(responseData).data!;
  //     searchBrands = data.brands;
  //     loading = false;
  //     notifyListeners();
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<bool> fetchFavourites(token) async {
  //   // final deviceToken = await _firebaseMessaging.getToken();
  //   print("fetchFavourites");
  //   try {
  //     final response = await request.getRequest('user/myFavourite', token);
  //     final responseData = json.decode(response.body);
  //     print(responseData);
  //     favouriteBrands = (Favourite.fromJson(responseData).data!.brands);
  //     // homeCategories = (Menu.fromJson(responseData).data!.categories!);
  //     notifyListeners();
  //     // notifyListeners();
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<bool> fetchOffers(token) async {
  //   // final deviceToken = await _firebaseMessaging.getToken();
  //   print("fetchOffers");
  //   try {
  //     final response = await request.getRequest('user/get/all/offers', token);
  //     final responseData = json.decode(response.body);
  //     print(responseData);
  //     offers = (Offer.fromJson(responseData).data!.offers);
  //     notifyListeners();
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<bool> fetchHighlightsOffers(token) async {
  //   // final deviceToken = await _firebaseMessaging.getToken();
  //   print("fetchHighlightsOffers");
  //   try {
  //     final response =
  //         await request.getRequest('user/get/all/highlightsOffers', token);
  //     final responseData = json.decode(response.body);
  //     print(responseData);
  //     highlightsOffers =
  //         (HighlightsOffer.fromJson(responseData).data!.highlightsOffers);
  //     notifyListeners();
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<bool> getBrandsBySubCategoryIdFirstTime(
      token, subCategoryId, code) async {
    // final deviceToken = await _firebaseMessaging.getToken();
    print("fetchBrandsBySubCategoryIdFirstTime");
    print(token);
    brandPage = 1;
    lastBrandPage = 10000000;
    if (brandPage <= lastBrandPage) {
      try {
        loading = true;
        // notifyListeners();
        final url =
            'https://${request.usedUrl}/api/user/get/all/brands/subCategroy?page=1';
        print(url);
        Dio dio = new Dio();
        FormData formData = new FormData.fromMap({
          "id": subCategoryId,
        });
        var response = await dio.post(
          url,
          options: Options(
            headers: {
              'Content-type': 'multipart/form-data',
              'Accept': 'application/json',
              'Accept-language': code,
              'Authorization': 'Bearer $token',
            },
            // followRedirects: false,
            // validateStatus: (status) {
            //   return status == 500;
            // }
          ),
          data: formData,
          onSendProgress: (int sent, int total) {
            // saveLoadingTxt =
            //     'Updating profile ${((sent / total) * 100).ceil()} %';
            // notifyListeners();
            debugPrint("sent${sent.toString()}" + " total${total.toString()}");
          },
        );
        //  final response = await request.postRequest(
        //         route: 'user/get/all/brands',
        //         token: token,
        //         data: {"id": categoryId},
        //         page: 1);
        final responseData = response.data;
        // print(response.statusCode);
        print(responseData);
        print(response.statusCode);

        var data = BrandsByCategory.fromJson(responseData).data!;
        categoryBrands = data.brands;
        lastBrandPage = data.lastPage!;
        brandPage++;
        loading = false;

        notifyListeners();
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        throw e;
      }
    } else {
      return false;
    }
  }

  Future<bool> getBrandsBySubCategoryId(token, subCategoryId, code) async {
    // final deviceToken = await _firebaseMessaging.getToken();
    print("fetchBrandsBySubCategoryId");
    print(brandPage);

    if (brandPage <= lastBrandPage) {
      try {
        final url =
            'https://${request.usedUrl}/api/user/get/all/brands/subCategroy?page=$brandPage';
        print(url);
        Dio dio = new Dio();
        FormData formData = new FormData.fromMap({
          "id": subCategoryId,
        });
        var response = await dio.post(
          url,
          options: Options(
            headers: {
              'Content-type': 'multipart/form-data',
              'Accept': 'application/json',
              'Accept-language': code,
              'Authorization': 'Bearer $token',
            },
            // followRedirects: false,
            // validateStatus: (status) {
            //   return status == 500;
            // }
          ),
          data: formData,
          onSendProgress: (int sent, int total) {
            // saveLoadingTxt =
            //     'Updating profile ${((sent / total) * 100).ceil()} %';
            // notifyListeners();
            debugPrint("sent${sent.toString()}" + " total${total.toString()}");
          },
        );
        //  final response = await request.postRequest(
        //         route: 'user/get/all/brands',
        //         token: token,
        //         data: {"id": categoryId},
        //         page: 1);
        final responseData = response.data;
        print(responseData);
        var data = BrandsByCategory.fromJson(responseData).data!;
        categoryBrands.addAll(data.brands);
        lastBrandPage = data.lastPage!;
        brandPage++;
        notifyListeners();
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        throw e;
      }
    } else {
      return false;
    }
  }

  Future<bool> getBrandsByCategoryIdFirstTime(token, categoryId, code) async {
    // final deviceToken = await _firebaseMessaging.getToken();
    print("fetchMenu");
    print(token);
    brandPage = 1;
    lastBrandPage = 10000000;
    if (brandPage <= lastBrandPage) {
      try {
        loading = true;
        // notifyListeners();
        final url = 'https://${request.usedUrl}/api/user/get/all/brands?page=1';
        print(url);
        Dio dio = new Dio();
        FormData formData = new FormData.fromMap({
          "id": categoryId,
        });
        var response = await dio.post(
          url,
          options: Options(
            headers: {
              'Content-type': 'multipart/form-data',
              'Accept': 'application/json',
              'Accept-language': code,
              'Authorization': 'Bearer $token',
            },
            // followRedirects: false,
            // validateStatus: (status) {
            //   return status == 500;
            // }
          ),
          data: formData,
          onSendProgress: (int sent, int total) {
            // saveLoadingTxt =
            //     'Updating profile ${((sent / total) * 100).ceil()} %';
            // notifyListeners();
            debugPrint("sent${sent.toString()}" + " total${total.toString()}");
          },
        );
        //  final response = await request.postRequest(
        //         route: 'user/get/all/brands',
        //         token: token,
        //         data: {"id": categoryId},
        //         page: 1);
        final responseData = response.data;
        // print(response.statusCode);
        print(responseData);
        print(response.statusCode);

        var data = BrandsByCategory.fromJson(responseData).data!;
        categoryBrands = data.brands;
        lastBrandPage = data.lastPage!;
        brandPage++;
        loading = false;

        notifyListeners();
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        throw e;
      }
    } else {
      return false;
    }
  }

  Future<bool> getBrandsByCategoryId(token, categoryId, code) async {
    // final deviceToken = await _firebaseMessaging.getToken();
    print("fetchMenu");
    print(brandPage);

    if (brandPage <= lastBrandPage) {
      try {
        final url =
            'https://${request.usedUrl}/api/user/get/all/brands?page=$brandPage';
        print(url);
        Dio dio = new Dio();
        FormData formData = new FormData.fromMap({
          "id": categoryId,
        });
        var response = await dio.post(
          url,
          options: Options(
            headers: {
              'Content-type': 'multipart/form-data',
              'Accept': 'application/json',
              'Accept-language': code,
              'Authorization': 'Bearer $token',
            },
            // followRedirects: false,
            // validateStatus: (status) {
            //   return status == 500;
            // }
          ),
          data: formData,
          onSendProgress: (int sent, int total) {
            // saveLoadingTxt =
            //     'Updating profile ${((sent / total) * 100).ceil()} %';
            // notifyListeners();
            debugPrint("sent${sent.toString()}" + " total${total.toString()}");
          },
        );
        //  final response = await request.postRequest(
        //         route: 'user/get/all/brands',
        //         token: token,
        //         data: {"id": categoryId},
        //         page: 1);
        final responseData = response.data;
        print(responseData);
        var data = BrandsByCategory.fromJson(responseData).data!;
        categoryBrands.addAll(data.brands);
        lastBrandPage = data.lastPage!;
        brandPage++;
        notifyListeners();
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        throw e;
      }
    } else {
      return false;
    }
  }

  Future<bool> getBranchesByBrandsIdFirstTime(token, brandId, code) async {
    // final deviceToken = await _firebaseMessaging.getToken();
    print("fetchMenu");
    print(token);
    branchPage = 1;
    lastBranchPage = 10000000;
    if (branchPage <= lastBranchPage) {
      try {
        loading = true;
        final url = 'https://${request.usedUrl}/api/user/show/brand?page=1';
        print(url);
        Dio dio = new Dio();
        FormData formData = new FormData.fromMap({
          "id": brandId,
        });
        var response = await dio.post(
          url,
          options: Options(
            headers: {
              'Content-type': 'multipart/form-data',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
              'Accept-Language': code,
            },
          ),
          data: formData,
          onSendProgress: (int sent, int total) {
            // saveLoadingTxt =
            //     'Updating profile ${((sent / total) * 100).ceil()} %';
            // notifyListeners();
            debugPrint("sent${sent.toString()}" + " total${total.toString()}");
          },
        );
        //  final response = await request.postRequest(
        //         route: 'user/get/all/brands',
        //         token: token,
        //         data: {"id": categoryId},
        //         page: 1);
        final responseData = response.data;
        // print(response.statusCode);
        print(responseData);
        print(response.statusCode);

        var data = BranchesByBrands.fromJson(responseData).data!;
        brandBranches = data.branches;
        brandServices = data.brandServices;
        lastBranchPage = data.lastPage;
        branchPage++;
        if (brandBranches[0].callCenter == 1) {
          callCenterBranch = brandBranches[0];
        }
        loading = false;

        notifyListeners();
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        throw e;
      }
    } else {
      return false;
    }
  }

  Future<bool> getBranchesByBrandsId(token, brandId, code) async {
    print("fetchMenu getBranchesByBrandsId");
    print(branchPage);
    if (branchPage <= lastBranchPage) {
      try {
        // loading = true;
        final url =
            'https://${request.usedUrl}/api/user/show/brand?page=$branchPage';
        print(url);
        Dio dio = new Dio();
        FormData formData = new FormData.fromMap({
          "id": brandId,
        });
        var response = await dio.post(
          url,
          options: Options(
            headers: {
              'Content-type': 'multipart/form-data',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
              'Accept-Language': code,
            },
          ),
          data: formData,
          onSendProgress: (int sent, int total) {
            debugPrint("sent${sent.toString()}" + " total${total.toString()}");
          },
        );

        final responseData = response.data;
        print(responseData);
        print(response.statusCode);

        var data = BranchesByBrands.fromJson(responseData).data!;
        brandBranches.addAll(data.branches);
        // brandServices = data.brandServices;
        lastBranchPage = data.lastPage;
        branchPage++;
        loading = false;

        notifyListeners();
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        throw e;
      }
    } else {
      return false;
    }
  }

  Future<bool> ScanBranch(token, branchId) async {
    print("ScanBranch");
    try {
      final response = await request.postRequest(
          token: token,
          route: 'user/scan/branch',
          data: {"branch_id": branchId});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Future<bool> favouriteBrand(token, brandId) async {
  //   print("favouriteBrand");
  //   try {
  //     final response = await request.postRequest(
  //         token: token,
  //         route: 'user/favourite/brand',
  //         data: {"brand_id": brandId});
  //     // final responseData = json.decode(response.body);
  //     // print(responseData);
  //     if (response.statusCode == 200) {
  //       fetchFavourites(token);
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
