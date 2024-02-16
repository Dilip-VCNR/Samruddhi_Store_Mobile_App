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
        productsProvider.expiryDateController.text=DateFormat("dd/MM/yyyy").format(
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
            title: const Text("Edit Product"),
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
                        backgroundColor: Colors.grey.shade400,
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
                              backgroundColor: Colors.grey,
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
                                                      .productCategoryController
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
                          textCapitalization: TextCapitalization.sentences,

                          style: const TextStyle(color: Colors.black),
                          enabled: false,
                          controller:
                          productsProvider.productCategoryController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
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

                            fillColor: AppColors.inputFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),

                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),

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
                                                      .productSubCategoryController
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
                          textCapitalization: TextCapitalization.sentences,

                          style: const TextStyle(color: Colors.black),
                          enabled: false,
                          controller: productsProvider
                              .productSubCategoryController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
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

                            fillColor: AppColors.inputFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),

                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),

                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.next,
                        controller: productsProvider.productSkuController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product sku';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Product SKU",

                          hintText: 'Product SKU',
                          counterText: "",
                          isCollapsed: true,

                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

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
                        textCapitalization: TextCapitalization.sentences,

                        style: const TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.next,
                        controller:
                        productsProvider.productNameController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Product name',
                          hintText: 'Product name',
                          counterText: "",
                          isCollapsed: true,

                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

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
                        textCapitalization: TextCapitalization.sentences,

                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.black),
                        maxLines: 3,
                        minLines: 3,
                        textInputAction: TextInputAction.next,
                        controller:
                        productsProvider.productDescriptionController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Product description',
                          hintText: 'Product description',
                          counterText: "",
                          isCollapsed: true,

                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

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
                        textCapitalization: TextCapitalization.sentences,

                        style: const TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.next,
                        controller:
                        productsProvider.productQuantityController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product quantity';
                          }
                          if (int.parse(value)==0) {
                            return 'Should be greater than 1';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Product quantity",
                          hintText: 'Product quantity',
                          counterText: "",
                          isCollapsed: true,

                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

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
                                                      .productUomController
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
                          textCapitalization: TextCapitalization.sentences,

                          style: const TextStyle(color: Colors.black),
                          enabled: false,
                          controller:
                          productsProvider.productUomController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
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

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),

                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),

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
                        textCapitalization: TextCapitalization.sentences,

                        style: const TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.next,
                        controller: productsProvider
                            .productSellingPriceController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product selling price';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Product selling price",
                          hintText: 'Product selling price',
                          counterText: "",
                          isCollapsed: true,

                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
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
                        textCapitalization: TextCapitalization.sentences,

                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller:
                        productsProvider.productDiscountController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product discount';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Product discount',
                          hintText: 'Product discount',
                          counterText: "",
                          isCollapsed: true,

                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

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
                        textCapitalization: TextCapitalization.sentences,

                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: productsProvider.productTaxController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product tax';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Product tax %',
                          hintText: 'Product tax %',
                          counterText: "",
                          isCollapsed: true,

                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

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
                        textCapitalization: TextCapitalization.sentences,

                        style: const TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.next,
                        controller: productsProvider
                            .productManufacturerController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product manufacturer';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Product manufacturer',
                          hintText: 'Product manufacturer',
                          counterText: "",
                          isCollapsed: true,

                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

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
                        textCapitalization: TextCapitalization.sentences,

                        style: const TextStyle(color: Colors.black),

                        textInputAction: TextInputAction.next,
                        controller:
                        productsProvider.productHsnCodeController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product hsn';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Product hsn',
                          hintText: 'Product hsn',
                          counterText: "",
                          isCollapsed: true,

                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

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
                        textCapitalization: TextCapitalization.sentences,

                        style: const TextStyle(color: Colors.black),

                        textInputAction: TextInputAction.next,
                        controller:
                        productsProvider.productModelController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter product model';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Product model',
                          hintText: 'Product model',
                          counterText: "",
                          isCollapsed: true,

                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

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
                        onTap: () => selectDate(context,productsProvider),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          enabled: false,
                          validator: (value) {
                            // if (value!.trim().isEmpty) {
                            //   return 'Select expiry date';
                            // }
                            // if (authController.isNotValidName(value)) {
                            //   return "Please enter valid name";
                            // }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black),
                          controller: productsProvider.expiryDateController,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.calendar_month_outlined,
                              color: AppColors.fontColor,
                            ),
                            labelText: 'Select expiry date',
                            hintText: 'Select expiry date',
                            counterText: "",
                            isCollapsed: true,

                            fillColor: AppColors.inputFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),

                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Is it available now?"),
                          Switch(value: productsProvider.addProductAvailability, onChanged: (val){
                            setState(() {
                              productsProvider.addProductAvailability = !productsProvider.addProductAvailability;
                            });
                          })
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Is it returnable ?"),
                          Switch(value: productsProvider.addProductIsReturnable, onChanged: (val){
                            setState(() {
                              productsProvider.addProductIsReturnable = !productsProvider.addProductIsReturnable;
                            });
                          })
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Is it perishable ?"),
                          Switch(value: productsProvider.addProductIsPerishable, onChanged: (val){
                            setState(() {
                              productsProvider.addProductIsPerishable = !productsProvider.addProductIsPerishable;
                            });
                          })
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          if (productsProvider
                              .addProductFormKey.currentState!
                              .validate()) {
                            productsProvider.updateProduct();
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
