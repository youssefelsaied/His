import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:m3ak_user/data/address.dart';
import 'package:m3ak_user/data/appoinment.dart';
import 'package:m3ak_user/data/billing.dart';
import 'package:m3ak_user/data/city.dart';
import 'package:m3ak_user/data/doctor.dart';
import 'package:m3ak_user/data/dr_patient_record.dart';
import 'package:m3ak_user/data/family_member.dart';
import 'package:m3ak_user/data/fawry_refrence_code.dart';
import 'package:m3ak_user/data/first_api_token.dart';
import 'package:m3ak_user/data/notification.dart';
import 'package:m3ak_user/data/order_id.dart';
import 'package:m3ak_user/data/payment_key.dart';
import 'package:m3ak_user/data/payment_method.dart';
import 'package:m3ak_user/data/record.dart';
import 'package:m3ak_user/data/success.dart';
import 'package:m3ak_user/data/transaction.dart';
import 'package:m3ak_user/data/user_pending_request.dart';
import 'package:m3ak_user/data/wallet.dart';
import 'package:m3ak_user/map_utils.dart';
import '../data/cart_item.dart';
import '../data/code_package.dart';
import '../data/doctor_appoinntment.dart';
import '../data/dr_patient.dart';
import '../data/family_children.dart';
import '../data/family_user.dart';
import '../data/market_home.dart';
import '../data/order.dart';
import '../data/slots.dart';
import '../data/subscription.dart';
import '../data/user.dart';
import '../data/user_package.dart';
import '../providers/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:crypto/crypto.dart';

class Auth with ChangeNotifier {
  String androidVersionNumber = "1.0.0";
  String iosVersionNumber = "1.0.0";
  static const String PaymobApiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TWpFMU5UWTNMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuX0t6WENFekFUbnlTdTd3eFdLcFRMZ3Z4Rng5VUJ3NzlULXJNQkFfNFlsMDZYUlZqYmVYUzNkQ1lWRXJ3bGFDVkd2NV9aZUtPZDV3R1Zrck1KT3pYQlE=";
  static const int IntegrationId = 2427573;
  // static const String FawryMerchantId = "+/IAAY2notjLwOND1DK0Gg==";
  static const String FawryMerchantId = "+/IAAY2notjLwOND1DK0Gg==";
  static const int kioskIntegrationId = 2801457;
  String? firstToken;
  String _password = '';
  FawryRefrenceCode? FawryCode;
  String? orderId;
  String? LastToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String otpReason = "";
  Request request = Request();
  List<City> avialableCites = [];
  AddressElement? selectedAddress;
  List<AddressElement> avialableAddresses = [];
  List<OrderElement> myOrders = [];
  List<Order> avialableOrders = [];
  List<Package> avialablePackages = [];
  List<PaymentMethodElement> avialablePaymentMethods = [];
  List<FamilyUserMember> FamilyUserMembers = [];
  List<UserPackageElement> userPackages = [];
  List<UserNotificationModel> userNotifications = [];
  List<FamilyRequest> userPendingRequests = [];
  List<Child> children = [];
  List<FamilyMember> familyMembers = [];
  UserPackageElement? myPackage;
  TextEditingController childFirstNameController = TextEditingController();
  Code? packageCode;

  WalletDate? myWallet;
  User? theUser;
  List<Record> myRecords = [];
  List<DoctorPatientRecord> DrPatientRecords = [];
  List<AvilableSlots> avilableSlots = [];
  List<Billing> myBillings = [];
  List<Doctor> avilableDoctors = [];
  List<Appointment> appoinments = [];
  List<DoctorAppointment> doctorAppointments = [];
  List<DoctorPatient> doctorPatients = [];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String error = '';

  final TextEditingController signInUserNameController =
      TextEditingController();
  final TextEditingController signInPasswordController =
      TextEditingController();

  final TextEditingController signUpUserNameController =
      TextEditingController();
  final TextEditingController signUpDateController = TextEditingController();
  final TextEditingController signUpGenderController = TextEditingController();
  final TextEditingController signUpPhoneController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();

  // final TextEditingController phoneNumberController = TextEditingController();
  // final TextEditingController firstNameController = TextEditingController();
  // final TextEditingController lastNameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  // final TextEditingController confirmPasswordController =
  //     TextEditingController();

  int lastSeenNotifications = 0;
  int currentNotifications = 0;

  void changeAuthLanguage(code) {
    request.code = code;
  }

  void setOtpReason(String reason) {
    otpReason = reason;
    notifyListeners();
  }

