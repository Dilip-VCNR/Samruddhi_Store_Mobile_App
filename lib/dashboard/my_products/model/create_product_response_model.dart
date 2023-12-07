// To parse this JSON data, do
//
//     final createProductResponseModel = createProductResponseModelFromJson(jsonString);

import 'dart:convert';

List<CreateProductResponseModel> createProductResponseModelFromJson(String str) => List<CreateProductResponseModel>.from(json.decode(str).map((x) => CreateProductResponseModel.fromJson(x)));

String createProductResponseModelToJson(List<CreateProductResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CreateProductResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  Result? result;

  CreateProductResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory CreateProductResponseModel.fromJson(Map<String, dynamic> json) => CreateProductResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  String? createdAt;
  String? productUuid;
  String? productName;
  List<ProductImgArray>? productImgArray;
  String? storeUuid;
  String? storeName;
  ProductSubCategory? productSubCategory;
  String? description;
  bool? isMrp;
  int? sellingPrice;
  Variants? variants;
  bool? isAvailable;
  String? productSku;
  String? productUom;
  int? productTax;
  int? productDiscount;
  int? productOffer;
  int? productQuantity;
  int? addedCartQuantity;
  int? purchaseMinQuantity;
  int? productHsnCode;
  String? manufacturer;
  String? productModel;
  bool? isDeleted;
  int? productGrandTotal;
  String? id;
  int? v;

  Result({
    this.createdAt,
    this.productUuid,
    this.productName,
    this.productImgArray,
    this.storeUuid,
    this.storeName,
    this.productSubCategory,
    this.description,
    this.isMrp,
    this.sellingPrice,
    this.variants,
    this.isAvailable,
    this.productSku,
    this.productUom,
    this.productTax,
    this.productDiscount,
    this.productOffer,
    this.productQuantity,
    this.addedCartQuantity,
    this.purchaseMinQuantity,
    this.productHsnCode,
    this.manufacturer,
    this.productModel,
    this.isDeleted,
    this.productGrandTotal,
    this.id,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    createdAt: json["createdAt"],
    productUuid: json["productUuid"],
    productName: json["productName"],
    productImgArray: json["productImgArray"] == null ? [] : List<ProductImgArray>.from(json["productImgArray"]!.map((x) => ProductImgArray.fromJson(x))),
    storeUuid: json["storeUuid"],
    storeName: json["storeName"],
    productSubCategory: json["productSubCategory"] == null ? null : ProductSubCategory.fromJson(json["productSubCategory"]),
    description: json["description"],
    isMrp: json["isMrp"],
    sellingPrice: json["sellingPrice"],
    variants: json["variants"] == null ? null : Variants.fromJson(json["variants"]),
    isAvailable: json["isAvailable"],
    productSku: json["productSku"],
    productUom: json["productUom"],
    productTax: json["productTax"],
    productDiscount: json["productDiscount"],
    productOffer: json["productOffer"],
    productQuantity: json["productQuantity"],
    addedCartQuantity: json["addedCartQuantity"],
    purchaseMinQuantity: json["purchaseMinQuantity"],
    productHsnCode: json["productHsnCode"],
    manufacturer: json["manufacturer"],
    productModel: json["productModel"],
    isDeleted: json["isDeleted"],
    productGrandTotal: json["productGrandTotal"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "productUuid": productUuid,
    "productName": productName,
    "productImgArray": productImgArray == null ? [] : List<dynamic>.from(productImgArray!.map((x) => x.toJson())),
    "storeUuid": storeUuid,
    "storeName": storeName,
    "productSubCategory": productSubCategory?.toJson(),
    "description": description,
    "isMrp": isMrp,
    "sellingPrice": sellingPrice,
    "variants": variants?.toJson(),
    "isAvailable": isAvailable,
    "productSku": productSku,
    "productUom": productUom,
    "productTax": productTax,
    "productDiscount": productDiscount,
    "productOffer": productOffer,
    "productQuantity": productQuantity,
    "addedCartQuantity": addedCartQuantity,
    "purchaseMinQuantity": purchaseMinQuantity,
    "productHsnCode": productHsnCode,
    "manufacturer": manufacturer,
    "productModel": productModel,
    "isDeleted": isDeleted,
    "productGrandTotal": productGrandTotal,
    "_id": id,
    "__v": v,
  };
}

class ProductImgArray {
  String? imagePath;
  String? imageType;
  bool? isPrimary;
  String? imageDescription;
  String? id;

  ProductImgArray({
    this.imagePath,
    this.imageType,
    this.isPrimary,
    this.imageDescription,
    this.id,
  });

  factory ProductImgArray.fromJson(Map<String, dynamic> json) => ProductImgArray(
    imagePath: json["imagePath"],
    imageType: json["imageType"],
    isPrimary: json["isPrimary"],
    imageDescription: json["imageDescription"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "imagePath": imagePath,
    "imageType": imageType,
    "isPrimary": isPrimary,
    "imageDescription": imageDescription,
    "_id": id,
  };
}

class ProductSubCategory {
  String? productCategoryId;
  String? productSubCategoryId;
  String? productSubCategoryName;

  ProductSubCategory({
    this.productCategoryId,
    this.productSubCategoryId,
    this.productSubCategoryName,
  });

  factory ProductSubCategory.fromJson(Map<String, dynamic> json) => ProductSubCategory(
    productCategoryId: json["productCategoryId"],
    productSubCategoryId: json["productSubCategoryId"],
    productSubCategoryName: json["productSubCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "productCategoryId": productCategoryId,
    "productSubCategoryId": productSubCategoryId,
    "productSubCategoryName": productSubCategoryName,
  };
}

class Variants {
  String? color;
  String? size;
  String? quality;

  Variants({
    this.color,
    this.size,
    this.quality,
  });

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
    color: json["color"],
    size: json["size"],
    quality: json["quality"],
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "size": size,
    "quality": quality,
  };
}
