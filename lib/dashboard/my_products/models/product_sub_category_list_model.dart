// To parse this JSON data, do
//
//     final productSubCategoryListModel = productSubCategoryListModelFromJson(jsonString);

import 'dart:convert';

ProductSubCategoryListModel productSubCategoryListModelFromJson(String str) => ProductSubCategoryListModel.fromJson(json.decode(str));

String productSubCategoryListModelToJson(ProductSubCategoryListModel data) => json.encode(data.toJson());

class ProductSubCategoryListModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Result>? result;

  ProductSubCategoryListModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory ProductSubCategoryListModel.fromJson(Map<String, dynamic> json) => ProductSubCategoryListModel(
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
  String? productSubCategoryId;
  String? productSubCategoryName;
  List<ProductSubCategoryImgArray>? productSubCategoryImgArray;
  bool? isDeleted;
  int? v;
  String? updatedAt;

  Result({
    this.id,
    this.createdAt,
    this.productSubCategoryId,
    this.productSubCategoryName,
    this.productSubCategoryImgArray,
    this.isDeleted,
    this.v,
    this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    createdAt: json["createdAt"],
    productSubCategoryId: json["productSubCategoryId"],
    productSubCategoryName: json["productSubCategoryName"],
    productSubCategoryImgArray: json["productSubCategoryImgArray"] == null ? [] : List<ProductSubCategoryImgArray>.from(json["productSubCategoryImgArray"]!.map((x) => ProductSubCategoryImgArray.fromJson(x))),
    isDeleted: json["isDeleted"],
    v: json["__v"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt,
    "productSubCategoryId": productSubCategoryId,
    "productSubCategoryName": productSubCategoryName,
    "productSubCategoryImgArray": productSubCategoryImgArray == null ? [] : List<dynamic>.from(productSubCategoryImgArray!.map((x) => x.toJson())),
    "isDeleted": isDeleted,
    "__v": v,
    "updatedAt": updatedAt,
  };
}

class ProductSubCategoryImgArray {
  String? imagePath;
  String? imageType;
  String? imageDescription;
  String? id;

  ProductSubCategoryImgArray({
    this.imagePath,
    this.imageType,
    this.imageDescription,
    this.id,
  });

  factory ProductSubCategoryImgArray.fromJson(Map<String, dynamic> json) => ProductSubCategoryImgArray(
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
