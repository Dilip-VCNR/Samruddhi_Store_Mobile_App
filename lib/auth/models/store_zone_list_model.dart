// To parse this JSON data, do
//
//     final storeZoneListModel = storeZoneListModelFromJson(jsonString);

import 'dart:convert';

StoreZoneListModel storeZoneListModelFromJson(String str) => StoreZoneListModel.fromJson(json.decode(str));

String storeZoneListModelToJson(StoreZoneListModel data) => json.encode(data.toJson());

class StoreZoneListModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Result>? result;

  StoreZoneListModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory StoreZoneListModel.fromJson(Map<String, dynamic> json) => StoreZoneListModel(
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
  String? zoneId;
  String? name;
  Loc? loc;
  bool? isDeleted;
  bool? isApproved;
  int? v;

  Result({
    this.id,
    this.createdAt,
    this.zoneId,
    this.name,
    this.loc,
    this.isDeleted,
    this.isApproved,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    createdAt: json["createdAt"],
    zoneId: json["zoneId"],
    name: json["name"],
    loc: json["loc"] == null ? null : Loc.fromJson(json["loc"]),
    isDeleted: json["isDeleted"],
    isApproved: json["isApproved"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt,
    "zoneId": zoneId,
    "name": name,
    "loc": loc?.toJson(),
    "isDeleted": isDeleted,
    "isApproved": isApproved,
    "__v": v,
  };
}

class Loc {
  String? type;
  List<List<double>>? coordinates;

  Loc({
    this.type,
    this.coordinates,
  });

  factory Loc.fromJson(Map<String, dynamic> json) => Loc(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<List<double>>.from(json["coordinates"]!.map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}
