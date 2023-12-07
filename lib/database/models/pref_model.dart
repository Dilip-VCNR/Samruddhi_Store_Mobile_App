import '../../auth/model/check_store_response_model.dart';

class PrefModel {
  StoreInfo? userdata;
  String? email;
  String? phone;
  String? name;
  String? fcmToken;
  String? authToken;
  // String? storeAuthToken;

  PrefModel({
    this.userdata,
    this.email,
    this.phone,
    this.name,
    this.fcmToken,
    this.authToken,
    // this.storeAuthToken
  });

  factory PrefModel.fromJson(Map<String, dynamic> parsedJson) {
    return PrefModel(
        userdata: parsedJson['userData'],
        email: parsedJson['email'] ?? "",
        phone: parsedJson['phone'] ?? "",
        name: parsedJson['name'] ?? "",
        fcmToken: parsedJson['fcmToken'] ?? "",
        authToken: parsedJson['authToken'] ?? "",
        // storeAuthToken: parsedJson['storeAuthToken'] ?? "storeTokenInfo"
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": userdata,
      "email": email,
      "phone": phone,
      "name": name,
      "fcmToken": fcmToken,
      "authToken": authToken,
      // "storeAuthToken": storeAuthToken
    };
  }
}


