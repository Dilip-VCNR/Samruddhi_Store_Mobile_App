import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/dashboard/my_products/view/edit_product.dart';
import 'package:samruddhi_store/dashboard/orders/view/view_order_detail.dart';
import 'package:samruddhi_store/splash/view/splash_screen.dart';
import 'package:samruddhi_store/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samruddhi_store/utils/routes.dart';

import 'auth/provider/auth_provider.dart';
import 'auth/view/login_screen.dart';
import 'auth/view/mark_location.dart';
import 'auth/view/otp_screen.dart';
import 'auth/view/register_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'dashboard/my_products/view/add_product.dart';
import 'database/app_pref.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPref.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
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
          Routes.markLocationRoute: (context) => const MarkLocation(),
          Routes.dashboardRoute: (context) => const DashboardScreen(),
          Routes.viewOrderDetailRoute: (context) => const ViewOrderDetail(),
          Routes.addProductRoute: (context) => const AddProduct(),
          Routes.editProductRoute: (context) => const EditProduct(),
        }
      ),
    );
  }
}

