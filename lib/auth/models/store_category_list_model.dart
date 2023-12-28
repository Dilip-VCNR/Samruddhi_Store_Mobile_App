// To parse this JSON data, do
//
//     final storeCategoryListModel = storeCategoryListModelFromJson(jsonString);

import 'dart:convert';

StoreCategoryListModel storeCategoryListModelFromJson(String str) => StoreCategoryListModel.fromJson(json.decode(str));

String storeCategoryListModelToJson(StoreCategoryListModel data) => json.encode(data.toJson());

class StoreCategoryListModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Result>? result;

  StoreCategoryListModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory StoreCategoryListModel.fromJson(Map<String, dynamic> json) => StoreCategoryListModel(
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
  String? createdAt;
  String? storeCategoryId;
  String? storeCategoryName;
  String? description;
  bool? isDeleted;
  List<StoreCategoryImgArray>? storeCategoryImgArray;
  int? v;
  String? updatedAt;

  Result({
    this.id,
    this.createdAt,
    this.storeCategoryId,
    this.storeCategoryName,
    this.description,
    this.isDeleted,
    this.storeCategoryImgArray,
    this.v,
    this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    createdAt: json["createdAt"],
    storeCategoryId: json["storeCategoryId"],
    storeCategoryName: json["storeCategoryName"],
    description: json["description"],
    isDeleted: json["isDeleted"],
    storeCategoryImgArray: json["storeCategoryImgArray"] == null ? [] : List<StoreCategoryImgArray>.from(json["storeCategoryImgArray"]!.map((x) => StoreCategoryImgArray.fromJson(x))),
    v: json["__v"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt,
    "storeCategoryId": storeCategoryId,
    "storeCategoryName": storeCategoryName,
    "description": description,
    "isDeleted": isDeleted,
    "storeCategoryImgArray": storeCategoryImgArray == null ? [] : List<dynamic>.from(storeCategoryImgArray!.map((x) => x.toJson())),
    "__v": v,
    "updatedAt": updatedAt,
  };
}

class StoreCategoryImgArray {
  String? imagePath;
  String? imageType;
  String? id;

  StoreCategoryImgArray({
    this.imagePath,
    this.imageType,
    this.id,
  });

  factory StoreCategoryImgArray.fromJson(Map<String, dynamic> json) => StoreCategoryImgArray(
    imagePath: json["imagePath"],
    imageType: json["imageType"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "imagePath": imagePath,
    "imageType": imageType,
    "_id": id,
  };
}
