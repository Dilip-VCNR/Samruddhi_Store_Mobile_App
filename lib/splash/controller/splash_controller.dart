import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../utils/routes.dart';

class SplashController {
  moveToCorrespondingPage(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    });
  }
}
