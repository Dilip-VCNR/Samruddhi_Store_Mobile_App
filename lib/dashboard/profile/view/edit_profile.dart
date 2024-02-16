import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/provider/auth_provider.dart';
import '../../../utils/app_colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder:
          (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.editProfileScreenContext = context;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: authProvider.getImageFromGallery,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        backgroundImage: authProvider.selectedImage != null
                            ? FileImage(authProvider.selectedImage!)
                            : null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Positioned(
                          bottom: 2,
                          right: 2,
                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey.shade400,
                              child: IconButton(
                                  onPressed: authProvider.getImageFromGallery,
                                  icon: const Icon(
                                    Icons.file_upload_outlined,
                                    size: 15,
                                  ),
                                  color: Colors.black)))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                    key: authProvider.registerFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter valid store name';
                            }
                            // if (authController.isNotValidPhone(value)) {
                            //   return "Please enter valid phone number";
                            // }
                            return null;
                          },
                          controller: authProvider.editStoreNameController,
                          keyboardType: TextInputType.text,
                          // maxLength: 10,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.store),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Store name',
                            hintText: 'Store name',
                            counterText: "",
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter Store display name';
                            }
                            // if (authController.isNotValidPhone(value)) {
                            //   return "Please enter valid phone number";
                            // }
                            return null;
                          },
                          controller:
                              authProvider.editStoreDisplayNameController,
                          keyboardType: TextInputType.text,
                          maxLength: 24,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.store),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Display name',
                            hintText: 'Display name',
                            counterText: "",
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter valid email';
                            }
                            // if (authController.isNotValidPhone(value)) {
                            //   return "Please enter valid phone number";
                            // }
                            return null;
                          },
                          controller: authProvider.editStoreEmailController,
                          keyboardType: TextInputType.text,
                          // maxLength: 10,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Email',
                            hintText: 'Email',
                            counterText: "",
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter valid gst number';
                            }
                            // if (authController.isNotValidPhone(value)) {
                            //   return "Please enter valid phone number";
                            // }
                            return null;
                          },
                          controller: authProvider.editGstController,
                          keyboardType: TextInputType.text,
                          maxLength: 15,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.sticky_note_2_sharp),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Gst number',
                            hintText: 'Gst number',
                            counterText: "",
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter valid delivery fee';
                            }
                            RegExp regex = RegExp(r'^[0-9.]+$');
                            if (!regex.hasMatch(value)) {
                              return 'Special characters are not allowed';
                            }
                            // if (authController.isNotValidPhone(value)) {
                            //   return "Please enter valid phone number";
                            // }
                            return null;
                          },
                          controller: authProvider.editDeliveryFeeController,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.delivery_dining_outlined),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Delivery fee',
                            hintText: 'Delivery fee',
                            counterText: "",
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // TextFormField(
                        //   textCapitalization: TextCapitalization.sentences,
                        //   textInputAction: TextInputAction.done,
                        //   validator: (value) {
                        //     if (value!.trim().isEmpty) {
                        //       return 'Please enter valid commission percentage';
                        //     }
                        //     // if (authController.isNotValidPhone(value)) {
                        //     //   return "Please enter valid phone number";
                        //     // }
                        //     return null;
                        //   },
                        //   controller:
                        //       authProvider.editStoreCommissionController,
                        //   keyboardType: TextInputType.text,
                        //   maxLength: 15,
                        //   decoration: InputDecoration(
                        //     prefixIcon: const Icon(Icons.attach_money_rounded),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: const BorderSide(
                        //           color: Colors.black),
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     border: OutlineInputBorder(
                        //       borderSide: const BorderSide(
                        //           color: Colors.black, width: 2),
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     labelText: 'Store commission %',
                        //     hintText: 'Store commission %',
                        //     counterText: "",
                        //     isCollapsed: true,
                        //     contentPadding: const EdgeInsets.symmetric(
                        //         vertical: 15, horizontal: 10),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (authProvider.registerFormKey.currentState!
                                .validate()) {
                              await authProvider.updateProfile();
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
                                'Proceed',
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
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
