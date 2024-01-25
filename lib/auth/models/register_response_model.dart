// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:samruddhi_store/auth/models/login_response_model.dart';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  List<StoreInfo>? result;

  RegisterResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null
        ? null
        : (json["result"] is Map
        ? [StoreInfo.fromJson(json["result"])]
        : List<StoreInfo>.from((json["result"] as List).map((x) => StoreInfo.fromJson(x)))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result == null ? [] : List<StoreInfo>.from(result!.map((x) => x.toJson())),
  };
}