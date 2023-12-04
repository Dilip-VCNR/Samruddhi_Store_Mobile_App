// To parse this JSON data, do
//
//     final registerStoreRequestModel = registerStoreRequestModelFromJson(jsonString);

import 'dart:convert';

RegisterStoreRequestModel registerStoreRequestModelFromJson(String str) => RegisterStoreRequestModel.fromJson(json.decode(str));

String registerStoreRequestModelToJson(RegisterStoreRequestModel data) => json.encode(data.toJson());

class RegisterStoreRequestModel {
  bool? isHeadquarters;
  String? storeUuid;
  String? storeName;
  String? displayName;
  String? gstNo;
  int? mobile;
  String? emailId;
  String? password;
  String? addressType;
  String? completeAddress;
  String? city;
  String? state;
  double? lat;
  double? lng;
  int? zipCode;
  String? image;
  String? document;

  RegisterStoreRequestModel({
    this.isHeadquarters,
    this.storeUuid,
    this.storeName,
    this.displayName,
    this.gstNo,
    this.mobile,
    this.emailId,
    this.password,
    this.addressType,
    this.completeAddress,
    this.city,
    this.state,
    this.lat,
    this.lng,
    this.zipCode,
    this.image,
    this.document,
  });

  factory RegisterStoreRequestModel.fromJson(Map<String, dynamic> json) => RegisterStoreRequestModel(
    isHeadquarters: json["isHeadquarters"],
    storeUuid: json["storeUuid"],
    storeName: json["storeName"],
    displayName: json["displayName"],
    gstNo: json["gstNo"],
    mobile: json["mobile"],
    emailId: json["emailId"],
    password: json["password"],
    addressType: json["addressType"],
    completeAddress: json["completeAddress"],
    city: json["city"],
    state: json["state"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    zipCode: json["zipCode"],
    image: json["image"],
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "isHeadquarters": isHeadquarters,
    "storeUuid": storeUuid,
    "storeName": storeName,
    "displayName": displayName,
    "gstNo": gstNo,
    "mobile": mobile,
    "emailId": emailId,
    "password": password,
    "addressType": addressType,
    "completeAddress": completeAddress,
    "city": city,
    "state": state,
    "lat": lat,
    "lng": lng,
    "zipCode": zipCode,
    "image": image,
    "document": document,
  };
}
