import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/auth/provider/auth_provider.dart';
import 'package:samruddhi_store/utils/app_colors.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return Consumer(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.otpScreenContext = context;
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
                  Text(
                    'We have sent a verification code to \n${authProvider.selectedCountryCode} ${authProvider.phoneNumberController.text}',
                    style: const TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  PinFieldAutoFill(
                    enabled: true,
                    currentCode: authProvider.otpCode,
                    decoration: BoxLooseDecoration(
                        radius: const Radius.circular(12),
                        strokeColorBuilder:
                        const FixedColorBuilder(AppColors.fontColor)),
                    codeLength: 6,
                    onCodeChanged: (code) {
                      authProvider.otpCode = code.toString();
                    },
                    onCodeSubmitted: (val) {},
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (authProvider.firstStateEnabled) {
                            await authProvider.resendOtp();
                            setState(() {
                              authProvider.firstStateEnabled = false;
                              authProvider.countdownController.restart();
                            });
                          }
                        },
                        child: Countdown(
                          controller: authProvider.countdownController,
                          seconds: authProvider.seconds,
                          build: (context, time) => Text(
                            authProvider.firstStateEnabled
                                ? 'Resend'
                                : 'Resend OTP in ${time.round()}',
                            style: TextStyle(
                              color: authProvider.firstStateEnabled
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          interval: const Duration(seconds: 1),
                          onFinished: () {
                            setState(() {
                              authProvider.firstStateEnabled =
                              !authProvider.firstStateEnabled;
                            });
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          authProvider.clearFieldData();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Change Phone Number',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xB737474F),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      authProvider.verifyOtp();
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
      },
    );
  }
}
