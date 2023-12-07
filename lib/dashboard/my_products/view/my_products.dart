import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/dashboard/my_products/provider/products_provider.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({Key? key}) : super(key: key);

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  bool isSubcategoryHidden = false;
  // List<CreateProductRequestModel> products = [];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<ProductProvider>(
      builder: (BuildContext context, ProductProvider productProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.storeBackground,
            title: const Text("More Super mart",),
            centerTitle: true,
            leading: const Icon(Icons.edit_outlined),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                color: AppColors.fontColor,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.add),
                color: AppColors.fontColor,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addProductRoute).then;
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
                  padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Groceries and shopping",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width / 1.75,
                        child: const Text(
                          "#11, First floor vcnr Hospital, Nelamangala bangalore - 562123",
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    // CreateProductRequestModel product = products[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Category name",
                                  style: TextStyle(
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
                        ),
                        Container(
                          width: screenSize.width,
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                width: screenSize.width / 3.75,
                                height: screenSize.width / 3.75,
                                decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                    image: NetworkImage(
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          // product.productName.toString(),
                                          "ProductName",
                                          style: TextStyle(
                                            color: AppColors.fontColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.60,
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap:(){
                                            Navigator.pushNamed(context, Routes.editProductRoute);
                                          },
                                          child: const Row(
                                            children: [
                                              Text(
                                                "Edit",
                                                style: TextStyle(
                                                  decoration: TextDecoration.underline,
                                                  color: AppColors.fontColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.60,
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              Icon(Icons.edit_outlined,size: 15,)
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                    const Text(
                                      // '₹${product.isMrp}',
                                      "₹100",
                                      style: TextStyle(
                                        color: Color(0x8937474F),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const Text(
                                      // '₹${product.sellingPrice}',
                                      "₹90",
                                      style: TextStyle(
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
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
