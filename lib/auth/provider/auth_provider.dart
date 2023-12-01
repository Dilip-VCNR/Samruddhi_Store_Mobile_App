import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../api_calls.dart';
import '../../database/app_pref.dart';
import '../../database/models/pref_model.dart';
import '../../utils/app_widgets.dart';
import '../../utils/routes.dart';
import '../model/check_store_response_model.dart';

class AuthProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();

  String? lastVerificationId;
  int? lastResendToken;
  String otpCode = "";
  //login
  String? selectedCountryCode = "+91";
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();


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

  void loginWithPhone(BuildContext context, String text, String? selectedCountryCode) {
    Navigator.pushNamed(context, Routes.otpScreenRoute);
  }

  void validateOtp(BuildContext context) {
    Navigator.pushNamed(context, Routes.registerRoute);
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
        await apiCallForUserDetails(context,value.user,);
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
    CheckStoreResponseModel userData = await apiCalls.checkForUser(user,fcmToken);
    if(userData.statusCode==200){
      PrefModel prefModel = AppPref.getPref();
      prefModel.userdata = userData.result;
      await AppPref.setPref(prefModel);
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.dashboardRoute);
    }else{
      if(userData.statusCode==400 && userData.message=="record not found"){
        // lastAuthUserData = user;
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.registerRoute);
      }else{
        Navigator.pop(context);
        showErrorToast(context, userData.message!);
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
