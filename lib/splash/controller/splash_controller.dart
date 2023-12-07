import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../database/app_pref.dart';
import '../../database/models/pref_model.dart';
import '../../utils/routes.dart';

class SplashController {
  moveToCorrespondingPage(BuildContext context) {
    PrefModel? userData = AppPref.getPref();
    if (userData.userdata != null) {
      if(context.mounted) {
        Navigator.pushReplacementNamed(context, Routes.dashboardRoute);
      }
    } else {
      if (context.mounted) {
        Timer(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, Routes.loginRoute);
        });
      }
    }
  }
}
