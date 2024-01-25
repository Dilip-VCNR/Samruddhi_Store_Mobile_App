import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/dashboard/my_products/provider/products_provider.dart';

import '../../../utils/app_colors.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool? firstTimeLoading;
  DateTime? selectedDate;


  Future<void> selectDate(BuildContext context, ProductsProvider productsProvider) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now()
          .add(const Duration(days: 365)), // Limit to 30 days from now
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        productsProvider.editExpiryDateController.text=DateFormat("dd/MM/yyyy").format(
            DateTime.parse(selectedDate
                .toString()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, ProductsProvider productsProvider,
          Widget? child) {
        if (firstTimeLoading != true) {
          productsProvider.editProductScreenContext = context;
          productsProvider.getCategoriesDropDownData();
          firstTimeLoading = true;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Add product"),
          ),
          body: productsProvider.subCategoriesList != null
              ? SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: productsProvider.getImageFromGallery,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        backgroundImage: productsProvider.selectedImage !=
                            null
                            ? FileImage(productsProvider.selectedImage!)
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
                                  onPressed: productsProvider
                                      .getImageFromGallery,
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
                  key: productsProvider.addProductFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
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
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          const Text("Select Category",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon:
                                              const Icon(Icons.close))
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: productsProvider
                                                .categoriesList!
                                                .result!
                                                .length,
                                            itemBuilder:
                                                (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  productsProvider
                                                      .editProductCategoryController
                                                      .text =
                                                  productsProvider
                                                      .categoriesList!
                                                      .result![index]
                                                      .productCategoryName!;
                                                  Navigator.pop(context);
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
                                                        productsProvider
                                                            .categoriesList!
                                                            .result![
                                                        index]
                                                            .productCategoryName!,
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
                            setState(() {});
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller:
                          productsProvider.editProductCategoryController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select category';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_sharp),
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
                                              "Select Sub Category",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon:
                                              const Icon(Icons.close))
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: productsProvider
                                                .subCategoriesList!
                                                .result!
                                                .length,
                                            itemBuilder:
                                                (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  productsProvider
                                                      .editProductSubCategoryController
                                                      .text =
                                                  productsProvider
                                                      .subCategoriesList!
                                                      .result![index]
                                                      .productSubCategoryName!;
                                                  Navigator.pop(context);
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
                                                        productsProvider
                                                            .subCategoriesList!
                                                            .result![
                                                        index]
                                                            .productSubCategoryName!,
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
                            setState(() {});
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller: productsProvider
                              .editProductSubCategoryController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select sub category';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_sharp),
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
                      const SizedBox(height: 10,),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: productsProvider.editProductSkuController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product sku';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product SKU',
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
                        controller:
                        productsProvider.editProductNameController,
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
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller:
                        productsProvider.editProductQuantityController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product quantity';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Product quantity',
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
                        maxLines: 3,
                        minLines: 3,
                        textInputAction: TextInputAction.next,
                        controller:
                        productsProvider.editProductDescriptionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product description',
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
                          List<String> productUom = [
                            "KG",
                            "Piece",
                            "Litres",
                            "Metres",
                            "Centimeters",
                            "Inch"
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
                                          const Text("Select UOM",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon:
                                              const Icon(Icons.close))
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: productUom.length,
                                            itemBuilder:
                                                (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  productsProvider
                                                      .editProductUomController
                                                      .text =
                                                  productUom[index];
                                                  Navigator.pop(context);
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
                                                        productUom[index],
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
                            setState(() {});
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller:
                          productsProvider.editProductUomController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select UOM';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_sharp),
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
                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: productsProvider
                            .editProductSellingPriceController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product selling price';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Product selling price',
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
                        controller:
                        productsProvider.editProductDiscountController,
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
                        controller: productsProvider.editProductTaxController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product tax';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product tax %',
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
                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   textInputAction: TextInputAction.next,
                      //   controller:
                      //       productsProvider.productOfferController,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please enter product offer';
                      //     }
                      //     return null;
                      //   },
                      //   decoration: InputDecoration(
                      //     hintText: 'Product offer',
                      //     counterText: "",
                      //     isCollapsed: true,
                      //     filled: true,
                      //     fillColor: AppColors.inputFieldColor,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 16.0, horizontal: 10),
                      //   ),
                      //   textAlignVertical: TextAlignVertical.center,
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   textInputAction: TextInputAction.next,
                      //   controller:
                      //       productsProvider.productMinQtyController,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please enter product minimum purchase quantity';
                      //     }
                      //     return null;
                      //   },
                      //   decoration: InputDecoration(
                      //     hintText: 'Product minimum purchase quantity',
                      //     counterText: "",
                      //     isCollapsed: true,
                      //     filled: true,
                      //     fillColor: AppColors.inputFieldColor,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 16.0, horizontal: 10),
                      //   ),
                      //   textAlignVertical: TextAlignVertical.center,
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: productsProvider
                            .editProductManufacturerController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product manufacturer';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product manufacturer',
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
                        controller:
                        productsProvider.editProductModelController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter product model';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Product model',
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
                          List<String> returnableList = [
                            "Yes",
                            "No"
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
                                          const Text("Is it returnable ?",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon:
                                              const Icon(Icons.close))
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: returnableList.length,
                                            itemBuilder:
                                                (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  productsProvider
                                                      .editProductReturnController
                                                      .text =
                                                  returnableList[index];
                                                  Navigator.pop(context);
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
                                                        returnableList[index],
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
                            setState(() {});
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller:
                          productsProvider.editProductReturnController,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please select color';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_sharp),
                            hintText: 'Is it returnable ?',
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
                          List<String> productPerishable = [
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
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          const Text("Is product Perishable ?",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon:
                                              const Icon(Icons.close))
                                        ],
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                            productPerishable.length,
                                            itemBuilder:
                                                (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  productsProvider
                                                      .editProductPerishableController
                                                      .text =
                                                  productPerishable[index];
                                                  Navigator.pop(context);
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
                                                        productPerishable[
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
                            setState(() {});
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller:
                          productsProvider.editProductPerishableController,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please select quality';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_sharp),
                            hintText: 'Is it perishable ?',
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
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     List<String> sizeTypes = [
                      //       "Small",
                      //       "Medium",
                      //       "Large",
                      //       "Extra Large",
                      //       "XXL",
                      //       "XXXL",
                      //     ];
                      //     showModalBottomSheet(
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           return Padding(
                      //             padding: const EdgeInsets.all(20.0),
                      //             child: Column(
                      //               children: [
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment
                      //                           .spaceBetween,
                      //                   children: [
                      //                     const Text("Select Category",
                      //                         style: TextStyle(
                      //                             fontSize: 20,
                      //                             fontWeight:
                      //                                 FontWeight.bold)),
                      //                     IconButton(
                      //                         onPressed: () {
                      //                           Navigator.pop(context);
                      //                         },
                      //                         icon:
                      //                             const Icon(Icons.close))
                      //                   ],
                      //                 ),
                      //                 Expanded(
                      //                   child: ListView.builder(
                      //                       shrinkWrap: true,
                      //                       itemCount: sizeTypes.length,
                      //                       itemBuilder:
                      //                           (BuildContext context,
                      //                               int index) {
                      //                         return InkWell(
                      //                           onTap: () {
                      //                             productsProvider
                      //                                     .productSizeController
                      //                                     .text =
                      //                                 sizeTypes[index];
                      //                             Navigator.pop(context);
                      //                           },
                      //                           child: Column(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .start,
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment
                      //                                     .start,
                      //                             children: [
                      //                               Padding(
                      //                                 padding:
                      //                                     const EdgeInsets
                      //                                         .symmetric(
                      //                                         vertical:
                      //                                             10),
                      //                                 child: Text(
                      //                                   sizeTypes[index],
                      //                                   style:
                      //                                       const TextStyle(
                      //                                           fontSize:
                      //                                               18),
                      //                                 ),
                      //                               ),
                      //                               const Divider()
                      //                             ],
                      //                           ),
                      //                         );
                      //                       }),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         }).then((value) {
                      //       setState(() {});
                      //     });
                      //   },
                      //   child: TextFormField(
                      //     enabled: false,
                      //     controller:
                      //         productsProvider.productSizeController,
                      //     // validator: (value) {
                      //     //   if (value!.isEmpty) {
                      //     //     return 'Please select size';
                      //     //   }
                      //     //   return null;
                      //     // },
                      //     decoration: InputDecoration(
                      //       suffixIcon: const Icon(
                      //           Icons.keyboard_arrow_down_sharp),
                      //       hintText: 'Select product size',
                      //       counterText: "",
                      //       isCollapsed: true,
                      //       filled: true,
                      //       fillColor: AppColors.inputFieldColor,
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //         borderSide: BorderSide.none,
                      //       ),
                      //       contentPadding: const EdgeInsets.symmetric(
                      //           vertical: 16.0, horizontal: 10),
                      //     ),
                      //     textAlignVertical: TextAlignVertical.center,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => selectDate(context,productsProvider),
                        child: TextFormField(
                          enabled: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Select expiry date';
                            }
                            // if (authController.isNotValidName(value)) {
                            //   return "Please enter valid name";
                            // }
                            return null;
                          },
                          controller: productsProvider.editExpiryDateController,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.calendar_month_outlined,
                              color: AppColors.fontColor,
                            ),
                            hintText: 'Select expiry date',
                            counterText: "",
                            isCollapsed: true,
                            filled: true,
                            fillColor: AppColors.inputFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          if (productsProvider
                              .addProductFormKey.currentState!
                              .validate()) {
                            productsProvider.addNewProduct();
                          }
                        },
                        child: Container(
                          width: screenSize.width,
                          padding:
                          const EdgeInsets.symmetric(vertical: 16),
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
          )
              : const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
