import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/auth/provider/auth_provider.dart';
import 'package:samruddhi_store/utils/app_colors.dart';
import 'package:samruddhi_store/utils/app_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool firstTimeLoading = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder:
          (BuildContext context, AuthProvider authProvider, Widget? child) {
        if (firstTimeLoading != true) {
          authProvider.clearRegisterForm();
          firstTimeLoading = true;
        }
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
                const SizedBox(
                  height: 15,
                ),
                Form(
                    key: authProvider.registerFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter valid store name';
                            }
                            if (authProvider.isNotValidName(value.trim())) {
                              return "Please enter valid store name";
                            }
                            return null;
                          },
                          maxLength: 75,
                          controller: authProvider.storeNameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.store),
                            focusedBorder: OutlineInputBorder(
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter Store display name';
                            }
                            if (authProvider.isNotValidName(value.trim())) {
                              return "Please enter valid display name";
                            }
                            return null;
                          },
                          controller: authProvider.storeDisplayNameController,
                          keyboardType: TextInputType.text,
                          maxLength: 75,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.store),
                            focusedBorder: OutlineInputBorder(
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          // textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid email';
                            }
                            if (authProvider.isNotValidEmail(value)) {
                              return "Please enter valid email";
                            }
                            return null;
                          },
                          controller: authProvider.storeEmailController,
                          keyboardType: TextInputType.text,
                          // maxLength: 10,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            focusedBorder: OutlineInputBorder(
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
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
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
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                              itemCount: authProvider
                                                  .storeZoneList!
                                                  .result!
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: () async {
                                                    authProvider.selectedZone =
                                                        authProvider
                                                            .storeZoneList!
                                                            .result![index]
                                                            .name;
                                                    await authProvider
                                                        .getHubOnZone();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        child: Text(
                                                          authProvider
                                                              .storeZoneList!
                                                              .result![index]
                                                              .name!,
                                                          style:
                                                              const TextStyle(
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
                                authProvider.selectedZoneController.text =
                                    authProvider.selectedZone!;
                              });
                            });
                          },
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textCapitalization: TextCapitalization.sentences,
                            enabled: false,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
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
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.my_location),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Zone',
                              hintText: 'Zone',
                              counterText: "",
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
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
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                              itemCount:
                                                  isHeadquartersList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    authProvider
                                                            .isHeadquarters =
                                                        isHeadquartersList[
                                                            index];
                                                    Navigator.pop(context);
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        child: Text(
                                                          isHeadquartersList[
                                                              index],
                                                          style:
                                                              const TextStyle(
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
                                authProvider.isHeadquartersController.text =
                                    authProvider.isHeadquarters!;
                              });
                            });
                          },
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textCapitalization: TextCapitalization.sentences,
                            enabled: false,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Is the store a headquarter";
                              }

                              return null;
                            },
                            controller: authProvider.isHeadquartersController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.view_headline_rounded),
                              suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Headquarter',
                              hintText: 'Headquarter',
                              counterText: "",
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          controller: authProvider.gstController,
                          keyboardType: TextInputType.text,
                          maxLength: 15,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.sticky_note_2_sharp),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Gst number',
                            counterText: "",
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          controller: authProvider.deliveryFeeController,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.delivery_dining_outlined),
                            focusedBorder: OutlineInputBorder(
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter valid commission percentage';
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
                          controller: authProvider.storeCommissionController,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.attach_money_rounded),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            labelText: 'Store commission %',
                            hintText: 'Store commission %',
                            counterText: "",
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
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
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(Icons.close))
                                          ],
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: authProvider
                                                .storeCategoryList!
                                                .result!
                                                .length,
                                            itemBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return InkWell(
                                                onTap: () {
                                                  authProvider
                                                          .selectedCategory =
                                                      authProvider
                                                          .storeCategoryList!
                                                          .result![index]
                                                          .storeCategoryName;
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10),
                                                      child: Text(
                                                        authProvider
                                                            .storeCategoryList!
                                                            .result![index]
                                                            .storeCategoryName!,
                                                        style:
                                                            const TextStyle(
                                                                fontSize: 18),
                                                      ),
                                                    ),
                                                    const Divider()
                                                  ],
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  );
                                }).then((value) {
                              if (authProvider.selectedCategory != null) {
                                setState(() {
                                  authProvider.categoryController.text =
                                      authProvider.selectedCategory!;
                                });
                              }
                            });
                          },
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textCapitalization: TextCapitalization.sentences,
                            enabled: false,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
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
                            decoration: InputDecoration(
                              suffixIcon:
                                  const Icon(Icons.keyboard_arrow_down_sharp),
                              prefixIcon: const Icon(Icons.category),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Store category',
                              hintText: 'Store category',
                              counterText: "",
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
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
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    authProvider
                                                            .isHomeDelivery =
                                                        homeDelivery[index];
                                                    Navigator.pop(context);
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        child: Text(
                                                          homeDelivery[index],
                                                          style:
                                                              const TextStyle(
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
                                authProvider.isHomeDeliveryController.text =
                                    authProvider.isHomeDelivery!;
                              });
                            });
                          },
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textCapitalization: TextCapitalization.sentences,
                            enabled: false,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please select valid delivery type';
                              }
                              // if (authController.isNotValidPhone(value)) {
                              //   return "Please enter valid phone number";
                              // }
                              return null;
                            },
                            controller: authProvider.isHomeDeliveryController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                              prefixIcon:
                                  const Icon(Icons.delivery_dining_outlined),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Home delivery',
                              hintText: 'Home delivery',
                              counterText: "",
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        authProvider.isHomeDeliveryController.text == 'Yes'
                            ? InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();

                                  List<String> deliveryType = [
                                    "Hub Delivery",
                                    "Store Delivery",
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                      "Select Delivery Method Type",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                          Icons.close))
                                                ],
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        deliveryType.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          authProvider
                                                                  .deliveryType =
                                                              deliveryType[
                                                                  index];
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: Text(
                                                                deliveryType[
                                                                    index],
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            18),
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
                                      authProvider.deliveryMethodController
                                          .text = authProvider.deliveryType!;
                                    });
                                  });
                                },
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  enabled: false,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Please select valid delivery method';
                                    }
                                    // if (authController.isNotValidPhone(value)) {
                                    //   return "Please enter valid phone number";
                                    // }
                                    return null;
                                  },
                                  controller:
                                      authProvider.deliveryMethodController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                        Icons.delivery_dining_outlined),
                                    prefixIcon: const Icon(Icons.category),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    labelText: 'Delivery method',
                                    hintText: 'Delivery method',
                                    counterText: "",
                                    isCollapsed: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 15,
                        ),
                        authProvider.isHomeDeliveryController.text == 'Yes' &&
                                authProvider.deliveryMethodController.text ==
                                    'Hub Delivery'
                            ? InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Select Hub",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                          Icons.close))
                                                ],
                                              ),
                                              authProvider.hubList!.result!
                                                      .isNotEmpty
                                                  ? Expanded(
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: authProvider
                                                                      .hubList !=
                                                                  null
                                                              ? authProvider
                                                                  .hubList!
                                                                  .result!
                                                                  .length
                                                              : 0,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                authProvider
                                                                        .selectedHubUuid =
                                                                    authProvider
                                                                        .hubList!
                                                                        .result![
                                                                            index]
                                                                        .hubUuid;
                                                                authProvider
                                                                        .selectedHubName =
                                                                    authProvider
                                                                        .hubList!
                                                                        .result![
                                                                            index]
                                                                        .hubName;
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            10),
                                                                    child: Text(
                                                                      authProvider
                                                                          .hubList!
                                                                          .result![
                                                                              index]
                                                                          .hubName!,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                  const Divider()
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    )
                                                  : Center(
                                                      child: Text(
                                                          "No hub found for selected zone"),
                                                    ),
                                            ],
                                          ),
                                        );
                                      }).then((value) {
                                    if (authProvider.selectedCategory != null) {
                                      setState(() {
                                        authProvider.hubController.text =
                                            authProvider.selectedHubName!;
                                      });
                                    }
                                  });
                                },
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  enabled: false,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
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
                                  decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                        Icons.delivery_dining_outlined),
                                    prefixIcon: const Icon(Icons.category),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    labelText: 'Delivery Hub',
                                    hintText: 'Delivery Hub',
                                    counterText: "",
                                    isCollapsed: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (authProvider.registerFormKey.currentState!
                                .validate()) {
                              if (authProvider.selectedImage == null) {
                                showErrorToast(context,
                                    "Please select an image to proceed");
                                return;
                              }
                              // if (!authProvider.termsAndConditionsIsChecked) {
                              //   showErrorToast(context, "Please agree to terms and conditions and privacy policy");
                              //   return;
                              // }
                              await authProvider.getApproxLocation();
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
