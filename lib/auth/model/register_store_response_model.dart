// To parse this JSON data, do
//
//     final registerStoreResponseModel = registerStoreResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:samruddhi_store/auth/model/check_store_response_model.dart';

List<RegisterStoreResponseModel> registerStoreResponseModelFromJson(String str) => List<RegisterStoreResponseModel>.from(json.decode(str).map((x) => RegisterStoreResponseModel.fromJson(x)));

String registerStoreResponseModelToJson(List<RegisterStoreResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegisterStoreResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  StoreInfo? result;

  RegisterStoreResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory RegisterStoreResponseModel.fromJson(Map<String, dynamic> json) => RegisterStoreResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? null : StoreInfo.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class AddressArray {
  String? addressType;
  String? completeAddress;
  String? city;
  String? state;
  double? lat;
  double? lng;
  int? zipCode;
  bool? isDeleted;
  String? id;

  AddressArray({
    this.addressType,
    this.completeAddress,
    this.city,
    this.state,
    this.lat,
    this.lng,
    this.zipCode,
    this.isDeleted,
    this.id,
  });

  factory AddressArray.fromJson(Map<String, dynamic> json) => AddressArray(
    addressType: json["addressType"],
    completeAddress: json["completeAddress"],
    city: json["city"],
    state: json["state"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    zipCode: json["zipCode"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "addressType": addressType,
    "completeAddress": completeAddress,
    "city": city,
    "state": state,
    "lat": lat,
    "lng": lng,
    "zipCode": zipCode,
    "isDeleted": isDeleted,
    "_id": id,
  };
}

class ImgArray {
  String? imageType;
  String? imageDocName;
  String? imageUrl;
  String? id;
  bool? isDeleted;

  ImgArray({
    this.imageType,
    this.imageDocName,
    this.imageUrl,
    this.id,
    this.isDeleted,
  });

  factory ImgArray.fromJson(Map<String, dynamic> json) => ImgArray(
    imageType: json["imageType"],
    imageDocName: json["imageDocName"],
    imageUrl: json["imageURL"],
    id: json["_id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "imageType": imageType,
    "imageDocName": imageDocName,
    "imageURL": imageUrl,
    "_id": id,
    "isDeleted": isDeleted,
  };
}
