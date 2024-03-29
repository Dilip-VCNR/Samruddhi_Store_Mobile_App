
import '../../auth/models/login_response_model.dart';

class PrefModel {
  StoreInfo? userData;
  AddressArray? selectedAddress;

  PrefModel({
    this.userData,
    this.selectedAddress,
  });

  factory PrefModel.fromJson(Map<String, dynamic> parsedJson) {
    return PrefModel(
      userData: parsedJson["userData"] == null
          ? null
          : StoreInfo.fromJson(parsedJson["userData"]),
      selectedAddress: parsedJson["selectedAddress"] == null
          ? null
          : AddressArray.fromJson(parsedJson["selectedAddress"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userData": userData?.toJson(),
      "selectedAddress": selectedAddress?.toJson(),
    };
  }
}
