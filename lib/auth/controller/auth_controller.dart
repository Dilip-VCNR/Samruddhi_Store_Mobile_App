import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

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
}
