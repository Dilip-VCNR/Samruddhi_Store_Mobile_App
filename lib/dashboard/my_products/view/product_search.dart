import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/url_constants.dart';
import '../models/all_product_response_model.dart';
import '../provider/products_provider.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({Key? key}) : super(key: key);

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  List filteredProducts = [];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(builder: (BuildContext context,
        ProductsProvider productsProvider, Widget? child) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Search for products"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                  child: TextField(
                    onChanged: (String val) {
                      // for(int i = 0;i<productsProvider.allProducts.length;i++){
                      //   ProductsResult.fromJson(productsProvider.allProducts[i]);
                      // }
                      filteredProducts = [];
                      setState(() {
                        filteredProducts = productsProvider.allProducts.where((element) => element['productName'].toLowerCase()
                            .contains(val.toLowerCase())).toList();
                        // filteredProducts = productsProvider.allProducts
                        //     .expand((detail) => detail.productList!)
                        //     .where((product) =>
                        //     product.productDetail!.productName!
                        //         .toLowerCase()
                        //         .contains(val.toLowerCase()))
                        //     .toList();
                      });
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search products',
                      counterText: "",
                      isCollapsed: true,
                      filled: true,
                      fillColor: AppColors.inputFieldColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                ListView.separated(
                  separatorBuilder: (context, index){
                    return const Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider());
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    ProductsResult product = ProductsResult.fromJson(filteredProducts[index]);
                    return Column(
                      children: [
                        Container(
                          width: screenSize.width,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: screenSize.width*.25,
                                height: screenSize.width*.25,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: product
                                        .productImgArray!
                                        .isEmpty
                                        ? const NetworkImage(
                                        "https://via.placeholder.com/115x111")
                                        : NetworkImage(
                                        '${UrlConstant.imageBaseUrl}${product.productImgArray![0].imagePath!}'),
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
                              SizedBox(
                                width: screenSize.width*.6,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product
                                          .productName!,
                                      style: const TextStyle(
                                        color: AppColors.fontColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.60,
                                      ),
                                    ),
                                    Text(
                                      product
                                          .productSubCategory!
                                          .productSubCategoryName!,
                                      style: const TextStyle(
                                        color: Color(0x8937474F),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        // decoration:
                                        //     TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      "UOM : ${product
                                          .productUom!}",
                                      style: const TextStyle(
                                        color: Color(0x8937474F),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        // decoration:
                                        //     TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      '₹${product.sellingPrice!}/${product.productUom!}',
                                      style: const TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          // decoration: TextDecoration.lineThrough,
                                          decorationColor: AppColors.secondaryColor
                                      ),
                                    ),
                                ]
                              ),
                          ),

                      ],
                    )
                    )]);
                  },
                )
              ],
            ),
          )
      );
    });
  }
}
