import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:samruddhi_store/dashboard/my_products/model/create_product_request_model.dart';
import 'package:samruddhi_store/utils/app_widgets.dart';
import 'package:samruddhi_store/utils/url_constants.dart';

import 'auth/model/check_store_response_model.dart';
import 'auth/model/register_store_response_model.dart';
import 'database/app_pref.dart';
import 'database/models/pref_model.dart';

class ApiCalls{

  PrefModel prefModel = AppPref.getPref();

  String platform = Platform.isIOS ? "IOS" : "Android";

  Future<http.Response> hitApiPost(
      bool requiresAuth, String url, String body) async {
    return await http.post(
      Uri.parse(url),
      headers: getHeaders(requiresAuth),
      body: body,
    );
  }

  Future<http.Response> hitApiGet(
      bool requiresAuth, String url) async {
    return await http.get(
      Uri.parse(url),
      headers: getHeaders(requiresAuth),
    );
  }

    Map<String, String> getHeaders(bool isAuthEnabled) {
    var headers = <String, String>{};
    if (isAuthEnabled) {
      headers.addAll({
        "x-access-token": prefModel.userdata!.storeAuthToken!,
        "Content-Type": "application/json"
      });
    } else {
      headers.addAll({"Content-Type": "application/json"});
    }
    return headers;
  }

  Future<CheckStoreResponseModel>checkForStore(User? user, String? fcmToken) async {
    http.Response response = await hitApiPost(false, UrlConstant.checkForUserApi, jsonEncode({
      "storeUuid":user!.uid,
      "customerFcmToken":fcmToken
    }));

    print(response.statusCode);
    print(response.body);
    return CheckStoreResponseModel.fromJson(json.decode(response.body));
  }

  Future<RegisterStoreResponseModel>registerNewStore(BuildContext context, Map<String, dynamic> reqObj) async {
    var request = http.MultipartRequest('POST', Uri.parse(UrlConstant.registerStore));
    reqObj.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    print(request.fields);
    var response = await http.Response.fromStream(await request.send());
    print(response.statusCode);
    print("---------------------------");
    print(response.body);
    return RegisterStoreResponseModel.fromJson(json.decode(response.body));
  }

  addProduct(CreateProductRequestModel reqData, BuildContext context) async {
     var request = http.MultipartRequest('POST', Uri.parse(UrlConstant.addStore));
     Map<String, dynamic> requestDataMap = reqData.toJson();

     requestDataMap.forEach((key, value) {
       print(key);
       print(value);
       // request.fields[key] = value;
     });
     request.headers.addAll({
       "x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InN0b3JlVXVpZCI6ImUyY0FJR21sVVlQT1NpZ0JiRDJ0MTVBSGthSjMifSwiaWF0IjoxNzAxOTM0Njk1LCJleHAiOjE3MzM0NzA2OTV9.cU7VanXjET8olQmZix_BtHWLqiA1io6WcRqk5UtHs1U",
       "Content-Type": "application/json"
     });
      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        showErrorToast(context, "Product Added Successfully !");
        print(response.statusCode);
        print('Product added successfully');
        print('API Response: ${response.body}');
      } if(response.statusCode == 400 ){
       showErrorToast(context, "Invalid value !");
       print('invalid value');
     }else {
        print('Failed to add product. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

  }
}
