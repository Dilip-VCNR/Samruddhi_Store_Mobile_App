import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samruddhi_store/api_calls.dart';
import 'package:samruddhi_store/utils/url_constants.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:http/http.dart' as http;

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
  BuildContext? profileScreenContext;

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
  TextEditingController deliveryMethodController = TextEditingController();
  TextEditingController selectedZoneController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController isHomeDeliveryController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeMailController = TextEditingController();
  TextEditingController storeDisplayNameController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController storeEmailController = TextEditingController();
  TextEditingController hubController = TextEditingController();
  TextEditingController storeCommissionController = TextEditingController();
  TextEditingController deliveryFeeController = TextEditingController();

  //edit profile
  TextEditingController editStoreNameController = TextEditingController();
  TextEditingController editStoreDisplayNameController = TextEditingController();
  TextEditingController editGstController = TextEditingController();
  TextEditingController editStoreEmailController = TextEditingController();
  TextEditingController editStoreCommissionController = TextEditingController();
  TextEditingController editDeliveryFeeController = TextEditingController();

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
  BuildContext? editProfileScreenContext;

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

  bool isNotValidName(String name) {
    // Regular expression pattern to validate name format
    const nameRegex = r'^[a-zA-Z\s]+$';

    // Use RegExp to check if the name matches the pattern
    final regExp = RegExp(nameRegex);
    if (!regExp.hasMatch(name)) {
      return true;
    }

    // Check if the name contains any numbers
    final containsNumbers = name.contains(RegExp(r'[0-9]'));
    return containsNumbers;
  }


  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Ask the user to enable location services
      bool enableService = await askUserToEnableLocationService();
      if (!enableService) {
        // Return last known location if the user chooses not to enable location services
        return getLastKnownLocation();
      }
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Return last known location if permission is denied
        return getLastKnownLocation();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Return last known location if permission is permanently denied
      return getLastKnownLocation();
    }

    // Get current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      // Handle any errors while getting current position
      print('Error getting current position: $e');
      // Return last known location if there is an error
      return getLastKnownLocation();
    }
  }

  Future<Position> getLastKnownLocation() async {
    try {
      Position? position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        print('Using last known location');
        return position;
      } else {
        throw Exception('No last known location available');
      }
    } catch (e) {
      print('Error getting last known location: $e');
      throw Exception('Error getting last known location');
    }
  }
  Future<bool> askUserToEnableLocationService() async {
    // You can use your preferred method to prompt the user to enable location services
    // For example, show a dialog or navigate to the device settings
    // Return true if the user enables location services, false otherwise

    // Example using a simple dialog (this is just for illustration purposes):
    // You should implement a proper UI for your application
    bool userEnabledService = await showDialog(
      context: registerScreenContext!,
      // Implement your dialog here
      builder: (context) => AlertDialog(
        title: const Text("Enable Location Services"),
        content: const Text("Please enable location services for better experience."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // User chose not to enable
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // User chose to enable
            },
            child: const Text("Enable"),
          ),
        ],
      ),
    );

    return userEnabledService ;
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
    LoginResponseModel authResponse = await apiCalls.getUserDetails(uid, fcmToken!);
    if (authResponse.statusCode == 200) {
      otpCode = "";
      notifyListeners();
      prefModel.userData = authResponse.result;
      await AppPref.setPref(prefModel);
      Navigator.pop(otpScreenContext!);
      Navigator.pushNamedAndRemoveUntil(
          otpScreenContext!, Routes.dashboardRoute, (route) => false);
    } else if (authResponse.statusCode == 404) {
      storeCategoryList = await apiCalls.getStoreCategoryList();
      storeZoneList = await apiCalls.getStoreZonesList();
      if (storeCategoryList!.statusCode == 200 &&
          storeCategoryList!.result!.isNotEmpty &&
          storeZoneList!.statusCode == 200 &&
          storeZoneList!.result!.isNotEmpty) {
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
        isHomeDelivery,
        deliveryMethodController.text,
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
        selectedImage,
        storeCommissionController.text,
        deliveryFeeController.text);
    if (registerResponse.statusCode == 201) {
      prefModel.userData = registerResponse.result![0];
      await AppPref.setPref(prefModel);
      await clearFieldData();
      clearRegisterForm();
      Navigator.pop(fillAddressBottomSheetContext!);
      Navigator.pushNamedAndRemoveUntil(fillAddressBottomSheetContext!,
          Routes.dashboardRoute, (route) => false);
    } else {
      Navigator.pop(fillAddressBottomSheetContext!);
      showErrorToast(fillAddressBottomSheetContext!, registerResponse.message!);
    }
  }

  clearRegisterForm() {
    isHeadquarters = '';
    selectedCategory = '';
    isHomeDelivery = '';
    deliveryType = '';
    selectedZone = '';
    selectedHubUuid = '';
    selectedHubName = '';

    isHeadquartersController.clear();
    isHomeDeliveryController.clear();
    selectedZoneController.clear();
    categoryController.clear();
    deliveryMethodController.clear();
    storeNameController.clear();
    storeMailController.clear();
    storeDisplayNameController.clear();
    gstController.clear();
    storeEmailController.clear();
    hubController.clear();
    storeCommissionController.clear();
    deliveryFeeController.clear();

    addressController.clear();
    cityController.clear();
    stateController.clear();
    postalCodeController.clear();
    selectedImage = null;
    notifyListeners();
  }

  getHubOnZone() async {
    hubList = await apiCalls.getHubOnZone(selectedZone!);
    notifyListeners();
    if (hubList!.statusCode != 200) {
      showErrorToast(registerScreenContext!, hubList!.message!);
    }
  }

  updateProfile() async {
    showLoaderDialog(editProfileScreenContext!);
    LoginResponseModel response = await apiCalls.updateProfile(
        storeName: editStoreNameController.text,
        storeDisplayName: editStoreDisplayNameController.text,
        storeGst: editGstController.text,
        storeEmail: editStoreEmailController.text,
        storeCommission: editStoreCommissionController.text,
        storeDeliveryFee: editDeliveryFeeController.text,
        selectedImage: selectedImage);

    if (response.statusCode == 200) {
      prefModel.userData = response.result;
      await AppPref.setPref(prefModel);
      clearEditProfileFields();
      notifyListeners();
      Navigator.pop(editProfileScreenContext!);
      Navigator.pop(editProfileScreenContext!);
      showSuccessToast(editProfileScreenContext!, response.message!);
    } else {
      Navigator.pop(editProfileScreenContext!);
      showErrorToast(editProfileScreenContext!, response.message!);
    }
  }

  void clearEditProfileFields() {
    editStoreNameController.clear();
    editStoreDisplayNameController.clear();
    editGstController.clear();
    editStoreEmailController.clear();
    editStoreCommissionController.clear();
    editDeliveryFeeController.clear();
    selectedImage=null;
  }

  Future<void> moveToEditProfile() async {
    editStoreNameController.text = prefModel.userData!.storeName!;
    editStoreDisplayNameController.text = prefModel.userData!.displayName!;
    editGstController.text = prefModel.userData!.gstNo!;
    editStoreEmailController.text = prefModel.userData!.emailId!;
    editStoreCommissionController.text = prefModel.userData!.storeCommissionPercent.toString();
    editDeliveryFeeController.text = prefModel.userData!.deliveryFee!.toString();
    selectedImage = await downloadImageAndReturnFilePath(UrlConstant.imageBaseUrl+prefModel.userData!.storeImgArray![0].imageUrl!);
    Navigator.pushNamed(profileScreenContext!, Routes.editProfile);
  }

  Future<File?> downloadImageAndReturnFilePath(String imageUrl) async {
    try {
      // Fetch the image data
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Create a temporary file
        File tempFile = File('${Directory.systemTemp.path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.jpg');

        // Write the image data to the temporary file
        await tempFile.writeAsBytes(response.bodyBytes);

        // Return the path to the temporary file
        return tempFile;
      } else {
        print('Failed to download image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

}
