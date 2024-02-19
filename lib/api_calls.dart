import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:samruddhi_store/auth/models/hub_list_response_model.dart';
import 'package:samruddhi_store/auth/models/store_category_list_model.dart';
import 'package:samruddhi_store/auth/models/store_zone_list_model.dart';
import 'package:samruddhi_store/dashboard/my_products/models/add_product_response_model.dart';
import 'package:samruddhi_store/dashboard/my_products/models/all_product_response_model.dart';
import 'package:samruddhi_store/dashboard/my_products/models/product_category_list_model.dart';
import 'package:samruddhi_store/dashboard/my_products/models/product_sub_category_list_model.dart';
import 'package:samruddhi_store/dashboard/orders/models/update_payment_status_model.dart';
import 'package:samruddhi_store/utils/url_constants.dart';

import 'auth/models/login_response_model.dart';
import 'auth/models/register_response_model.dart';
import 'dashboard/home/models/home_data_model.dart';
import 'dashboard/orders/models/order_on_status_response_model.dart';
import 'dashboard/orders/models/order_status_update_response_model.dart';
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
    log(response.body.toString());
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
      String? isHomeDelivery,
      String deliveryMethod,
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
      File? selectedImage, String commission,String deliveryfee) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(UrlConstant.registerStore));
    // Add form fields
    request.fields['isHeadquarters'] = isHeadquarters == "Yes" ? "true" : "false";
    request.fields['storeUuid'] = latestUid;
    request.fields['storeName'] = storeName!;
    request.fields['storeCategoryName'] = storeCategory!;
    request.fields['displayName'] = storeDisplayName;
    request.fields['gstNo'] = gst;
    request.fields['mobile'] = phoneNumber!;
    request.fields['emailId'] = storeEmail;
    request.fields['isHomeDelivery'] =
        isHomeDelivery == "Yes" ? "true" : "false";
    request.fields['deliveryType'] = deliveryMethod=="Hub Delivery"?"hubDelivery":"storeDelivery";
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
    request.fields['deliveryFee'] = deliveryfee;
    request.fields['storeCommissionPercent'] = commission;

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
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseJson = json.decode(utf8.decode(responseData));
    return RegisterResponseModel.fromJson(responseJson);
  }

  Future<StoreCategoryListModel> getStoreCategoryList() async {
    http.Response response = await http.get(
      Uri.parse(UrlConstant.storeCategoryList),
      headers: getHeaders(false),
    );
    return StoreCategoryListModel.fromJson(json.decode(response.body));
  }

  Future<ProductCategoryListModel> getProductCategoryList() async {
    http.Response response = await http.get(
      Uri.parse(UrlConstant.productCategoryList),
      headers: getHeaders(true),
    );
    return ProductCategoryListModel.fromJson(json.decode(response.body));
  }

  Future<ProductSubCategoryListModel> getProductSubCategoryList() async {
    http.Response response = await http.get(
      Uri.parse(UrlConstant.productSubCategoryList),
      headers: getHeaders(true),
    );
    return ProductSubCategoryListModel.fromJson(json.decode(response.body));
  }

  Future<StoreZoneListModel> getStoreZonesList() async {
    http.Response response = await http.get(
      Uri.parse(UrlConstant.storeZoneList),
      headers: getHeaders(false),
    );
    return StoreZoneListModel.fromJson(json.decode(response.body));
  }

  Future<AddProductResponseModel> addNewProduct({
    String? productSku,
    String? productName,
    String? productQuantity,
    String? productCategoryName,
    String? description,
    String? sellingPrice,
    String? productTax,
    String? productUom,
    String? productDiscount,
    String? productOffer,
    String? purchaseMinQuantity,
    String? manufacturer,
    String? productHsnCode,
    String? productModel,
    String? productSubCategoryName,
    File? selectedImage, String? isPerishable, String? isReturnable, bool? isAvailable, String? expiryDate,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(UrlConstant.createProduct));
    // Add form fields
    request.fields['productSku'] = productSku!;
    request.fields['productName'] = productName!;
    request.fields['storeUuid'] = prefModel.userData!.storeUuid!;
    request.fields['storeName'] = prefModel.userData!.storeName!;
    request.fields['productQuantity'] = productQuantity!;
    request.fields['isAvailable'] = "true";
    request.fields['productCategoryName'] = productCategoryName!;
    request.fields['description'] = description!;
    request.fields['isMrp'] = "true";
    request.fields['sellingPrice'] = sellingPrice!;
    request.fields['productTax'] = productTax!;
    request.fields['productUom'] = productUom!;
    request.fields['productDiscount'] = productDiscount!;
    request.fields['manufacturer'] = manufacturer!;
    request.fields['productHsnCode'] = productHsnCode!;
    request.fields['productModel'] = productModel!;
    request.fields['productSubCategoryName'] = productSubCategoryName!;
    request.fields['isPerishable'] = isPerishable!;
    request.fields['isReturnable'] = isReturnable!;
    request.fields['isAvailable'] = isAvailable.toString();
    request.fields['productExpiryDate'] = expiryDate.toString();

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
    request.headers.addAll({
      "x-access-token": "${prefModel.userData!.storeAuthToken}",
    });
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseJson = json.decode(utf8.decode(responseData));
    return AddProductResponseModel.fromJson(responseJson);
  }

  Future<AddProductResponseModel> updateProduct({
    String? productSku,
    String? productName,
    String? productQuantity,
    String? productCategoryName,
    String? description,
    String? sellingPrice,
    String? productTax,
    String? productUom,
    String? productDiscount,
    String? productOffer,
    String? purchaseMinQuantity,
    String? manufacturer,
    String? productHsnCode,
    String? productModel,
    String? productSubCategoryName,
    File? selectedImage, String? isPerishable, String? isReturnable, bool? isAvailable, String? expiryDate, String? lastEditProductId,
  }) async {
    var request =
    http.MultipartRequest('POST', Uri.parse(UrlConstant.updateProduct));
    // Add form fields
    request.fields['productUuid'] = lastEditProductId!;
    request.fields['productSku'] = productSku!;
    request.fields['productName'] = productName!;
    request.fields['storeUuid'] = prefModel.userData!.storeUuid!;
    request.fields['storeName'] = prefModel.userData!.storeName!;
    request.fields['productQuantity'] = productQuantity!;
    request.fields['isAvailable'] = "true";
    request.fields['productCategoryName'] = productCategoryName!;
    request.fields['description'] = description!;
    request.fields['isMrp'] = "true";
    request.fields['sellingPrice'] = sellingPrice!;
    request.fields['productTax'] = productTax!;
    request.fields['productUom'] = productUom!;
    request.fields['productDiscount'] = productDiscount!;
    request.fields['manufacturer'] = manufacturer!;
    request.fields['productHsnCode'] = productHsnCode!;
    request.fields['productModel'] = productModel!;
    request.fields['productSubCategoryName'] = productSubCategoryName!;
    request.fields['isPerishable'] = isPerishable!;
    request.fields['isReturnable'] = isReturnable!;
    request.fields['isAvailable'] = isAvailable.toString();
    request.fields['productExpiryDate'] = expiryDate.toString();

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
    request.headers.addAll({
      "x-access-token": "${prefModel.userData!.storeAuthToken}",
    });
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseJson = json.decode(utf8.decode(responseData));
    return AddProductResponseModel.fromJson(responseJson);
  }

  getStoreProducts() async {
    http.Response response = await hitApi(
        true,
        UrlConstant.getAvailableProducts,
        jsonEncode({"storeUuid": prefModel.userData!.storeUuid}));
    return AllProductResponseModel.fromJson(json.decode(response.body));
  }

  getHubOnZone(String selectedZone) async {
    http.Response response = await hitApi(
        false, UrlConstant.getHubOnZone, jsonEncode({"zone": selectedZone}));
    return HubListResponseModel.fromJson(json.decode(response.body));
  }

  Future<HomeDataModel> getHomeData() async {
    DateTime today = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd').format(today);
    http.Response response = await hitApi(
        true,
        UrlConstant.storeDashBoard,
        jsonEncode({
          "storeUuid": prefModel.userData!.storeUuid!,
          "orderDate": formattedDate
        }));
    return HomeDataModel.fromJson(json.decode(response.body));
  }

  Future<OrderOnStatusResponseModel> getOrdersOnStatus(
      String orderStatus) async {
    http.Response response = await hitApi(
        true,
        UrlConstant.getOrderOnStatus,
        jsonEncode({
          "storeUuid": prefModel.userData!.storeUuid!,
          "orderStatus": orderStatus
        }));
    return OrderOnStatusResponseModel.fromJson(json.decode(response.body));
  }

  Future<OrderStatusUpdateResponseModel> setOrderStatus(
      String statusType, String orderId) async {
    if (statusType == "Order accepted") {
      statusType = 'accepted';
    } else if (statusType == "Packing Order") {
      statusType = 'processing';
    } else if (statusType == "Packed") {
      statusType = 'ready';
    }
    http.Response response = await hitApi(true, UrlConstant.setOrderStatus,
        jsonEncode({"orderId": orderId, "orderStatus": statusType}));
    print(response.body);
    return OrderStatusUpdateResponseModel.fromJson(json.decode(response.body));
  }

  updateProfile({required String storeName, required String storeDisplayName, required String storeGst, required String storeEmail, required String storeCommission, required String storeDeliveryFee, File? selectedImage}) async {
    var request =
    http.MultipartRequest('POST', Uri.parse(UrlConstant.updateStore));
    // Add form fields
    request.fields['storeUuid'] = prefModel.userData!.storeUuid!;
    request.fields['storeName'] = storeName;
    request.fields['displayName'] = storeDisplayName;
    request.fields['gstNo'] = storeGst;
    request.fields['emailId'] = storeEmail;
    request.fields['deliveryFee'] = storeDeliveryFee;
    // request.fields['storeCommissionPercent'] = storeCommission;
    request.headers.addAll(getHeaders(true));
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
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseJson = json.decode(utf8.decode(responseData));
    return LoginResponseModel.fromJson(responseJson);
  }

  confirmPayment(orderId) async {
    http.Response response = await hitApi(true, UrlConstant.orderPaymentStatusUpdate,
        jsonEncode({"orderId": orderId}));
    print(response.body);
    return UpdatePaymentStatusModel.fromJson(json.decode(response.body));

  }
}
