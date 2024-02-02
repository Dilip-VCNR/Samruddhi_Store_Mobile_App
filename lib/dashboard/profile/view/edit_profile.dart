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
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
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
                const SizedBox(height: 10,),
                Form(
                    key: authProvider.registerFormKey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: screenSize.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
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
                                  textCapitalization: TextCapitalization.sentences,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.display_settings),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.sentences,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Store display name';
                                    }
                                    // if (authController.isNotValidPhone(value)) {
                                    //   return "Please enter valid phone number";
                                    // }
                                    return null;
                                  },
                                  controller: authProvider.editStoreDisplayNameController,
                                  keyboardType: TextInputType.text,
                                  maxLength: 24,
                                  decoration: const InputDecoration(
                                      hintText: 'Display name',
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
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
                                  textCapitalization: TextCapitalization.sentences,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
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
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: screenSize.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.receipt),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.sentences,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {
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
                                  decoration: const InputDecoration(
                                      hintText: 'GST Number',
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.delivery_dining_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.sentences,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter valid delivery fee';
                                    }
                                    // if (authController.isNotValidPhone(value)) {
                                    //   return "Please enter valid phone number";
                                    // }
                                    return null;
                                  },
                                  controller: authProvider.editDeliveryFeeController,
                                  keyboardType: TextInputType.text,
                                  maxLength: 15,
                                  decoration: const InputDecoration(
                                      hintText: 'Delivery fee controller',
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.delivery_dining_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.sentences,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter valid commission percentage';
                                    }
                                    // if (authController.isNotValidPhone(value)) {
                                    //   return "Please enter valid phone number";
                                    // }
                                    return null;
                                  },
                                  controller: authProvider.editStoreCommissionController,
                                  keyboardType: TextInputType.text,
                                  maxLength: 15,
                                  decoration: const InputDecoration(
                                      hintText: 'Store commission %',
                                      counterText: "",
                                      isCollapsed: true,
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (authProvider.registerFormKey.currentState!.validate()) {
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
