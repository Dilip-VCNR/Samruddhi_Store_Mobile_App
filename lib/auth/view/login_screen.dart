import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:samruddhi_store/auth/controller/auth_controller.dart';
import 'package:samruddhi_store/utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedCountryCode = "+91";
  final _formKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: screenSize.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CountryCodePicker(
                          showFlag: true,
                          enabled: true,
                          onChanged: (element) {
                            selectedCountryCode = element.dialCode;
                          },
                          initialSelection: 'IN',
                          favorite: const ['+91', 'IN'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                        Form(
                          key: _formKey,
                          child: SizedBox(
                            width: screenSize.width / 1.75,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid phone number';
                                }
                                if (authController.isNotValidPhone(value)) {
                                  return "Please enter valid phone number";
                                }
                                return null;
                              },
                              controller: phoneNumberController,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              decoration: const InputDecoration(
                                  hintText: 'Phone Number',
                                  counterText: "",
                                  isCollapsed: true,
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      if (_formKey.currentState!.validate()) {
                        authController.loginWithPhone(context,phoneNumberController.text,selectedCountryCode);
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
  }
}
