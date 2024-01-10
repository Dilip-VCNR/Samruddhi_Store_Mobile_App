import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/auth/provider/auth_provider.dart';
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
    return Consumer(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.registerScreenContext = context;
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
                        InkWell(
                          onTap: () {
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
                                            const Text("Select Zone",
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
                                              itemCount: authProvider.storeZoneList!.result!.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return InkWell(
                                                  onTap: () async {
                                                    authProvider.selectedZone = authProvider.storeZoneList!.result![index].name;
                                                    await authProvider.getHubOnZone();
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
                                                          authProvider.storeZoneList!.result![index].name!,
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
                                authProvider.selectedZoneController.text = authProvider.selectedZone!;
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
                                        return 'Please select valid Zone';
                                      }
                                      // if (authController.isNotValidPhone(value)) {
                                      //   return "Please enter valid phone number";
                                      // }
                                      return null;
                                    },
                                    controller: authProvider.selectedZoneController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    decoration: const InputDecoration(
                                        hintText: 'Zone',
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
                                  controller: authProvider.storeEmailController,
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
                        InkWell(
                          onTap: () {
                            List<String> isHeadquartersList = [
                              "Yes",
                              "No",
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
                                            const Text("Is this a headquarter?",
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
                                              itemCount: isHeadquartersList.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    authProvider.isHeadquarters =
                                                    isHeadquartersList[index];
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
                                                          isHeadquartersList[index],
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
                                authProvider.isHeadquartersController.text = authProvider.isHeadquarters!;
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
                                const Icon(Icons.store),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    enabled: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please select valid store type';
                                      }
                                      // if (authController.isNotValidPhone(value)) {
                                      //   return "Please enter valid phone number";
                                      // }
                                      return null;
                                    },
                                    controller: authProvider.isHeadquartersController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        hintText: 'Headquarter',
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
                                            const Text("Select Store Category",
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
                                              itemCount: authProvider.storeCategoryList!.result!.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    authProvider.selectedCategory =
                                                        authProvider.storeCategoryList!.result![index].storeCategoryName;
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
                                                          authProvider.storeCategoryList!.result![index].storeCategoryName!,
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
                              if(authProvider.selectedCategory!=null){
                                setState(() {
                                  authProvider.categoryController.text = authProvider.selectedCategory!;
                                });
                              }
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
                            List<String> homeDelivery = [
                              "Yes",
                              "No",
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
                                            const Text("Home Delivery ?",
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
                                              itemCount: homeDelivery.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    authProvider.isHomeDelivery =
                                                    homeDelivery[index];
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
                                                          homeDelivery[index],
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
                                authProvider.homeDeliveryTypeController.text = authProvider.isHomeDelivery!;
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
                                    controller: authProvider.homeDeliveryTypeController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    decoration: const InputDecoration(
                                        hintText: 'Home Delivery ?',
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
                        authProvider.homeDeliveryTypeController.text=='Yes'?InkWell(
                          onTap: () {
                            List<String> deliveryType = [
                              "Hub Delivery",
                              "Self Delivery",
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
                                              itemCount: deliveryType.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    authProvider.deliveryType =
                                                    deliveryType[index];
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
                                                          deliveryType[index],
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
                                authProvider.deliveryTypeController.text = authProvider.deliveryType!;
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
                        ):const SizedBox(),
                        authProvider.homeDeliveryTypeController.text=='Yes' && authProvider.deliveryTypeController.text == 'Hub Delivery'?InkWell(
                          onTap: () {
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
                                            const Text("Select Hub",
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
                                              itemCount: authProvider.hubList!=null?authProvider.hubList!.result!.length:0,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    authProvider.selectedHubUuid = authProvider.hubList!.result![index].hubUuid;
                                                    authProvider.selectedHubName = authProvider.hubList!.result![index].hubName;
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
                                                          authProvider.hubList!.result![index].hubName!,
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
                                  if(authProvider.selectedCategory!=null){
                                    setState(() {
                                      authProvider.hubController.text = authProvider.selectedHubName!;
                                    });
                                  }
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
                                          return 'Please select valid Hub';
                                        }
                                        // if (authController.isNotValidPhone(value)) {
                                        //   return "Please enter valid phone number";
                                        // }
                                        return null;
                                      },
                                      controller: authProvider.hubController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      decoration: const InputDecoration(
                                          hintText: 'Delivery Hub',
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
                        ):const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (authProvider.registerFormKey.currentState!.validate()) {
                              // if (!authProvider.termsAndConditionsIsChecked) {
                              //   showErrorToast(context, "Please agree to terms and conditions and privacy policy");
                              //   return;
                              // }
                              await authProvider.getApproxLocation();
                              // if (context.mounted) {
                              //   Navigator.pushNamed(context, Routes.markLocationRoute,
                              // arguments: {
                              //   'name': authProvider.nameController.text,
                              //   'email': authProvider.emailController.text,
                              //   'storeReferralCode': authProvider.storeReferralCodeController.text,
                              //   'operatorCode': authProvider.operatorCodeController.text,
                              //   'cableSubscriberId': authProvider.cableSubscriberIdController.text,
                              //   "currentLocation": currentPosition
                              // }
                              // );
                              // }
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
