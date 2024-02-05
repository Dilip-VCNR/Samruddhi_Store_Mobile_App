// To parse this JSON data, do
//
//     final updatePaymentStatusModel = updatePaymentStatusModelFromJson(jsonString);

import 'dart:convert';

UpdatePaymentStatusModel updatePaymentStatusModelFromJson(String str) => UpdatePaymentStatusModel.fromJson(json.decode(str));

String updatePaymentStatusModelToJson(UpdatePaymentStatusModel data) => json.encode(data.toJson());

class UpdatePaymentStatusModel {
  bool? status;
  int? statusCode;
  String? message;
  Result? result;

  UpdatePaymentStatusModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory UpdatePaymentStatusModel.fromJson(Map<String, dynamic> json) => UpdatePaymentStatusModel(
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
  String? orderId;
  String? storeUuid;
  double? orderGrandTotal;
  String? customerUuid;
  String? paymentMode;
  String? paymentStatus;
  double? storeAmount;
  double? deliveryPartnerAmount;
  double? samruddhiAmount;
  String? id;
  int? v;

  Result({
    this.createdAt,
    this.orderId,
    this.storeUuid,
    this.orderGrandTotal,
    this.customerUuid,
    this.paymentMode,
    this.paymentStatus,
    this.storeAmount,
    this.deliveryPartnerAmount,
    this.samruddhiAmount,
    this.id,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    createdAt: json["createdAt"],
    orderId: json["orderId"],
    storeUuid: json["storeUuid"],
    orderGrandTotal: json["orderGrandTotal"]?.toDouble(),
    customerUuid: json["customerUuid"],
    paymentMode: json["paymentMode"],
    paymentStatus: json["paymentStatus"],
    storeAmount: json["storeAmount"]?.toDouble(),
    deliveryPartnerAmount: json["deliveryPartnerAmount"]?.toDouble(),
    samruddhiAmount: json["SamruddhiAmount"]?.toDouble(),
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "orderId": orderId,
    "storeUuid": storeUuid,
    "orderGrandTotal": orderGrandTotal,
    "customerUuid": customerUuid,
    "paymentMode": paymentMode,
    "paymentStatus": paymentStatus,
    "storeAmount": storeAmount,
    "deliveryPartnerAmount": deliveryPartnerAmount,
    "SamruddhiAmount": samruddhiAmount,
    "_id": id,
    "__v": v,
  };
}
