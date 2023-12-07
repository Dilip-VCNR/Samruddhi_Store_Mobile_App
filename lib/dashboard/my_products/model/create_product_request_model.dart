// To parse this JSON data, do
//
//     final createProductRequestModel = createProductRequestModelFromJson(jsonString);

import 'dart:convert';

CreateProductRequestModel createProductRequestModelFromJson(String str) => CreateProductRequestModel.fromJson(json.decode(str));

String createProductRequestModelToJson(CreateProductRequestModel data) => json.encode(data.toJson());

class CreateProductRequestModel {
  String? productSku;
  String? productName;
  String? storeUuid;
  String? storeName;
  int? productQuantity;
  bool? isAvailable;
  String? productCategoryName;
  String? description;
  String? image;
  bool? isMrp;
  int? sellingPrice;
  String? color;
  String? size;
  int? quality;
  String? productUom;
  int? productDiscount;
  int? productOffer;
  int? purchaseMinQuantity;
  String? manufacturer;
  int? productHsnCode;
  String? productModel;
  String? productSubCategoryName;

  CreateProductRequestModel({
    this.productSku,
    this.productName,
    this.storeUuid,
    this.storeName,
    this.productQuantity,
    this.isAvailable,
    this.productCategoryName,
    this.description,
    this.image,
    this.isMrp,
    this.sellingPrice,
    this.color,
    this.size,
    this.quality,
    this.productUom,
    this.productDiscount,
    this.productOffer,
    this.purchaseMinQuantity,
    this.manufacturer,
    this.productHsnCode,
    this.productModel,
    this.productSubCategoryName,
  });

  factory CreateProductRequestModel.fromJson(Map<String, dynamic> json) =>
      CreateProductRequestModel(
        productSku: json["productSku"] ?? "",
        productName: json["productName"] ?? "",
        storeUuid: json["storeUuid"] ?? "",
        storeName: json["storeName"] ?? "",
        productQuantity: json["productQuantity"] ?? 0,
        isAvailable: json["isAvailable"] ?? true,
        productCategoryName: json["productCategoryName"]?? "",
        description: json["description"]?? "",
        image: json["image"],
        isMrp: json["isMrp"] ?? false,
        sellingPrice: json["sellingPrice"],
        color: json["color"],
        size: json["size"],
        quality: json["quality"],
        productUom: json["productUom"],
        productDiscount: json["productDiscount"],
        productOffer: json["productOffer"],
        purchaseMinQuantity: json["purchaseMinQuantity"],
        manufacturer: json["manufacturer"],
        productHsnCode: json["productHsnCode"],
        productModel: json["productModel"],
        productSubCategoryName: json["productSubCategoryName"],
      );

  Map<String, dynamic> toJson() =>
      {
        "productSku": productSku,
        "productName": productName,
        "storeUuid": storeUuid,
        "storeName": storeName,
        "productQuantity": productQuantity,
        "isAvailable": isAvailable,
        "productCategoryName": productCategoryName,
        "description": description,
        "image": image,
        "isMrp": isMrp,
        "sellingPrice": sellingPrice,
        "color": color,
        "size": size,
        "quality": quality,
        "productUom": productUom,
        "productDiscount": productDiscount,
        "productOffer": productOffer,
        "purchaseMinQuantity": purchaseMinQuantity,
        "manufacturer": manufacturer,
        "productHsnCode": productHsnCode,
        "productModel": productModel,
        "productSubCategoryName": productSubCategoryName,
      };

}
