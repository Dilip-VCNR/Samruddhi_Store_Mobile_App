// To parse this JSON data, do
//
// final checkStoreResponseModel = checkStoreResponseModelFromJson(jsonString);

import 'dart:convert';

CheckStoreResponseModel checkStoreResponseModelFromJson(String str) => CheckStoreResponseModel.fromJson(json.decode(str));

String checkStoreResponseModelToJson(CheckStoreResponseModel data) => json.encode(data.toJson());

class CheckStoreResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  StoreInfo? result;
  String? storeAuthToken;

  CheckStoreResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
    this.storeAuthToken
  });

  factory CheckStoreResponseModel.fromJson(Map<String, dynamic> json) => CheckStoreResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? null : StoreInfo.fromJson(json["result"]),
    storeAuthToken : json["storeAuthToken"] ?? "storedetails",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class StoreInfo {
  String? id;
  String? createdAt;
  bool? isHeadquarters;
  String? storeHeadquartersUuid;
  String? storeUid;
  String? storeUuid;
  String? storeName;
  String? displayName;
  String? gstNo;
  int? mobile;
  String? emailId;
  String? password;
  List<AddressArray>? addressArray;
  dynamic storeFcmToken;
  String? storeAuthToken;
  dynamic zone;
  dynamic deliveryType;
  int? deliveryFee;
  dynamic hubUuid;
  int? storeOffer;
  bool? isApproved;
  bool? isDeleted;
  bool? isHomeDelivery;
  dynamic productName;
  dynamic operatorUuid;
  List<dynamic>? documentImgArray;
  List<dynamic>? storeImgArray;
  int? v;

  StoreInfo({
    this.id,
    this.createdAt,
    this.isHeadquarters,
    this.storeHeadquartersUuid,
    this.storeUid,
    this.storeUuid,
    this.storeName,
    this.displayName,
    this.gstNo,
    this.mobile,
    this.emailId,
    this.password,
    this.addressArray,
    this.storeFcmToken,
    this.storeAuthToken,
    this.zone,
    this.deliveryType,
    this.deliveryFee,
    this.hubUuid,
    this.storeOffer,
    this.isApproved,
    this.isDeleted,
    this.isHomeDelivery,
    this.productName,
    this.operatorUuid,
    this.documentImgArray,
    this.storeImgArray,
    this.v,
  });

  factory StoreInfo.fromJson(Map<String, dynamic> json) => StoreInfo (
    id: json["_id"],
    createdAt: json["createdAt"],
    isHeadquarters: json["isHeadquarters"],
    storeHeadquartersUuid: json["storeHeadquartersUuid"],
    storeUid: json["storeUID"],
    storeUuid: json["storeUuid"],
    storeName: json["storeName"],
    displayName: json["displayName"],
    gstNo: json["gstNo"],
    mobile: json["mobile"],
    emailId: json["emailId"],
    password: json["password"],
    addressArray: json["addressArray"] == null ? [] : List<AddressArray>.from(json["addressArray"]!.map((x) => AddressArray.fromJson(x))),
    storeFcmToken: json["storeFcmToken"],
    storeAuthToken: json["storeAuthToken"] ?? "abc",
    zone: json["zone"],
    deliveryType: json["deliveryType"],
    deliveryFee: json["deliveryFee"],
    hubUuid: json["hubUuid"],
    storeOffer: json["storeOffer"],
    isApproved: json["isApproved"],
    isDeleted: json["isDeleted"],
    isHomeDelivery: json["isHomeDelivery"],
    productName: json["productName"],
    operatorUuid: json["operatorUuid"],
    documentImgArray: json["documentImgArray"] == null ? [] : List<dynamic>.from(json["documentImgArray"]!.map((x) => x)),
    storeImgArray: json["storeImgArray"] == null ? [] : List<dynamic>.from(json["storeImgArray"]!.map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt,
    "isHeadquarters": isHeadquarters,
    "storeHeadquartersUuid": storeHeadquartersUuid,
    "storeUID": storeUid,
    "storeUuid": storeUuid,
    "storeName": storeName,
    "displayName": displayName,
    "gstNo": gstNo,
    "mobile": mobile,
    "emailId": emailId,
    "password": password,
    "addressArray": addressArray == null ? [] : List<dynamic>.from(addressArray!.map((x) => x.toJson())),
    "storeFcmToken": storeFcmToken,
    "storeAuthToken": storeAuthToken,
    "zone": zone,
    "deliveryType": deliveryType,
    "deliveryFee": deliveryFee,
    "hubUuid": hubUuid,
    "storeOffer": storeOffer,
    "isApproved": isApproved,
    "isDeleted": isDeleted,
    "isHomeDelivery": isHomeDelivery,
    "productName": productName,
    "operatorUuid": operatorUuid,
    "documentImgArray": documentImgArray == null ? [] : List<dynamic>.from(documentImgArray!.map((x) => x)),
    "storeImgArray": storeImgArray == null ? [] : List<dynamic>.from(storeImgArray!.map((x) => x)),
    "__v": v,
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
