// To parse this JSON data, do
//
//     final orderStatusUpdateResponseModel = orderStatusUpdateResponseModelFromJson(jsonString);

import 'dart:convert';

OrderStatusUpdateResponseModel orderStatusUpdateResponseModelFromJson(String str) => OrderStatusUpdateResponseModel.fromJson(json.decode(str));

String orderStatusUpdateResponseModelToJson(OrderStatusUpdateResponseModel data) => json.encode(data.toJson());

class OrderStatusUpdateResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  Result? result;

  OrderStatusUpdateResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory OrderStatusUpdateResponseModel.fromJson(Map<String, dynamic> json) => OrderStatusUpdateResponseModel(
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
  DeliveryDetailsArray? deliveryDetailsArray;
  dynamic orderTime;
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
    this.deliveryDetailsArray,
    this.orderTime,
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
    deliveryDetailsArray: json["deliveryDetailsArray"] == null ? null : DeliveryDetailsArray.fromJson(json["deliveryDetailsArray"]),
    orderTime: json["orderTime"],
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
    "deliveryDetailsArray": deliveryDetailsArray?.toJson(),
    "orderTime": orderTime,
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
  String? remarks;
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
  dynamic description;
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
  dynamic manufacturer;
  dynamic productModel;
  bool? isDeleted;
  List<dynamic>? productImgArray;
  int? taxableValue;
  dynamic productTaxValue;
  double? productGrandTotal;
  int? subTotal;

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
    productImgArray: json["productImgArray"] == null ? [] : List<dynamic>.from(json["productImgArray"]!.map((x) => x)),
    taxableValue: json["taxableValue"],
    productTaxValue: json["productTaxValue"],
    productGrandTotal: json["productGrandTotal"]?.toDouble(),
    subTotal: json["subTotal"],
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
    "productImgArray": productImgArray == null ? [] : List<dynamic>.from(productImgArray!.map((x) => x)),
    "taxableValue": taxableValue,
    "productTaxValue": productTaxValue,
    "productGrandTotal": productGrandTotal,
    "subTotal": subTotal,
  };
}
