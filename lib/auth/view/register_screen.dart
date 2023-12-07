import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/auth/model/register_store_request_model.dart';
import 'package:samruddhi_store/auth/provider/auth_provider.dart';
import 'package:samruddhi_store/utils/app_colors.dart';
import 'package:samruddhi_store/utils/app_widgets.dart';

import '../../utils/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _selectedImage;

  Future<void> getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: getImageFromGallery,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.purple.shade50,
                                backgroundImage: _selectedImage != null
                                    ? FileImage(_selectedImage!)
                                    : null,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Positioned(
                                  bottom: 2,
                                  right: 3,
                                  child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.grey.shade400,
                                      child: IconButton(
                                          onPressed: () {
                                            getImageFromGallery();
                                          },
                                          icon: const Icon(
                                            Icons.file_upload_outlined,
                                            size: 15,
                                          ),
                                          color: Colors.black)))
                            ], ))
                    ],
                  ),
                ),
              Form(
                    key:authProvider.registerFormKey,
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
                                  controller: authProvider.storeNameController,
                                  keyboardType: TextInputType.text,
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
                                  controller: authProvider.storeMailController,
                                  keyboardType: TextInputType.text,
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
                                  controller: authProvider.storeDisplayNameController,
                                  keyboardType: TextInputType.text,
                                  maxLength: 10,
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
                              const Icon(Icons.receipt),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter valid gst';
                                    }
                                    // if (authController.isNotValidPhone(value)) {
                                    //   return "Please enter valid phone number";
                                    // }
                                    return null;
                                  },
                                  controller: authProvider.gstController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: const InputDecoration(
                                      hintText: 'GST %',
                                      counterText: "",
                                      isCollapsed: true,
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            List<String> categories = [
                              "Grocery"
                              "Dairy",
                              "Stationary",
                              "Meat",
                              "Beverages"
                            ];
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Select Category",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold)),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(Icons.close))
                                          ],
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: categories.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    authProvider.selectedCategory =
                                                    categories[index];
                                                    Navigator.pop(context);
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 10),
                                                        child: Text(
                                                          categories[index],
                                                          style: const TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      const Divider()
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  );
                                }).then((value) {
                              setState(() {
                                authProvider.categoryController.text = authProvider.selectedCategory!;
                              });
                            });
                          },
                          child: InkWell(
                            child: Container(
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
                                  const Icon(Icons.category),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      enabled: false,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please select valid category';
                                        }
                                        // if (authController.isNotValidPhone(value)) {
                                        //   return "Please enter valid phone number";
                                        // }
                                        return null;
                                      },
                                      controller: authProvider.categoryController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      decoration: const InputDecoration(
                                          hintText: 'Store Category',
                                          counterText: "",
                                          isCollapsed: true,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            List<String> deliveryTypes = [
                              "Self Delivery",
                              "Delivery by samruddhi",
                              "No delivery (Pick up only)",
                            ];
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Select Delivery Type",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold)),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(Icons.close))
                                          ],
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: deliveryTypes.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    authProvider.selectedDeliveryType =
                                                    deliveryTypes[index];
                                                    Navigator.pop(context);
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 10),
                                                        child: Text(
                                                          deliveryTypes[index],
                                                          style: const TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      const Divider()
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  );
                                }).then((value) {
                              setState(() {
                                authProvider.deliveryTypeController.text = authProvider.selectedDeliveryType!;
                              });
                            });
                          },
                          child: Container(
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
                                const Icon(Icons.delivery_dining),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    enabled: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please select valid delivery type';
                                      }
                                      // if (authController.isNotValidPhone(value)) {
                                      //   return "Please enter valid phone number";
                                      // }
                                      return null;
                                    },
                                    controller: authProvider.deliveryTypeController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    decoration: const InputDecoration(
                                        hintText: 'Delivery Type',
                                        counterText: "",
                                        isCollapsed: true,
                                        border: InputBorder.none),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            if (authProvider.registerFormKey.currentState!.validate()) {
                              showLoaderDialog(context);

                              try {
                                authProvider.currentPosition = await authProvider.getCurrentLocation();
                              } catch (e) {
                                authProvider.currentPosition = const Position(
                                  latitude: 10.1632,
                                  longitude: 76.6413,
                                  timestamp: null,
                                  accuracy: 100,
                                  altitude: 0,
                                  heading: 0,
                                  speed: 0,
                                  speedAccuracy: 0,
                                );
                              }
                              if(context.mounted){
                                Navigator.pop(context);
                                Navigator.pushNamed(context, Routes.markLocationRoute,
                                    // arguments: {
                                    //   // "currentLocation":currentPosition,
                                    //   // "reqData":reqData
                                    // }
                                    );
                              }
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