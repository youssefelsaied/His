import 'dart:convert';
import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class Request {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String usedUrl = '127.0.0.1:8080';
  // String usedUrl = 'maak.brunchenapp.com';
  String paymentUsedUrl = 'accept.paymob.com';

  var code = 'ar';

  Future postRequest(
      {int? page,
      data,
      required String route,
      String? token = '',
      String? username = '',
      String? password = ''}) async {
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));

    var url = Uri.http(
      usedUrl,
      "/api/" + route,
    );

    print(url);
    try {
      http.Response response = await http.post(url,
          headers: username == ''
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  // 'Accept-Language': code,
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  // 'Accept-Language': code,
                  'Authorization': basicAuth,
                },
          body: json.encode(data));
      print(response);
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future paymentPostRequest({data, required String route}) async {
    print('paymentPostRequest');

    log(data);
    print('code');
    print(code);

    var url = Uri.https(paymentUsedUrl, "/api/" + route, {'q': '{https}'});
    print(url);
    try {
      http.Response response = await http.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(data));

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future anyPaymentRequest({
    paymentUrl,
    data,
  }) async {
    var url = Uri.parse(paymentUrl);

    try {
      http.Response response = await http.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br'
          },
          body: json.encode(data));
      print(data);

      print(response.statusCode);
      print(response.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future putRequest({data, required String route, String token = ''}) async {
    // final deviceToken = await _firebaseMessaging.getToken();
    // print(data);
    var url = Uri.https(usedUrl, "/api/" + route, {'q': '{https}'});
    try {
      final response = await http.put(url,
          headers: token == ''
              ? {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Accept-Language': code,
                }
              : {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Accept-Language': code,
                  'Authorization': 'Bearer $token',
                },
          body: json.encode(data));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future getRequest(
    String route,
    String username,
    String password,
  ) async {
    var url = Uri.http(usedUrl, "/api/" + route);
    print('code');

    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$username:$password'));
    print(code);
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': basicAuth,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteRequest(String route, String username, String password,
      [String? token = '']) async {
    var url = Uri.https(usedUrl, "/api/" + route, {});

    try {
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$username:$password'));
      final response = await http.delete(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': basicAuth,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
