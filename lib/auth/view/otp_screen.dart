import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:samruddhi_store/auth/controller/auth_controller.dart';
import 'package:samruddhi_store/utils/app_colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Image(image: AssetImage('assets/images/otp_bg.png'))),
              const SizedBox(height: 20,),
              const Text(
                'Enter the Verifcation code',
                style: TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'We have sent a verification code to \n+91 98765432221',
                style: TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20,),
              OTPTextField(
                length: 5,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                fieldWidth: 50,
                style: const TextStyle(
                    fontSize: 17
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {},
              ),
              const SizedBox(height: 20,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Resend OTP',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Change Phone Number',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xB737474F),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  authController.validateOtp(context);
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
        ),
      ),
    );
  }
}
