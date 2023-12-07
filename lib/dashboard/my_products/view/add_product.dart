import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import '../provider/products_provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

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
    return Consumer<ProductProvider>(
      builder: (BuildContext context, ProductProvider productProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add product"),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20,),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: getImageFromGallery,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 55,
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
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: productProvider.productFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: productProvider.productNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product name',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          List<String> categories = [
                            "Grocery",
                            "Dairy",
                            "Stationary",
                            "Meat",
                            "Beverages",
                            "Footwears"
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
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return InkWell(
                                                onTap: () {
                                                  productProvider.productCategoryController.text =
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
                                                          .symmetric(vertical: 10),
                                                      child: Text(
                                                        categories[index],
                                                        style:
                                                        const TextStyle(fontSize: 18),
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
                            setState(() {});
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller: productProvider.productCategoryController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select category';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                            hintText: 'Select product category',
                            counterText: "",
                            isCollapsed: true,
                            filled: true,
                            fillColor: AppColors.inputFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          List<String> subCategories = [
                            "Grocery",
                            "Dairy",
                            "Shoes",
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
                                          const Text("Select Sub Category",
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
                                            itemCount: subCategories.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return InkWell(
                                                onTap: () {
                                                  productProvider.productSubCategoryController
                                                      .text = subCategories[index];
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
                                                          .symmetric(vertical: 10),
                                                      child: Text(
                                                        subCategories[index],
                                                        style:
                                                        const TextStyle(fontSize: 18),
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
                            setState(() {});
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          controller: productProvider.productSubCategoryController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select sub category';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                            hintText: 'Select product sub category',
                            counterText: "",
                            isCollapsed: true,
                            filled: true,
                            fillColor: AppColors.inputFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: productProvider.productMrpController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product mrp';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product Mrp',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: productProvider.productDiscountController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product discount';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product discount',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: productProvider.productOfferController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product offer';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product offer',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: productProvider.productTaxController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product tax';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product tax',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: productProvider.productHSNController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter HSN code';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product HSN code',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: productProvider.productSellingPriceController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product Selling Price';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product Selling price',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: productProvider.productModelController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Model';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product Model',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: productProvider.productManufacturerController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Manufacturer';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product Manufacturer',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: productProvider.productQuantityController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Quantity';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product Quantity',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      GestureDetector(
                        onTap: () {
                          List<String> colorTypes = [
                            "Green",
                            "White",
                            "Orange",
                            "Black",
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
                                          const Text("Select Color",
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
                                            itemCount: colorTypes.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return InkWell(
                                                onTap: () {
                                                  productProvider.productColorController.text =
                                                  colorTypes[index];
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
                                                          .symmetric(vertical: 10),
                                                      child: Text(
                                                        colorTypes[index],
                                                        style:
                                                        const TextStyle(fontSize: 18),
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
                            setState(() {});
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller: productProvider.productColorController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select color';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                            hintText: 'Select product color',
                            counterText: "",
                            isCollapsed: true,
                            filled: true,
                            fillColor: AppColors.inputFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),

                      const SizedBox(height: 10,),


                      GestureDetector(
                        onTap: () {
                          List<String> qualityTypes = [
                          "10",
                            "20",
                            "30",
                            "40",
                            "50",
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
                                          const Text("Select Quality",
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
                                            itemCount: qualityTypes.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return InkWell(
                                                onTap: () {
                                                  productProvider.productQualityController.text =
                                                  qualityTypes[index];
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
                                                          .symmetric(vertical: 10),
                                                      child: Text(
                                                        qualityTypes[index],
                                                        style:
                                                        const TextStyle(fontSize: 18),
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
                            setState(() {});
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller: productProvider.productQualityController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select quality';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                            hintText: 'Select product quality',
                            counterText: "",
                            isCollapsed: true,
                            filled: true,
                            fillColor: AppColors.inputFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          List<String> sizeTypes = [
                            "Small",
                            "Medium",
                            "Large",
                            "Extra Large",
                            "XXL",
                            "XXXL",
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
                                            itemCount: sizeTypes.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return InkWell(
                                                onTap: () {
                                                  productProvider.productSizeController.text =
                                                  sizeTypes[index];
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
                                                          .symmetric(vertical: 10),
                                                      child: Text(
                                                        sizeTypes[index],
                                                        style:
                                                        const TextStyle(fontSize: 18),
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
                            setState(() {});
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller: productProvider.productSizeController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select size';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                            hintText: 'Select product size',
                            counterText: "",
                            isCollapsed: true,
                            filled: true,
                            fillColor: AppColors.inputFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                      const SizedBox(height:10),
                      GestureDetector(
                        onTap: () {
                          List<String> sizeTypes = [
                            "Single",
                            "Pair",
                            "250 gram",
                            "500 gram",
                            "1 Kg"
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
                                          const Text("Select UOM",
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
                                            itemCount: sizeTypes.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return InkWell(
                                                onTap: () {
                                                  productProvider.productUOMController.text =
                                                  sizeTypes[index];
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
                                                          .symmetric(vertical: 10),
                                                      child: Text(
                                                        sizeTypes[index],
                                                        style:
                                                        const TextStyle(fontSize: 18),
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
                            setState(() {});
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller: productProvider.productUOMController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select UOM';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
                            hintText: 'Select product UOM',
                            counterText: "",
                            isCollapsed: true,
                            filled: true,
                            fillColor: AppColors.inputFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),

                      const SizedBox(height:10),

                      TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: productProvider.productDescriptionController,
                    validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                    maxLines: 4,
                    decoration: InputDecoration(
                    hintText: 'Product Description',
                    counterText: "",
                    isCollapsed: true,
                    filled: true,
                    fillColor: AppColors.inputFieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 10),
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    ),
                      const SizedBox(
                        height: 20,
                      ),

                      InkWell(
                        onTap: () async {
                          if (productProvider.productFormKey.currentState!.validate()) {
                            productProvider.addNewProduct(context);
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

