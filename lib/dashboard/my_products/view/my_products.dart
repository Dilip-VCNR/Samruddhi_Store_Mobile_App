import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/api_calls.dart';
import 'package:samruddhi_store/dashboard/my_products/provider/products_provider.dart';
import 'package:samruddhi_store/utils/url_constants.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_widgets.dart';
import '../../../utils/routes.dart';
import '../models/all_product_response_model.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({Key? key}) : super(key: key);

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  Map<String, bool> categoryVisibility = {};
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, ProductsProvider productsProvider,
          Widget? child) {
        productsProvider.myProductsScreenContext = context;
        if (isLoaded == false) {
          productsProvider.getStoreProducts();
          isLoaded = true;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.storeBackground,
            title: const Text(
              "Products Catalog",
            ),
            // leading: const Icon(Icons.edit_outlined),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                color: AppColors.fontColor,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.productSearch);
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                color: AppColors.fontColor,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addProductRoute);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  width: screenSize.width,
                  decoration: const ShapeDecoration(
                    color: AppColors.storeBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenSize.width / 1.75,
                          child: Text(
                            textAlign:TextAlign.center,
                            '${prefModel.userData!.displayName}',
                            style: const TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 1.75,
                          child: Text(
                            textAlign:TextAlign.center,
                            "${prefModel.userData!.addressArray!.completeAddress} ${prefModel.userData!.addressArray!.state} ${prefModel.userData!.addressArray!.city} ${prefModel.userData!.addressArray!.zipCode}",
                            style: const TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                productsProvider.allProducts.isNotEmpty
                    ? GroupedListView<dynamic, String>(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      elements: productsProvider.allProducts,
                      groupBy: (element) {
                        return element['productCategory']
                            ['productCategoryName'];
                      },
                      groupSeparatorBuilder: (String groupByValue) {
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  groupByValue,
                                  style: const TextStyle(
                                    color: AppColors.fontColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // Toggle the visibility state for the clicked category
                                      categoryVisibility[groupByValue] =
                                          !(categoryVisibility[
                                                  groupByValue] ??
                                              true);
                                    });
                                  },
                                  child: Icon(
                                    categoryVisibility[groupByValue] ?? true
                                        ? Icons.keyboard_arrow_up_rounded
                                        : Icons.keyboard_arrow_down_rounded,
                                    color: AppColors.fontColor,
                                    size: 40,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemBuilder: (context, element) {
                        // Get the category name from the element
                        String categoryName =
                            element['productCategory']['productCategoryName'];
                        // Check if the category is visible, if not, return an empty container
                        if (categoryVisibility[categoryName] == false) {
                          return Container();
                        }
                        ProductsResult product =
                            ProductsResult.fromJson(element);
                        return GestureDetector(
                          onTap: (){
                            showProductDetailsModal(product,context,screenSize);
                          },
                          child: Column(
                            children: [
                              Container(
                                width: screenSize.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: screenSize.width / 3.75,
                                      height: screenSize.width / 3.75,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: product
                                                  .productImgArray!.isNotEmpty
                                              ? NetworkImage(
                                                  "${UrlConstant.imageBaseUrl}${product.productImgArray![0].imagePath}")
                                              : const NetworkImage(
                                                  "https://via.placeholder.com/115x111"),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: screenSize.width / 2.5,
                                                child: Text(
                                                  "${product.productName}",
                                                  style: const TextStyle(
                                                    color: AppColors.fontColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.60,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  productsProvider
                                                      .setProductToEdit(
                                                          product);
                                                  Navigator.pushNamed(
                                                          context,
                                                          Routes
                                                              .editProductRoute)
                                                      .then((value) {
                                                    setState(() {
                                                      isLoaded = false;
                                                    });
                                                    return null;
                                                  });
                                                },
                                                child: const Row(
                                                  children: [
                                                    Text(
                                                      "Edit",
                                                      style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color:
                                                            AppColors.fontColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0.60,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(
                                                      Icons.edit_outlined,
                                                      size: 15,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${product.productSubCategory!.productSubCategoryName}',
                                            style: const TextStyle(
                                              color: Color(0x8937474F),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              // decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                          Text(
                                            '₹${product.sellingPrice}',
                                            style: const TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'UOM : ${product.productUom}',
                                            style: const TextStyle(
                                                // color: AppColors.primaryColor,
                                                // fontSize: 20,
                                                // fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          Text(
                                            'Tax : ${product.productTax}%',
                                            style: const TextStyle(
                                                // color: AppColors.primaryColor,
                                                // fontSize: 20,
                                                // fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          Text(
                                            'Discount : ${product.productDiscount}% (₹${product.productDiscountedValue})',
                                            style: const TextStyle(
                                                // color: AppColors.primaryColor,
                                                // fontSize: 20,
                                                // fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Divider(),
                              )
                            ],
                          ),
                        );
                      },
                      // itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
                      // useStickyGroupSeparators: true,
                      // optional
                      floatingHeader: true,
                      // optional
                      order: GroupedListOrder.ASC, // optional
                    )
                    : const Center(
                        child: Text("No Products yet"),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
