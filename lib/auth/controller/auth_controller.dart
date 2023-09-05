import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';

import '../../utils/routes.dart';

class AuthController {
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
}