  void setSelectedAddressId(AddressElement address) {
    selectedAddress = address;
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final SharedPreferences prefs = await _prefs;

    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = prefs.getString("userData");
    final extractedpassword = prefs.getString("password");
    if (extractedUserData!.isNotEmpty) {
      // log(extractedUserData.toString());
      // print("autologin");

      theUser = userFromJson(extractedUserData);

      if (extractedpassword!.isNotEmpty) {
        _password = extractedpassword;
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveToSharedPrefrence(password) async {
    final prefs = await _prefs;
    prefs.setString("userData", userToJson(theUser!));
    prefs.setString("password", password);
    _password = password;
  }

  Future<bool> makeAppointment(doctorId, slotId, notes) async {
    try {
      final response = await request.postRequest(
          data: {
            "PatientId": theUser!.id,
            "DoctorId": doctorId,
            "AppointmentSlotId": slotId,
            "Notes": notes
          },
          route: 'appointments',
          username: theUser!.username,
          password: _password);
      print(response);

      final responseData = json.decode(response.body);
      print(responseData);

      // notifyListeners();
      if (response.statusCode == 200) {
        getAppoinments();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> cancelAppointment(appointmentId) async {
    print(appointmentId);
    try {
      var url = Uri.http(
        request.usedUrl,
        "/api/" + "appointments/$appointmentId",
      );
      print(url);
      String basicAuth = 'Basic ' +
          base64.encode(utf8.encode('${theUser!.username}:$_password'));

      final response = await http.delete(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': basicAuth,
        },
      );

      // final response = await  (
      //    , theUser!.username, _password);
      print(response);

      final responseData = json.decode(response.body);
      print(responseData);

      // notifyListeners();
      if (response.statusCode == 200) {
        getAppoinments();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> addMedicalRecord(
      patientId, date, diagnosis, prescription) async {
    try {
      final response = await request.postRequest(
          data: {
            "PatientId": patientId,
            "DoctorId": theUser!.id,
            "Date": date,
            "Diagnosis": diagnosis,
            "Prescription": prescription
          },
          route: 'doctors/${theUser!.id}/medical-records',
          username: theUser!.username,
          password: _password);
      print(response);
      final responseData = json.decode(response.body);
      print(responseData);

      // notifyListeners();
      if (response.statusCode == 200) {
        getDoctorPatientRecords(patientId);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
      print("e is $e");
      throw 'Could not authenticate you, please try again later';
    }
  }

  Future<bool> signIn() async {
    try {
      final response = await request.postRequest(data: {
        "username": signInUserNameController.text,
        "password": signInPasswordController.text,
      }, route: 'login');
      final responseData = json.decode(response.body);
      print(responseData);
      theUser = User.fromJson(responseData);
      print("${theUser!.id} authenticated successfully");
      notifyListeners();
      saveToSharedPrefrence(signInPasswordController.text);

      // notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
      print("e is $e");
      throw 'Could not authenticate you, please try again later';
    }
  }

  Future<bool> createPatient(username, date, gender, phone, email) async {
    try {
      final response = await request.postRequest(data: {
        "Username": "youssef2",
        "DateOfBirth": "2000-02-15",
        "Gender": "Male",
        "Phone": "123-456-7890",
        "Email": "youssef.doe@example.com"
      }, route: 'login', username: username, password: _password);
      final responseData = json.decode(response.body);
      print(responseData);
      theUser = User.fromJson(responseData);
      print("${theUser!.id} authenticated successfully");
      notifyListeners();
      saveToSharedPrefrence(signInPasswordController.text);

      // notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
      print("e is $e");
      throw 'Could not authenticate you, please try again later';
    }
  }

  Future<bool> signUp() async {
    try {
      final response = await request.postRequest(data: {
        "Username": signUpUserNameController.text,
        "Password": signUpPasswordController.text,
      }, route: 'signup');

      final responseData = json.decode(response.body);
      print(response.body);

      // notifyListeners();
      if (response.statusCode == 200) {
        final response2 = await request.postRequest(
            data: {
              "Username": signUpUserNameController.text,
              "DateOfBirth": signUpDateController.text.toString(),
              "Gender": signUpGenderController.text,
              "Phone": signUpPhoneController.text,
              "Email": signUpEmailController.text
            },
            route: 'patients',
            username: signUpUserNameController.text,
            password: signUpPasswordController.text);
        final responseData2 = json.decode(response2.body);
        print(responseData2);

        if (response2.statusCode == 200) {
          final response3 = await request.postRequest(data: {
            "username": signUpUserNameController.text,
            "password": signUpPasswordController.text,
          }, route: 'login');
          final responseData = json.decode(response3.body);
          print(responseData);
          theUser = User.fromJson(responseData);
          print("${theUser!.id} authenticated successfully");
          notifyListeners();
          saveToSharedPrefrence(signUpPasswordController.text);

          // notifyListeners();
          if (response3.statusCode == 200) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        // error = responseData['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw 'Could not authenticate you, please try again later';
    }
  }

  Future<bool> getRecords() async {
    try {
      final response = await request.getRequest(
          "patients/${theUser!.id}/medical-records",
          theUser!.username,
          _password);
      final responseData = json.decode(response.body);
      // print(response.body);
      myRecords = recordFromJson(response.body);
      notifyListeners();

      // notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        // error = responseData['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw e;
    }
  }

  Future<bool> getSlots(doctorId) async {
    try {
      final response = await request.getRequest(
          "doctors/$doctorId/appointment-slots", theUser!.username, _password);
      final responseData = json.decode(response.body);
      // print(response.body);
      avilableSlots = avilableSlotsFromJson(response.body);
      notifyListeners();

      // notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        // error = responseData['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw e;
    }
  }

  Future<bool> getDoctorPatientRecords(patientId) async {
    try {
      final response = await request.getRequest(
          "doctors/${theUser!.id}/patients/$patientId/medical-records",
          theUser!.username,
          _password);
      final responseData = json.decode(response.body);
      // print(response.body);
      DrPatientRecords = doctorPatientRecordFromJson(response.body);
      notifyListeners();

      // notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        // error = responseData['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw e;
    }
  }

  Future<bool> getBilling() async {
    try {
      final response = await request.getRequest(
          "patients/${theUser!.id}/billing", theUser!.username, _password);
      final responseData = json.decode(response.body);
      // print(response.body);
      myBillings = billingFromJson(response.body);
      notifyListeners();

      // notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        // error = responseData['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw e;
    }
  }

  Future<bool> getDoctors() async {
    try {
      print(theUser!.username);
      print(_password);
      final response =
          await request.getRequest("doctors", theUser!.username, _password);
      final responseData = json.decode(response.body);
      // print(response.body);
      avilableDoctors = doctorFromJson(response.body);
      notifyListeners();

      // notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        // error = responseData['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw e;
    }
  }

  Future<bool> getAppoinments() async {
    try {
      final response = await request.getRequest(
          "patients/${theUser!.id}/appointments", theUser!.username, _password);
      final responseData = json.decode(response.body);
      // print(response.body);
      appoinments = appointmentFromJson(response.body);
      notifyListeners();

      // notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        // error = responseData['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw e;
    }
  }

  Future<bool> getDoctorAppoinments() async {
    try {
      final response = await request.getRequest(
          "doctors/${theUser!.id}/appointments", theUser!.username, _password);
      final responseData = json.decode(response.body);
      print(response.body);
      doctorAppointments = doctorAppointmentFromJson(response.body);
      notifyListeners();

      // notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        // error = responseData['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw e;
    }
  }

  Future<bool> getDoctorPatients() async {
    try {
      final response = await request.getRequest(
          "doctors/${theUser!.id}/patients", theUser!.username, _password);
      final responseData = json.decode(response.body);
      // print(response.body);
      doctorPatients = doctorPatientFromJson(response.body);
      notifyListeners();

      // notifyListeners();
      if (response.statusCode == 200) {
        return true;
      } else {
        // error = responseData['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw e;
    }
  }

  // Future<bool> DeleteAccount() async {
  //   try {
  //     final response =
  //         await request.getRequest('user/delete/myAccount', theUser!.token);

  //     final responseData = json.decode(response.body);
  //     print(responseData);

  //     if (response.statusCode == 200) {
  //       print("deleted");
  //       logout();
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<bool> forgetPassword(
      String phone, String password, String confitrmPassword) async {
    // final deviceToken = await _firebaseMessaging.getToken();
    try {
      final response = await request.postRequest(data: {
        "phone_number": phone,
        "password": password,
        "password_confirm": confitrmPassword
      }, route: 'user/forget/password');
      final responseData = json.decode(response.body);

      print(responseData);
      if (response.statusCode == 200) {
        return true;
      } else {
        error = responseData['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("e is $e");
      throw 'Could not authenticate you, please try again later';
    }
  }

  Future<void> logout() async {
    theUser = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    notifyListeners();

//     prefs.clear();
  }

  void clearSearchUsers() {
    FamilyUserMembers = [];
    notifyListeners();
  }
}
