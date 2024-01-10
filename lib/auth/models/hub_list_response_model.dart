// To parse this JSON data, do
//
//     final hubListResponseModel = hubListResponseModelFromJson(jsonString);

import 'dart:convert';

HubListResponseModel hubListResponseModelFromJson(String str) => HubListResponseModel.fromJson(json.decode(str));

String hubListResponseModelToJson(HubListResponseModel data) => json.encode(data.toJson());

class HubListResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Result>? result;

  HubListResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory HubListResponseModel.fromJson(Map<String, dynamic> json) => HubListResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  String? id;
  String? hubUid;
  String? hubUuid;
  String? hubName;
  String? emailId;
  int? mobile;
  String? password;
  List<AddressArray>? addressArray;
  String? hubInchargeName;
  int? hubInchargeMobile;
  String? managedBy;
  int? managerMobile;
  String? zone;
  String? hubFcmToken;
  String? hubAuthToken;
  List<ProfileImageArray>? profileImageArray;
  bool? isDeleted;
  List<dynamic>? orderDeliveryDetails;
  int? v;
  String? updatedAt;

  Result({
    this.id,
    this.hubUid,
    this.hubUuid,
    this.hubName,
    this.emailId,
    this.mobile,
    this.password,
    this.addressArray,
    this.hubInchargeName,
    this.hubInchargeMobile,
    this.managedBy,
    this.managerMobile,
    this.zone,
    this.hubFcmToken,
    this.hubAuthToken,
    this.profileImageArray,
    this.isDeleted,
    this.orderDeliveryDetails,
    this.v,
    this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    hubUid: json["hubUID"],
    hubUuid: json["hubUuid"],
    hubName: json["hubName"],
    emailId: json["emailId"],
    mobile: json["mobile"],
    password: json["password"],
    addressArray: json["addressArray"] == null ? [] : List<AddressArray>.from(json["addressArray"]!.map((x) => AddressArray.fromJson(x))),
    hubInchargeName: json["hubInchargeName"],
    hubInchargeMobile: json["hubInchargeMobile"],
    managedBy: json["managedBy"],
    managerMobile: json["managerMobile"],
    zone: json["zone"],
    hubFcmToken: json["hubFcmToken"],
    hubAuthToken: json["hubAuthToken"],
    profileImageArray: json["profileImageArray"] == null ? [] : List<ProfileImageArray>.from(json["profileImageArray"]!.map((x) => ProfileImageArray.fromJson(x))),
    isDeleted: json["isDeleted"],
    orderDeliveryDetails: json["orderDeliveryDetails"] == null ? [] : List<dynamic>.from(json["orderDeliveryDetails"]!.map((x) => x)),
    v: json["__v"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "hubUID": hubUid,
    "hubUuid": hubUuid,
    "hubName": hubName,
    "emailId": emailId,
    "mobile": mobile,
    "password": password,
    "addressArray": addressArray == null ? [] : List<dynamic>.from(addressArray!.map((x) => x.toJson())),
    "hubInchargeName": hubInchargeName,
    "hubInchargeMobile": hubInchargeMobile,
    "managedBy": managedBy,
    "managerMobile": managerMobile,
    "zone": zone,
    "hubFcmToken": hubFcmToken,
    "hubAuthToken": hubAuthToken,
    "profileImageArray": profileImageArray == null ? [] : List<dynamic>.from(profileImageArray!.map((x) => x.toJson())),
    "isDeleted": isDeleted,
    "orderDeliveryDetails": orderDeliveryDetails == null ? [] : List<dynamic>.from(orderDeliveryDetails!.map((x) => x)),
    "__v": v,
    "updatedAt": updatedAt,
  };
}

class AddressArray {
  String? address;
  String? city;
  String? state;
  int? zipCode;
  double? lat;
  double? lng;
  bool? isDeleted;
  String? id;

  AddressArray({
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.lat,
    this.lng,
    this.isDeleted,
    this.id,
  });

  factory AddressArray.fromJson(Map<String, dynamic> json) => AddressArray(
    address: json["address"],
    city: json["city"],
    state: json["state"],
    zipCode: json["zipCode"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    isDeleted: json["isDeleted"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "city": city,
    "state": state,
    "zipCode": zipCode,
    "lat": lat,
    "lng": lng,
    "isDeleted": isDeleted,
    "_id": id,
  };
}

class ProfileImageArray {
  String? imagePath;
  String? imageType;
  String? imageDescription;
  String? id;

  ProfileImageArray({
    this.imagePath,
    this.imageType,
    this.imageDescription,
    this.id,
  });

  factory ProfileImageArray.fromJson(Map<String, dynamic> json) => ProfileImageArray(
    imagePath: json["imagePath"],
    imageType: json["imageType"],
    imageDescription: json["imageDescription"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "imagePath": imagePath,
    "imageType": imageType,
    "imageDescription": imageDescription,
    "_id": id,
  };
}
