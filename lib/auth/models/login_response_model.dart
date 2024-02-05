// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  StoreInfo? result;

  LoginResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
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

class StoreInfo {
  AddressArray? addressArray;
  String? id;
  String? createdAt;
  bool? isHeadquarters;
  String? storeUid;
  String? storeUuid;
  String? storeName;
  String? displayName;
  String? gstNo;
  String? referralcode;
  int? mobile;
  String? emailId;
  String? password;
  List<StoreImgArray>? storeImgArray;
  String? storeFcmToken;
  String? storeAuthToken;
  String? storeCategoryId;
  String? storeCategoryName;
  String? zone;
  String? deliveryType;
  double? deliveryFee;
  String? hubUuid;
  double? storeCommissionPercent;
  bool? isApproved;
  bool? isDeleted;
  bool? isHomeDelivery;
  dynamic operatorUuid;
  List<dynamic>? documentImgArray;
  List<dynamic>? orderDeliveryDetails;
  int? v;

  StoreInfo({
    this.addressArray,
    this.id,
    this.createdAt,
    this.isHeadquarters,
    this.storeUid,
    this.storeUuid,
    this.storeName,
    this.displayName,
    this.gstNo,
    this.referralcode,
    this.mobile,
    this.emailId,
    this.password,
    this.storeImgArray,
    this.storeFcmToken,
    this.storeAuthToken,
    this.storeCategoryId,
    this.storeCategoryName,
    this.zone,
    this.deliveryType,
    this.deliveryFee,
    this.hubUuid,
    this.storeCommissionPercent,
    this.isApproved,
    this.isDeleted,
    this.isHomeDelivery,
    this.operatorUuid,
    this.documentImgArray,
    this.orderDeliveryDetails,
    this.v,
  });

  factory StoreInfo.fromJson(Map<String, dynamic> json) => StoreInfo(
    addressArray: json["addressArray"] == null ? null : AddressArray.fromJson(json["addressArray"]),
    id: json["_id"],
    createdAt: json["createdAt"],
    isHeadquarters: json["isHeadquarters"],
    storeUid: json["storeUID"],
    storeUuid: json["storeUuid"],
    storeName: json["storeName"],
    displayName: json["displayName"],
    gstNo: json["gstNo"],
    referralcode: json["referralcode"],
    mobile: json["mobile"],
    emailId: json["emailId"],
    password: json["password"],
    storeImgArray: json["storeImgArray"] == null ? [] : List<StoreImgArray>.from(json["storeImgArray"]!.map((x) => StoreImgArray.fromJson(x))),
    storeFcmToken: json["storeFcmToken"],
    storeAuthToken: json["storeAuthToken"],
    storeCategoryId: json["storeCategoryId"],
    storeCategoryName: json["storeCategoryName"],
    zone: json["zone"],
    deliveryType: json["deliveryType"],
    deliveryFee: json["deliveryFee"].toDouble(),
    hubUuid: json["hubUuid"],
    storeCommissionPercent: json["storeCommissionPercent"].toDouble(),
    isApproved: json["isApproved"],
    isDeleted: json["isDeleted"],
    isHomeDelivery: json["isHomeDelivery"],
    operatorUuid: json["operatorUuid"],
    documentImgArray: json["documentImgArray"] == null ? [] : List<dynamic>.from(json["documentImgArray"]!.map((x) => x)),
    orderDeliveryDetails: json["orderDeliveryDetails"] == null ? [] : List<dynamic>.from(json["orderDeliveryDetails"]!.map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "addressArray": addressArray?.toJson(),
    "_id": id,
    "createdAt": createdAt,
    "isHeadquarters": isHeadquarters,
    "storeUID": storeUid,
    "storeUuid": storeUuid,
    "storeName": storeName,
    "displayName": displayName,
    "gstNo": gstNo,
    "referralcode": referralcode,
    "mobile": mobile,
    "emailId": emailId,
    "password": password,
    "storeImgArray": storeImgArray == null ? [] : List<dynamic>.from(storeImgArray!.map((x) => x.toJson())),
    "storeFcmToken": storeFcmToken,
    "storeAuthToken": storeAuthToken,
    "storeCategoryId": storeCategoryId,
    "storeCategoryName": storeCategoryName,
    "zone": zone,
    "deliveryType": deliveryType,
    "deliveryFee": deliveryFee,
    "hubUuid": hubUuid,
    "storeCommissionPercent": storeCommissionPercent,
    "isApproved": isApproved,
    "isDeleted": isDeleted,
    "isHomeDelivery": isHomeDelivery,
    "operatorUuid": operatorUuid,
    "documentImgArray": documentImgArray == null ? [] : List<dynamic>.from(documentImgArray!.map((x) => x)),
    "orderDeliveryDetails": orderDeliveryDetails == null ? [] : List<dynamic>.from(orderDeliveryDetails!.map((x) => x)),
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

  AddressArray({
    this.addressType,
    this.completeAddress,
    this.city,
    this.state,
    this.lat,
    this.lng,
    this.zipCode,
    this.isDeleted,
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
  };
}

class StoreImgArray {
  String? imageType;
  String? imageDocName;
  String? imageUrl;
  bool? isDeleted;
  String? id;

  StoreImgArray({
    this.imageType,
    this.imageDocName,
    this.imageUrl,
    this.isDeleted,
    this.id,
  });

  factory StoreImgArray.fromJson(Map<String, dynamic> json) => StoreImgArray(
    imageType: json["imageType"],
    imageDocName: json["imageDocName"],
    imageUrl: json["imageURL"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "imageType": imageType,
    "imageDocName": imageDocName,
    "imageURL": imageUrl,
    "isDeleted": isDeleted,
    "_id": id,
  };
}
