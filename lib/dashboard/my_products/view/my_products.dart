import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/api_calls.dart';
import 'package:samruddhi_store/dashboard/my_products/provider/products_provider.dart';
import 'package:samruddhi_store/utils/url_constants.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({Key? key}) : super(key: key);

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  bool isSubcategoryHidden = false;
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
            title: Text(
              "${prefModel.userData!.displayName}",
            ),
            centerTitle: true,
            // leading: const Icon(Icons.edit_outlined),
            actions: [
              // IconButton(
              //   icon: const Icon(Icons.search),
              //   color: AppColors.fontColor,
              //   onPressed: () {},
              // ),
              IconButton(
                icon: const Icon(Icons.add),
                color: AppColors.fontColor,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addProductRoute);
                },
              ),
            ],
          ),
          body: Column(
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
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const Text(
                      //   "${prefModel.userData!.displayName}",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: AppColors.fontColor,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      SizedBox(
                        width: screenSize.width / 1.75,
                        child: Text(
                          "${prefModel.userData!.addressArray!.completeAddress} ${prefModel.userData!.addressArray!.state} ${prefModel.userData!.addressArray!.city} ${prefModel.userData!.addressArray!.zipCode}",
                          textAlign: TextAlign.center,
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
              productsProvider.allProducts.isNotEmpty?Expanded(
                child: GroupedListView<dynamic, String>(
                  elements: productsProvider.allProducts,
                  groupBy: (element) {
                    return element['productCategory']['productCategoryName'];
                  },
                  groupSeparatorBuilder: (String groupByValue) {
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              onTap: () {},
                              child: Icon(
                                isSubcategoryHidden
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
                    return Column(
                      children: [
                        Container(
                          width: screenSize.width,
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                width: screenSize.width / 3.75,
                                height: screenSize.width / 3.75,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: element['productImgArray'].length !=
                                            0
                                        ? NetworkImage(
                                            "${UrlConstant.imageBaseUrl}${element['productImgArray'][0]['imagePath']}")
                                        : const NetworkImage(
                                            "https://via.placeholder.com/115x111"),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${element['productName']}",
                                          style: const TextStyle(
                                            color: AppColors.fontColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.60,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            productsProvider.setProductToEdit(element);
                                            Navigator.pushNamed(context, Routes.editProductRoute).then((value) {
                                              setState(() {
                                                isLoaded=false;
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
                                                      TextDecoration.underline,
                                                  color: AppColors.fontColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
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
                                      '₹${element['productSubCategory']['productSubCategoryName']}',
                                      style: const TextStyle(
                                        color: Color(0x8937474F),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      '₹${element['sellingPrice']}',
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  // itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
                  // useStickyGroupSeparators: true,
                  // optional
                  floatingHeader: true,
                  // optional
                  order: GroupedListOrder.ASC, // optional
                ),
              ):const Center(child: Text("No Products yet"),)
            ],
          ),
        );
      },
    );
  }
}
