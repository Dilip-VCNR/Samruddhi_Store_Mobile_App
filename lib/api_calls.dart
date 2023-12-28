import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:samruddhi_store/auth/models/store_category_list_model.dart';
import 'package:samruddhi_store/auth/models/store_zone_list_model.dart';
import 'package:samruddhi_store/utils/url_constants.dart';

import 'auth/models/login_response_model.dart';
import 'auth/models/register_response_model.dart';
import 'database/app_pref.dart';
import 'database/models/pref_model.dart';

String platform = Platform.isIOS ? "IOS" : "Android";
PrefModel prefModel = AppPref.getPref();

class ApiCalls {
  Map<String, String> getHeaders(bool isAuthEnabled) {
    var headers = <String, String>{};
    if (isAuthEnabled) {
      headers.addAll({
        "x-access-token": "${prefModel.userData!.storeAuthToken}",
        "Content-Type": "application/json"
      });
    } else {
      headers.addAll({"Content-Type": "application/json"});
    }
    return headers;
  }

  Future<http.Response> hitApi(
      bool requiresAuth, String url, String body) async {
    return await http.post(
      Uri.parse(url),
      headers: getHeaders(requiresAuth),
      body: body,
    );
  }

  Future<LoginResponseModel> getUserDetails(String uid, String fcmToken) async {
    http.Response response = await hitApi(false, UrlConstant.storeDetails,
        jsonEncode({"storeUuid": uid, "storeFcmToken": fcmToken}));
    return LoginResponseModel.fromJson(json.decode(response.body));
  }

  registerNewUser(
      String isHeadquarters,
      String latestUid,
      String? storeName,
      String? storeCategory,
      String storeDisplayName,
      String gst,
      String? phoneNumber,
      String storeEmail,
      String isHomeDelivery,
      String deliveryType,
      String hubUuid,
      String addressType,
      String completeAddress,
      String city,
      String state,
      double latitude,
      double longitude,
      String zone,
      String postalCode,
      String fcmToken,
      File? selectedImage) async {
    var request = http.MultipartRequest('POST', Uri.parse(UrlConstant.registerStore));
    // Add form fields
    request.fields['isHeadquarters'] = isHeadquarters=="Yes"?"true":"false";
    request.fields['storeUuid'] = latestUid;
    request.fields['storeName'] = storeName!;
    request.fields['storeCategoryName'] = storeCategory!;
    request.fields['displayName'] = storeDisplayName;
    request.fields['gstNo'] = gst;
    request.fields['mobile'] = phoneNumber!;
    request.fields['emailId'] = storeEmail;
    request.fields['isHomeDelivery'] = isHomeDelivery=="Yes"?"true":"false";
    request.fields['deliveryType'] = deliveryType;
    request.fields['hubUuid'] = hubUuid;
    request.fields['addressType'] = addressType;
    request.fields['completeAddress'] = completeAddress;
    request.fields['city'] = city;
    request.fields['state'] = state;
    request.fields['lat'] = latitude.toString();
    request.fields['lng'] = longitude.toString();
    request.fields['zone'] = zone;
    request.fields['zipCode'] = postalCode;
    request.fields['storeFcmToken'] = fcmToken;

    if (selectedImage != null) {
      var picStream = http.ByteStream(selectedImage.openRead());
      var length = await selectedImage.length();
      var multipartFile = http.MultipartFile(
        'image',
        picStream,
        length,
        filename: selectedImage.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);
    }
    print(Uri.parse(UrlConstant.registerStore));
    print(request.fields);
    var response = await request.send();
    print(response);
    print(response.statusCode);
    var responseData = await response.stream.toBytes();
    print(responseData);
    var responseJson = json.decode(utf8.decode(responseData));
    print(responseJson);
    return RegisterResponseModel.fromJson(responseJson);
  }

  Future<StoreCategoryListModel> getStoreCategoryList() async {
    http.Response response = await http.get(
      Uri.parse(UrlConstant.storeCategoryList),
      headers: getHeaders(false),
    );
    return StoreCategoryListModel.fromJson(json.decode(response.body));
  }

  Future<StoreZoneListModel> getStoreZonesList() async {
    http.Response response = await http.get(
      Uri.parse(UrlConstant.storeZoneList),
      headers: getHeaders(false),
    );
    return StoreZoneListModel.fromJson(json.decode(response.body));
  }

  // Future<HomeDataModel>fetchHomeData(double latitude, double longitude) async {
  //   http.Response response = await hitApi(
  //       true,
  //       UrlConstant.userHomePage,
  //       jsonEncode({
  //         "customerUuid": prefModel.userData!.customerUuid,
  //         "lat": latitude,
  //         "lng": longitude
  //       }));
  //   print(response.body);
  //   if(response.statusCode==201){
  //     return HomeDataModel.fromJson(json.decode(response.body));
  //   }else{
  //     throw "err loading";
  //   }
  // }
}
