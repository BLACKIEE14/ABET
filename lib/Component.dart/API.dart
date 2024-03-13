import 'dart:io';
import 'dart:convert';

import 'package:abet/Pages/Showtoast.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class API {
  static final baseURL = "https://backend.kam2d.com";

  static Future<Map> postUserRegister(
    name,
    phone,
    password,
  ) async {
    Map<String, dynamic> data = {
      "name": name,
      "phone": phone,
      "password": password,
      "password_confirmation": password,
    };
    http.Response response = await http.post(Uri.parse('$baseURL/api/register'),
        body: data, headers: {"Accept": "application/json"});
    print(response.body);

    Map jsonData = jsonDecode(response.body);
    // if (response.statusCode == 200) {

    // }
    return jsonData;
  }

  static Future<Map> postPayment(
    payment_method,
    transaction_id,
    amount,
  ) async {
    Map<String, dynamic> data = {
      "payment_method": payment_method.toString(),
      "transaction_id": transaction_id,
      "amount": amount.toString().replaceAll(",", ""),
    };
    http.Response response = await http
        .post(Uri.parse('$baseURL/api/deposit/submit'), body: data, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer ${Hive.box('Login').get('token')}"
    });
    print(response.body);
    Map jsonData = jsonDecode(response.body);

    return jsonData;
  }

  static Future<Map> postWithdraw(
    withdraw_payment,
    withdraw_account_name,
    withdraw_account_number,
    withdraw_account_number_confirmation,
    amount,
    pin,
  ) async {
    Map<String, dynamic> data = {
      "withdraw_payment": withdraw_payment.toString(),
      "withdraw_account_name": withdraw_account_name,
      "withdraw_account_number": withdraw_account_number.toString(),
      "withdraw_account_number_confirmation":
          withdraw_account_number_confirmation.toString(),
      "amount": amount.toString().replaceAll(",", ""),
      "pin": pin.toString(),
    };
    http.Response response = await http
        .post(Uri.parse('$baseURL/api/withdraw/submit'), body: data, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer ${Hive.box('Login').get('token')}"
    });
    print(data);
    print(response.body);
    Map jsonData = jsonDecode(response.body);
    Map errors = jsonData['errors'] == null ? {} : jsonData['errors'];
    errors.forEach((key, value) {
      showToast(value[0]);
    });

    return jsonData;
  }

  static Future<Map> postUserLogin(phone, password) async {
    var response = await http.post(Uri.parse('$baseURL/api/login'), body: {
      "phone": phone,
      "password": password,
    });
    print(response.body);
    Map jsonData = jsonDecode(response.body);
    return jsonData["data"];
  }

  static Future<Map> getUserDetails() async {
    var response = await http.get(Uri.parse('$baseURL/api/customer/info'),
        headers: {"Authorization": "Bearer ${Hive.box('Login').get('token')}"});

    print(response.body);
    Map jsonData = jsonDecode(response.body);

    Hive.box("Login").put("name", jsonData['data']['name']);
    Hive.box("Login").put("image", jsonData['data']['image']);
    Hive.box("Login").put("phone", jsonData['data']['phone']);

    Hive.box("Login").put("balance", jsonData['data']['balance']);
    return jsonData;
  }

  static Future<Map> getHtwakNumb2d() async {
    var response = await http.get(Uri.parse('$baseURL/api/result/list'),
        headers: {"Authorization": "Bearer ${Hive.box('Login').get('token')}"});
    Map jsonData = jsonDecode(response.body);
    return jsonData['twod_result_list'];
  }

  static Future<List> getHtwakNumb3d() async {
    var response = await http.get(Uri.parse('$baseURL/api/result/list'),
        headers: {"Authorization": "Bearer ${Hive.box('Login').get('token')}"});
    Map jsonData = jsonDecode(response.body);
    return jsonData['threed_result_list'];
  }

  static Future<List> getSlide() async {
    var response = await http.get(Uri.parse('$baseURL/api/slide/home'),
        headers: {"Authorization": "Bearer ${Hive.box('Login').get('token')}"});
    Map jsonData = jsonDecode(response.body);
    return jsonData['data'];
  }

  static Future<List> getPaymentMethod() async {
    var response = await http.get(Uri.parse('$baseURL/api/payment-method'),
        headers: {"Authorization": "Bearer ${Hive.box('Login').get('token')}"});
    Map jsonData = jsonDecode(response.body);
    return jsonData['data'];
  }

  static Future<Map> postUserDetails(name, {File? image}) async {
    var request = new http.MultipartRequest(
      "POST",
      Uri.parse('$baseURL/api/profile/update'),
    );
    request.headers["Authorization"] =
        "Bearer " + Hive.box("Login").get("token");
    request.fields['name'] = name;
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        "image",
        image.path,
      ));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    Box tempBox = Hive.box("Login");
    tempBox.put("name", name);

    print((response.body));
    print(jsonDecode(response.body));
    // tempBox.put("photo", jsonDecode(response.body)['user']['photo']);
    print(response.body);
    Map jsonData = jsonDecode(response.body);
    return jsonData;
  }

  static Future<Map> getUserTransction() async {
    var response = await http.get(Uri.parse('$baseURL/api/transaction'),
        headers: {"Authorization": "Bearer ${Hive.box('Login').get('token')}"});
    print(response.body);

    Map jsonData = jsonDecode(response.body);

    return jsonData['data'];
  }

  static Future<Map> getUserTransctiondetails(String id) async {
    var response = await http.get(Uri.parse('$baseURL/api/transaction/' + id),
        headers: {"Authorization": "Bearer ${Hive.box('Login').get('token')}"});
    print(response.body);

    Map jsonData = jsonDecode(response.body);

    return jsonData['data'];
  }

  static Future<Map> getUserNoti() async {
    var response = await http.get(Uri.parse('$baseURL/api/notification'),
        headers: {"Authorization": "Bearer ${Hive.box('Login').get('token')}"});
    print(response.body);

    Map jsonData = jsonDecode(response.body);

    return jsonData['data'];
  }
}
