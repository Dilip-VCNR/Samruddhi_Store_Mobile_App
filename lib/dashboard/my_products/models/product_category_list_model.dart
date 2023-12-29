// To parse this JSON data, do
//
//     final productCategoryListModel = productCategoryListModelFromJson(jsonString);

import 'dart:convert';

ProductCategoryListModel productCategoryListModelFromJson(String str) => ProductCategoryListModel.fromJson(json.decode(str));

String productCategoryListModelToJson(ProductCategoryListModel data) => json.encode(data.toJson());

class ProductCategoryListModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Result>? result;

  ProductCategoryListModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory ProductCategoryListModel.fromJson(Map<String, dynamic> json) => ProductCategoryListModel(
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
  String? productCategoryId;
  String? productCategoryName;
  List<ProductCategoryImgArray>? productCategoryImgArray;
  bool? isDeleted;
  int? v;

  Result({
    this.id,
    this.productCategoryId,
    this.productCategoryName,
    this.productCategoryImgArray,
    this.isDeleted,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    productCategoryId: json["productCategoryId"],
    productCategoryName: json["productCategoryName"],
    productCategoryImgArray: json["productCategoryImgArray"] == null ? [] : List<ProductCategoryImgArray>.from(json["productCategoryImgArray"]!.map((x) => ProductCategoryImgArray.fromJson(x))),
    isDeleted: json["isDeleted"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productCategoryId": productCategoryId,
    "productCategoryName": productCategoryName,
    "productCategoryImgArray": productCategoryImgArray == null ? [] : List<dynamic>.from(productCategoryImgArray!.map((x) => x.toJson())),
    "isDeleted": isDeleted,
    "__v": v,
  };
}

class ProductCategoryImgArray {
  String? imagePath;
  String? imageType;
  String? id;

  ProductCategoryImgArray({
    this.imagePath,
    this.imageType,
    this.id,
  });

  factory ProductCategoryImgArray.fromJson(Map<String, dynamic> json) => ProductCategoryImgArray(
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
