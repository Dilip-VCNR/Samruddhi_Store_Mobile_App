import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samruddhi_store/splash/view/splash_screen.dart';
import 'package:samruddhi_store/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samruddhi_store/utils/routes.dart';

import 'auth/view/login_screen.dart';
import 'auth/view/otp_screen.dart';
import 'auth/view/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
      ),
      title: 'Samruddhi Store',
      initialRoute: Routes.splashRoute,
      routes: {
        Routes.splashRoute: (context) => const SplashScreen(),
        Routes.loginRoute: (context) => const LoginScreen(),
        Routes.otpScreenRoute: (context) => const OtpScreen(),
        Routes.registerRoute: (context) => const RegisterScreen(),
      }
    );
  }
}

