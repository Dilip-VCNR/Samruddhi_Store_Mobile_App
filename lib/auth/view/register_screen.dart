import 'package:flutter/material.dart';
import 'package:samruddhi_store/utils/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Information"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            const Text(
              'It looks like you don’t have account in this number. Please let us know some information for a setting up your store with samruddhi',
              style: TextStyle(
                color: AppColors.fontColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                ),
                Positioned(
                    bottom: 2,
                    right: 2,
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              size: 15,
                            ),
                            color: Colors.black)))
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: screenSize.width,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person_2_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter valid store name';
                        }
                        // if (authController.isNotValidPhone(value)) {
                        //   return "Please enter valid phone number";
                        // }
                        return null;
                      },
                      // controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: const InputDecoration(
                          hintText: 'Store name',
                          counterText: "",
                          isCollapsed: true,
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: screenSize.width,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.email_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter valid email';
                        }
                        // if (authController.isNotValidPhone(value)) {
                        //   return "Please enter valid phone number";
                        // }
                        return null;
                      },
                      // controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          counterText: "",
                          isCollapsed: true,
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
