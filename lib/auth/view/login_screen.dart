import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/auth/provider/auth_provider.dart';
import 'package:samruddhi_store/utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image(
                      image: const AssetImage('assets/images/login_bg.png'),
                      width: screenSize.width,
                      fit: BoxFit.fill,
                    ),
                    const Image(image: AssetImage("assets/images/logo.png")),
                    const Positioned(
                        bottom: 20,
                        left: 20,
                        child: Text(
                          "'Track orders,\nManage Products,\nTrack sales performance,\nAnd more.'",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter your mobile number',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      const Text(
                        'We need to verify you. We will send you a \none time verification code. ',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black,width: 1)),
                            child: CountryCodePicker(
                              showFlag: true,
                              enabled: true,
                              onChanged: (element) {
                                authProvider.selectedCountryCode =
                                    element.dialCode;
                              },
                              initialSelection: 'IN',
                              favorite: const ['+91', 'IN'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Form(
                              key: authProvider.loginFormKey,
                              child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter valid phone number';
                                  }
                                  if (authProvider.isNotValidPhone(value)) {
                                    return "Please enter valid phone number";
                                  }
                                  return null;
                                },
                                controller: authProvider.phoneNumberController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  counterText: "",
                                  isCollapsed: true,
                                  errorStyle: const TextStyle(
                                      color: AppColors.secondaryColor),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'By clicking on proceed, you agree to our \n',
                              style: TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy policy ',
                              style: TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'and ',
                              style: TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms and conditions',
                              style: TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          if (authProvider.loginFormKey.currentState!.validate()) {
                            authProvider.loginWithPhone(context,authProvider.phoneNumberController.text,authProvider.selectedCountryCode);
                          }
                        },
                        child: Container(
                          width: screenSize.width,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: ShapeDecoration(
                            color: AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Center(
                            child: Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
