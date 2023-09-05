import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:samruddhi_store/auth/controller/auth_controller.dart';
import 'package:samruddhi_store/utils/app_colors.dart';
import 'package:samruddhi_store/utils/app_widgets.dart';

import '../../utils/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedCategory;
  String? selectedDeliveryType;

  TextEditingController categoryController = TextEditingController();
  TextEditingController deliveryTypeController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeMailController = TextEditingController();
  TextEditingController storeDisplayNameController = TextEditingController();
  TextEditingController gstController = TextEditingController();

  AuthController authController = AuthController();
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
            Form(
                key: _formKey,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid store name';
                                }
                                // if (authController.isNotValidPhone(value)) {
                                //   return "Please enter valid phone number";
                                // }
                                return null;
                              },
                              controller: storeNameController,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid email';
                                }
                                // if (authController.isNotValidPhone(value)) {
                                //   return "Please enter valid phone number";
                                // }
                                return null;
                              },
                              controller: storeMailController,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Store display name';
                                }
                                // if (authController.isNotValidPhone(value)) {
                                //   return "Please enter valid phone number";
                                // }
                                return null;
                              },
                              controller: storeDisplayNameController,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid gst';
                                }
                                // if (authController.isNotValidPhone(value)) {
                                //   return "Please enter valid phone number";
                                // }
                                return null;
                              },
                              controller: gstController,
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
                          "Grocery",
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
                                                selectedCategory =
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
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Divider()
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
                            categoryController.text = selectedCategory!;
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
                                  controller: categoryController,
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
                                                selectedDeliveryType =
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
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Divider()
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
                            deliveryTypeController.text = selectedDeliveryType!;
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
                                controller: deliveryTypeController,
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
                        if (_formKey.currentState!.validate()) {
                          showLoaderDialog(context);

                          Position currentPosition;
                          try {
                            currentPosition = await authController.getCurrentLocation();
                          } catch (e) {
                            currentPosition = const Position(
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
                                arguments: {
                                  "currentLocation":currentPosition,
                                  "storeName": storeNameController.text,
                                  "storeMail":storeMailController.text,
                                  "storeDisplayName":storeDisplayNameController.text,
                                  "gst":gstController.text,
                                  "categoryType":categoryController.text,
                                  "deliveryType":deliveryTypeController.text,
                                });
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
  }
}
