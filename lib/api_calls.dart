import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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
      "customerUuid":user!.uid,
      "customerFcmToken":fcmToken
    }));
    print(response.statusCode);
    print(response.body);
    return CheckStoreResponseModel.fromJson(json.decode(response.body));
  }

  Future<RegisterStoreResponseModel>registerNewStore(BuildContext context, Map<String, dynamic> reqData) async {
    var request = http.MultipartRequest('POST', Uri.parse(UrlConstant.registerStore));
    reqData.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    print(request.fields);
    var response = await http.Response.fromStream(await request.send());
    print(response.statusCode);
    print(response.body);
    return RegisterStoreResponseModel.fromJson(json.decode(response.body));
  }


}