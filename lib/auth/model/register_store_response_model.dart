// To parse this JSON data, do
//
//     final registerStoreResponseModel = registerStoreResponseModelFromJson(jsonString);

import 'dart:convert';

List<RegisterStoreResponseModel> registerStoreResponseModelFromJson(String str) => List<RegisterStoreResponseModel>.from(json.decode(str).map((x) => RegisterStoreResponseModel.fromJson(x)));

String registerStoreResponseModelToJson(List<RegisterStoreResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegisterStoreResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  RegisterStore? result;

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
    result: json["result"] == null ? null : RegisterStore.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class RegisterStore {
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
  List<ImgArray>? documentImgArray;
  List<AddressArray>? addressArray;
  List<ImgArray>? storeImgArray;
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
  String? id;
  int? v;

  RegisterStore({
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
    this.documentImgArray,
    this.addressArray,
    this.storeImgArray,
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
    this.id,
    this.v,
  });

  factory RegisterStore.fromJson(Map<String, dynamic> json) => RegisterStore(
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
    documentImgArray: json["documentImgArray"] == null ? [] : List<ImgArray>.from(json["documentImgArray"]!.map((x) => ImgArray.fromJson(x))),
    addressArray: json["addressArray"] == null ? [] : List<AddressArray>.from(json["addressArray"]!.map((x) => AddressArray.fromJson(x))),
    storeImgArray: json["storeImgArray"] == null ? [] : List<ImgArray>.from(json["storeImgArray"]!.map((x) => ImgArray.fromJson(x))),
    storeFcmToken: json["storeFcmToken"],
    storeAuthToken: json["storeAuthToken"],
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
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
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
    "documentImgArray": documentImgArray == null ? [] : List<dynamic>.from(documentImgArray!.map((x) => x.toJson())),
    "addressArray": addressArray == null ? [] : List<dynamic>.from(addressArray!.map((x) => x.toJson())),
    "storeImgArray": storeImgArray == null ? [] : List<dynamic>.from(storeImgArray!.map((x) => x.toJson())),
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
    "_id": id,
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
