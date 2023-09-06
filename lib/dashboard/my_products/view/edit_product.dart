import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  TextEditingController productSubCategoryController = TextEditingController();
  TextEditingController productMrpController = TextEditingController();
  TextEditingController productDiscountController = TextEditingController();
  TextEditingController productTaxController = TextEditingController();
  TextEditingController productOfferController = TextEditingController();
  TextEditingController productColorController = TextEditingController();
  TextEditingController productQualityController = TextEditingController();
  TextEditingController productSizeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
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
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit,
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
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Product name *",style: TextStyle(fontSize: 16),),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: productNameController,
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
                  const Text("Product Category *",style: TextStyle(fontSize: 16),),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
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
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              productCategoryController.text =
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
                      controller: productCategoryController,
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
                  const Text("Product Sub Category *",style: TextStyle(fontSize: 16),),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      List<String> subCategories = [
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
                                              productSubCategoryController
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
                      controller: productSubCategoryController,
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
                  const Text("Product Mrp *",style: TextStyle(fontSize: 16),),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: productMrpController,
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
                  const Text("Product Discount *",style: TextStyle(fontSize: 16),),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: productDiscountController,
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
                  const Text("Product Tax Rate *",style: TextStyle(fontSize: 16),),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: productTaxController,
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
                  const Text("Product Offer *",style: TextStyle(fontSize: 16),),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: productOfferController,
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
                  const Text("Product Color *",style: TextStyle(fontSize: 16),),
                  const SizedBox(
                    height: 5,
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
                                              productColorController.text =
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
                      controller: productColorController,
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Product Quality *",style: TextStyle(fontSize: 16),),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      List<String> qualityTypes = [
                        "Good",
                        "Better",
                        "Best",
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
                                              productQualityController.text =
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
                      controller: productQualityController,
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
                  const Text("Product Size *",style: TextStyle(fontSize: 16),),
                  const SizedBox(
                    height: 5,
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
                                              productSizeController.text =
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
                      controller: productSizeController,
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
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {}
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
  }
}
