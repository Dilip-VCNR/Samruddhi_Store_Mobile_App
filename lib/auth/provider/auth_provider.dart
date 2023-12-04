import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../api_calls.dart';
import '../../database/app_pref.dart';
import '../../database/models/pref_model.dart';
import '../../utils/app_widgets.dart';
import '../../utils/routes.dart';
import '../model/check_store_response_model.dart';
import '../model/register_store_request_model.dart';
import '../model/register_store_response_model.dart';

class AuthProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();

  String? selectedCountryCode = "+91";
  String? lastVerificationId;
  int? lastResendToken;
  Position? currentPosition;
  User? lastAuthUserData;

  String otpCode = "";

  //login
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();

  //location
  GoogleMapController? mapController;
  String location = "Search location";
  TextEditingController searchController = TextEditingController();


  //register
  final registerFormKey = GlobalKey<FormState>();

  String? selectedCategory;
  String? selectedDeliveryType;

  TextEditingController categoryController = TextEditingController();
  TextEditingController deliveryTypeController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeMailController = TextEditingController();
  TextEditingController storeDisplayNameController = TextEditingController();
  TextEditingController gstController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController documentController = TextEditingController();

  CountdownController controller = CountdownController(autoStart: true);
  int seconds = 30;
  bool firstStateEnabled = false;

  bool isNotValidPhone(String value) {
    if (value.length != 10) {
      return true;
    } else {
      return false;
    }
  }


  bool? serviceEnabled;
  LocationPermission? permission;

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

  Future<void> sendOtp(BuildContext context) async {
    showLoaderDialog(context);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$selectedCountryCode ${phoneNumberController.text}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        showErrorToast(context, e.toString());
        Navigator.pop(context);
      },
      codeSent: (String verificationId, int? resendToken) {
        lastVerificationId = verificationId;
        lastResendToken = resendToken;
        Navigator.pop(context);
        showSuccessToast(context, "Otp is sent to $selectedCountryCode ${phoneNumberController.text} Successfully !");
        Navigator.pushNamed(context, Routes.otpScreenRoute);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // showErrorToast(context, "OTP timed out, Please resend and try again");
      },
    );
  }

  Future<void> verifyOtp(BuildContext context) async {
    showLoaderDialog(context);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: lastVerificationId!,
      smsCode: otpCode,
    );
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        await apiCallForUserDetails(context, value.user,);
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorToast(
        context,
        "Oops !You have entered a wrong OTP $e",
      );
    }
  }

  apiCallForUserDetails(BuildContext context, User? user) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    CheckStoreResponseModel userData = await apiCalls.checkForStore(
        user, fcmToken);
    if (userData.statusCode == 200) {
      PrefModel prefModel = AppPref.getPref();
      prefModel.userdata = userData.result;
      await AppPref.setPref(prefModel);
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.dashboardRoute);
    } else {
      if (userData.statusCode == 400 &&
          userData.message == "record not found") {
        lastAuthUserData = user;
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.registerRoute);
      } else {
        Navigator.pop(context);
        showErrorToast(context, userData.message!);
      }
    }
  }


  Future<Map<String, dynamic>> getAddressFromLatLong(
      LatLng selectedLocation) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        selectedLocation.latitude, selectedLocation.longitude);
    Placemark place = placeMarks[0];
    return place.toJson();
  }

  Future<void> registerNewStore(BuildContext context) async {
    showLoaderDialog(context);
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    RegisterStoreRequestModel reqObj = RegisterStoreRequestModel();
    reqObj.storeUuid = lastAuthUserData!.uid;
    reqObj.storeName = storeNameController.text;
    reqObj.emailId = storeMailController.text;
    reqObj.password = "xyz";
    reqObj.mobile = phoneNumberController.text as int?;
    reqObj.gstNo = gstController.text;
    reqObj.displayName = storeDisplayNameController.text;
    reqObj.addressType = "Primary";
    reqObj.completeAddress = addressController.text;
    reqObj.city = cityController.text;
    reqObj.state = stateController.text;
    reqObj.lat = currentPosition!.latitude as double?;
    reqObj.lng = currentPosition!.longitude as double?;
    reqObj.zipCode = postalCodeController.text as int?;
    reqObj.image = imageController.text;
    reqObj.document = documentController.text;
    // reqObj.fcmToken = fcmToken;

    RegisterStoreResponseModel response =
    await apiCalls.registerNewStore(context, reqObj.toJson());

    if (response.statusCode == 200) {
      PrefModel prefModel = AppPref.getPref();
      prefModel.userdata = response.result as StoreInfo?;
      await AppPref.setPref(prefModel);
      Navigator.pop(context);
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.dashboardRoute, (route) => false);
    } else {
      Navigator.pop(context);
      if (response.statusCode == 400 &&
          response.message == "customer already exists") {
        showErrorToast(context, response.message!);
      } else {
        showErrorToast(context, response.message!);
      }
    }
  }


  bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

}
