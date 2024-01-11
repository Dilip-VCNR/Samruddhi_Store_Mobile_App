// To parse this JSON data, do
//
//     final orderOnStatusResponseModel = orderOnStatusResponseModelFromJson(jsonString);

import 'dart:convert';

OrderOnStatusResponseModel orderOnStatusResponseModelFromJson(String str) => OrderOnStatusResponseModel.fromJson(json.decode(str));

String orderOnStatusResponseModelToJson(OrderOnStatusResponseModel data) => json.encode(data.toJson());

class OrderOnStatusResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Result>? result;

  OrderOnStatusResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory OrderOnStatusResponseModel.fromJson(Map<String, dynamic> json) => OrderOnStatusResponseModel(
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
  DeliveryAddress? deliveryAddress;
  DeliveryDetailsArray? deliveryDetailsArray;
  String? id;
  String? orderNumber;
  String? orderId;
  String? orderStatus;
  String? storeUuid;
  String? orderDate;
  String? customerUuid;
  int? orderPickupId;
  bool? isVerified;
  dynamic discountType;
  double? orderGrandTotal;
  List<OrderStatusTrackArray>? orderStatusTrackArray;
  dynamic hubUuid;
  dynamic operatorUuid;
  bool? isActive;
  List<ProductDetail>? productDetails;
  int? redeemPoints;
  int? storeDeliverycharge;
  List<dynamic>? paymentDetailsArray;
  List<dynamic>? additionalChargesArray;
  int? v;

  Result({
    this.deliveryAddress,
    this.deliveryDetailsArray,
    this.id,
    this.orderNumber,
    this.orderId,
    this.orderStatus,
    this.storeUuid,
    this.orderDate,
    this.customerUuid,
    this.orderPickupId,
    this.isVerified,
    this.discountType,
    this.orderGrandTotal,
    this.orderStatusTrackArray,
    this.hubUuid,
    this.operatorUuid,
    this.isActive,
    this.productDetails,
    this.redeemPoints,
    this.storeDeliverycharge,
    this.paymentDetailsArray,
    this.additionalChargesArray,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    deliveryAddress: json["deliveryAddress"] == null ? null : DeliveryAddress.fromJson(json["deliveryAddress"]),
    deliveryDetailsArray: json["deliveryDetailsArray"] == null ? null : DeliveryDetailsArray.fromJson(json["deliveryDetailsArray"]),
    id: json["_id"],
    orderNumber: json["orderNumber"],
    orderId: json["orderId"],
    orderStatus: json["orderStatus"],
    storeUuid: json["storeUuid"],
    orderDate: json["orderDate"],
    customerUuid: json["customerUuid"],
    orderPickupId: json["orderPickupId"],
    isVerified: json["isVerified"],
    discountType: json["discountType"],
    orderGrandTotal: json["orderGrandTotal"]?.toDouble(),
    orderStatusTrackArray: json["orderStatusTrackArray"] == null ? [] : List<OrderStatusTrackArray>.from(json["orderStatusTrackArray"]!.map((x) => OrderStatusTrackArray.fromJson(x))),
    hubUuid: json["hubUuid"],
    operatorUuid: json["operatorUuid"],
    isActive: json["isActive"],
    productDetails: json["productDetails"] == null ? [] : List<ProductDetail>.from(json["productDetails"]!.map((x) => ProductDetail.fromJson(x))),
    redeemPoints: json["redeemPoints"],
    storeDeliverycharge: json["storeDeliverycharge"],
    paymentDetailsArray: json["paymentDetailsArray"] == null ? [] : List<dynamic>.from(json["paymentDetailsArray"]!.map((x) => x)),
    additionalChargesArray: json["additionalChargesArray"] == null ? [] : List<dynamic>.from(json["additionalChargesArray"]!.map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "deliveryAddress": deliveryAddress?.toJson(),
    "deliveryDetailsArray": deliveryDetailsArray?.toJson(),
    "_id": id,
    "orderNumber": orderNumber,
    "orderId": orderId,
    "orderStatus": orderStatus,
    "storeUuid": storeUuid,
    "orderDate": orderDate,
    "customerUuid": customerUuid,
    "orderPickupId": orderPickupId,
    "isVerified": isVerified,
    "discountType": discountType,
    "orderGrandTotal": orderGrandTotal,
    "orderStatusTrackArray": orderStatusTrackArray == null ? [] : List<dynamic>.from(orderStatusTrackArray!.map((x) => x.toJson())),
    "hubUuid": hubUuid,
    "operatorUuid": operatorUuid,
    "isActive": isActive,
    "productDetails": productDetails == null ? [] : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
    "redeemPoints": redeemPoints,
    "storeDeliverycharge": storeDeliverycharge,
    "paymentDetailsArray": paymentDetailsArray == null ? [] : List<dynamic>.from(paymentDetailsArray!.map((x) => x)),
    "additionalChargesArray": additionalChargesArray == null ? [] : List<dynamic>.from(additionalChargesArray!.map((x) => x)),
    "__v": v,
  };
}

class DeliveryAddress {
  bool? isDeleted;
  String? addressType;
  String? completeAddress;
  String? city;
  String? state;
  double? lat;
  double? lng;
  int? zipCode;

  DeliveryAddress({
    this.isDeleted,
    this.addressType,
    this.completeAddress,
    this.city,
    this.state,
    this.lat,
    this.lng,
    this.zipCode,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) => DeliveryAddress(
    isDeleted: json["isDeleted"],
    addressType: json["addressType"],
    completeAddress: json["completeAddress"],
    city: json["city"],
    state: json["state"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    zipCode: json["zipCode"],
  );

  Map<String, dynamic> toJson() => {
    "isDeleted": isDeleted,
    "addressType": addressType,
    "completeAddress": completeAddress,
    "city": city,
    "state": state,
    "lat": lat,
    "lng": lng,
    "zipCode": zipCode,
  };
}

class DeliveryDetailsArray {
  bool? isDeleted;

  DeliveryDetailsArray({
    this.isDeleted,
  });

  factory DeliveryDetailsArray.fromJson(Map<String, dynamic> json) => DeliveryDetailsArray(
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "isDeleted": isDeleted,
  };
}

class OrderStatusTrackArray {
  String? action;
  String? date;
  dynamic remarks;
  bool? isDelete;
  String? id;

  OrderStatusTrackArray({
    this.action,
    this.date,
    this.remarks,
    this.isDelete,
    this.id,
  });

  factory OrderStatusTrackArray.fromJson(Map<String, dynamic> json) => OrderStatusTrackArray(
    action: json["action"],
    date: json["date"],
    remarks: json["remarks"],
    isDelete: json["isDelete"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "action": action,
    "date": date,
    "remarks": remarks,
    "isDelete": isDelete,
    "_id": id,
  };
}

class ProductDetail {
  String? productUuid;
  String? productName;
  String? storeUuid;
  String? storeName;
  String? productCategoryId;
  String? productCategoryName;
  dynamic subCategory;
  String? description;
  bool? isMrp;
  int? productTax;
  int? sellingPrice;
  bool? isAvailable;
  String? productSku;
  String? productUom;
  int? productDiscount;
  int? productQuantity;
  int? addedCartQuantity;
  int? purchaseMinQuantity;
  int? productHsnCode;
  String? manufacturer;
  String? productModel;
  bool? isDeleted;
  List<ProductImgArray>? productImgArray;
  int? taxableValue;
  dynamic productTaxValue;
  double? productGrandTotal;
  int? subTotal;
  ProductCategory? productCategory;
  ProductSubCategory? productSubCategory;
  Variants? variants;
  String? id;
  String? createdAt;
  int? productOffer;
  int? v;

  ProductDetail({
    this.productUuid,
    this.productName,
    this.storeUuid,
    this.storeName,
    this.productCategoryId,
    this.productCategoryName,
    this.subCategory,
    this.description,
    this.isMrp,
    this.productTax,
    this.sellingPrice,
    this.isAvailable,
    this.productSku,
    this.productUom,
    this.productDiscount,
    this.productQuantity,
    this.addedCartQuantity,
    this.purchaseMinQuantity,
    this.productHsnCode,
    this.manufacturer,
    this.productModel,
    this.isDeleted,
    this.productImgArray,
    this.taxableValue,
    this.productTaxValue,
    this.productGrandTotal,
    this.subTotal,
    this.productCategory,
    this.productSubCategory,
    this.variants,
    this.id,
    this.createdAt,
    this.productOffer,
    this.v,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productUuid: json["productUuid"],
    productName: json["productName"],
    storeUuid: json["storeUuid"],
    storeName: json["storeName"],
    productCategoryId: json["productCategoryId"],
    productCategoryName: json["productCategoryName"],
    subCategory: json["subCategory"],
    description: json["description"],
    isMrp: json["isMrp"],
    productTax: json["productTax"],
    sellingPrice: json["sellingPrice"],
    isAvailable: json["isAvailable"],
    productSku: json["productSku"],
    productUom: json["productUom"],
    productDiscount: json["productDiscount"],
    productQuantity: json["productQuantity"],
    addedCartQuantity: json["addedCartQuantity"],
    purchaseMinQuantity: json["purchaseMinQuantity"],
    productHsnCode: json["productHsnCode"],
    manufacturer: json["manufacturer"],
    productModel: json["productModel"],
    isDeleted: json["isDeleted"],
    productImgArray: json["productImgArray"] == null ? [] : List<ProductImgArray>.from(json["productImgArray"]!.map((x) => ProductImgArray.fromJson(x))),
    taxableValue: json["taxableValue"],
    productTaxValue: json["productTaxValue"],
    productGrandTotal: json["productGrandTotal"]?.toDouble(),
    subTotal: json["subTotal"],
    productCategory: json["productCategory"] == null ? null : ProductCategory.fromJson(json["productCategory"]),
    productSubCategory: json["productSubCategory"] == null ? null : ProductSubCategory.fromJson(json["productSubCategory"]),
    variants: json["variants"] == null ? null : Variants.fromJson(json["variants"]),
    id: json["_id"],
    createdAt: json["createdAt"],
    productOffer: json["productOffer"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "productUuid": productUuid,
    "productName": productName,
    "storeUuid": storeUuid,
    "storeName": storeName,
    "productCategoryId": productCategoryId,
    "productCategoryName": productCategoryName,
    "subCategory": subCategory,
    "description": description,
    "isMrp": isMrp,
    "productTax": productTax,
    "sellingPrice": sellingPrice,
    "isAvailable": isAvailable,
    "productSku": productSku,
    "productUom": productUom,
    "productDiscount": productDiscount,
    "productQuantity": productQuantity,
    "addedCartQuantity": addedCartQuantity,
    "purchaseMinQuantity": purchaseMinQuantity,
    "productHsnCode": productHsnCode,
    "manufacturer": manufacturer,
    "productModel": productModel,
    "isDeleted": isDeleted,
    "productImgArray": productImgArray == null ? [] : List<dynamic>.from(productImgArray!.map((x) => x.toJson())),
    "taxableValue": taxableValue,
    "productTaxValue": productTaxValue,
    "productGrandTotal": productGrandTotal,
    "subTotal": subTotal,
    "productCategory": productCategory?.toJson(),
    "productSubCategory": productSubCategory?.toJson(),
    "variants": variants?.toJson(),
    "_id": id,
    "createdAt": createdAt,
    "productOffer": productOffer,
    "__v": v,
  };
}

class ProductCategory {
  String? productCategoryId;
  String? productCategoryName;

  ProductCategory({
    this.productCategoryId,
    this.productCategoryName,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    productCategoryId: json["productCategoryId"],
    productCategoryName: json["productCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "productCategoryId": productCategoryId,
    "productCategoryName": productCategoryName,
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
