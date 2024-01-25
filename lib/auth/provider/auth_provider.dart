import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samruddhi_store/api_calls.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../database/app_pref.dart';
import '../../utils/app_widgets.dart';
import '../../utils/routes.dart';
import '../models/hub_list_response_model.dart';
import '../models/login_response_model.dart';
import '../models/register_response_model.dart';
import '../models/store_category_list_model.dart';
import '../models/store_zone_list_model.dart';
import 'location_controller.dart';

class AuthProvider extends ChangeNotifier {
  File? selectedImage;

  LatLng? selectedLocation;
  StoreCategoryListModel? storeCategoryList;
  StoreZoneListModel? storeZoneList;
  ApiCalls apiCalls = ApiCalls();
  bool? serviceEnabled;
  LocationPermission? permission;
  String? verificationIdValue;
  String? latestUid;
  Position? currentPosition;

  // login page declarations
  String? selectedCountryCode = "+91";
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  BuildContext? loginPageContext;

  // otp screen declarations
  BuildContext? otpScreenContext;
  CountdownController countdownController =
      CountdownController(autoStart: true);
  int seconds = 30;
  bool firstStateEnabled = false;
  String otpCode = "";

  // register screen declarations
  String? isHeadquarters;
  final registerFormKey = GlobalKey<FormState>();
  BuildContext? registerScreenContext;
  String? selectedCategory;
  String? isHomeDelivery;
  String? deliveryType;
  String? selectedZone;
  String? selectedHubUuid;
  String? selectedHubName;

  TextEditingController isHeadquartersController = TextEditingController();
  TextEditingController homeDeliveryTypeController = TextEditingController();
  TextEditingController selectedZoneController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController deliveryTypeController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeMailController = TextEditingController();
  TextEditingController storeDisplayNameController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController storeEmailController = TextEditingController();
  TextEditingController hubController = TextEditingController();

  // mark location screen declarations
  GoogleMapController? mapController;
  String location = "Search location";
  LocationController locationController = LocationController();
  TextEditingController searchController = TextEditingController();

  // selectPrimaryAddress Bottom sheet declarations
  final primaryAddressFormKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  BuildContext? fillAddressBottomSheetContext;


  HubListResponseModel? hubList;
  bool isNotValidEmail(String email) {
    const emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$';
    final regExp = RegExp(emailRegex);
    return !regExp.hasMatch(email);
  }

  bool isNotValidPhone(String value) {
    if (value.length != 10) {
      return true;
    } else {
      return false;
    }
  }

  Future<Position> getCurrentLocation() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  Future<void> loginWithPhoneNumber() async {
    showLoaderDialog(loginPageContext!);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$selectedCountryCode ${phoneNumberController.text}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Navigator.pop(loginPageContext!);
        showErrorToast(loginPageContext!, "Something Went Wrong $e");
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIdValue = verificationId;
        Navigator.pop(loginPageContext!);
        showSuccessToast(loginPageContext!,
            "OTP is sent to $selectedCountryCode ${phoneNumberController.text}");
        Navigator.pushNamed(loginPageContext!, Routes.otpScreenRoute);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> resendOtp() async {
    showLoaderDialog(loginPageContext!);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$selectedCountryCode ${phoneNumberController.text}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Navigator.pop(otpScreenContext!);
        showErrorToast(loginPageContext!, "Something Went Wrong $e");
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIdValue = verificationId;
        Navigator.pop(otpScreenContext!);
        showSuccessToast(loginPageContext!,
            "OTP is sent to $selectedCountryCode ${phoneNumberController.text}");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOtp() async {
    showLoaderDialog(loginPageContext!);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdValue!,
      smsCode: otpCode,
    );
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        latestUid = value.user!.uid;
        await apiCallForStoreDetails(value.user!.uid);
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(otpScreenContext!);
      showErrorToast(
          otpScreenContext!, "Oops !You have entered a wrong OTP\n$e");
    }
  }

  apiCallForStoreDetails(String uid) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    LoginResponseModel authResponse =
        await apiCalls.getUserDetails(uid, fcmToken!);
    if (authResponse.statusCode == 200) {
      otpCode = "";
      notifyListeners();
      prefModel.userData = authResponse.result;
      await AppPref.setPref(prefModel);
      Navigator.pop(otpScreenContext!);
      Navigator.pushNamedAndRemoveUntil(otpScreenContext!, Routes.dashboardRoute, (route) => false);
    } else if (authResponse.statusCode == 404) {
      storeCategoryList = await apiCalls.getStoreCategoryList();
      storeZoneList = await apiCalls.getStoreZonesList();
      if (storeCategoryList!.statusCode == 200 && storeCategoryList!.result!.isNotEmpty && storeZoneList!.statusCode==200 && storeZoneList!.result!.isNotEmpty) {
        Navigator.pop(otpScreenContext!);
        Navigator.pushNamed(otpScreenContext!, Routes.registerRoute);
      } else {
        Navigator.pop(otpScreenContext!);
        showErrorToast(otpScreenContext!, storeCategoryList!.message!);
        showErrorToast(otpScreenContext!, storeZoneList!.message!);
      }
    } else {
      Navigator.pop(otpScreenContext!);
      showErrorToast(otpScreenContext!, authResponse.message!);
    }
  }

  getApproxLocation() async {
    showLoaderDialog(registerScreenContext!);
    try {
      currentPosition = await getCurrentLocation();
    } catch (e) {
      currentPosition = const Position(
          latitude: 10.1632,
          longitude: 76.6413,
          timestamp: null,
          accuracy: 100,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0);
    }
    Navigator.pop(registerScreenContext!);
    Navigator.pushNamed(registerScreenContext!, Routes.markLocationRoute);
  }

  clearFieldData() {
    phoneNumberController.text = "";
    otpCode = "";
    notifyListeners();
  }

  getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  registerNewStore() async {
    showLoaderDialog(fillAddressBottomSheetContext!);
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    RegisterResponseModel registerResponse = await apiCalls.registerNewUser(
        isHeadquarters!,
        latestUid!,
        storeNameController.text,
        categoryController.text,
        storeDisplayNameController.text,
        gstController.text,
        phoneNumberController.text,
        storeEmailController.text,
        homeDeliveryTypeController.text,
        deliveryTypeController.text,
        selectedHubUuid.toString(),
        "branchOffice",
        addressController.text,
        cityController.text,
        stateController.text,
        selectedLocation!.latitude,
        selectedLocation!.longitude,
        selectedZoneController.text,
        postalCodeController.text,
        fcmToken!,
        selectedImage);
    if (registerResponse.statusCode == 201) {
      prefModel.userData = registerResponse.result![0];
      await AppPref.setPref(prefModel);
      await clearFieldData();
      Navigator.pop(fillAddressBottomSheetContext!);
      Navigator.pushNamedAndRemoveUntil(fillAddressBottomSheetContext!,
          Routes.dashboardRoute, (route) => false);
    } else {
      Navigator.pop(fillAddressBottomSheetContext!);
      showErrorToast(fillAddressBottomSheetContext!, registerResponse.message!);
    }
  }

  getHubOnZone() async {
    hubList = await apiCalls.getHubOnZone(selectedZone!);
    notifyListeners();
    if(hubList!.statusCode!=200){
      showErrorToast(registerScreenContext!, hubList!.message!);
    }
  }
}
