import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:samruddhi_store/dashboard/my_products/models/all_product_response_model.dart';
import 'package:samruddhi_store/utils/url_constants.dart';
import 'package:toastification/toastification.dart';

import 'app_colors.dart';

showErrorToast(BuildContext context, String message) {
  toastification.show(
    style: ToastificationStyle.fillColored,
    type: ToastificationType.error,
    context: context,
    closeOnClick: true,
    title: Text(message),
    autoCloseDuration: const Duration(seconds: 5),
  );
}

showSuccessToast(BuildContext context, String message) {
  toastification.show(
    style: ToastificationStyle.fillColored,
    type: ToastificationType.success,
    closeOnClick: true,
    context: context,
    title: Text(message),
    autoCloseDuration: const Duration(seconds: 5),
  );
}

showLoaderDialog(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/loading_delivery_boy.json',
                    height: 150),
                const Text(
                  "Loading...",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ));
}

showProductDetailsModal(
    ProductsResult product, BuildContext context, Size screenSize) {
  return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Product Name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Divider(),
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.width / 2,
                  child: Image(
                    fit: BoxFit.fitHeight,
                      image: NetworkImage(UrlConstant.imageBaseUrl +
                          product.productImgArray![0].imagePath!)),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Name : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.productName!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Description: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.description!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Category:  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.description!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Sub Category : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.productSubCategory!.productSubCategoryName!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ), RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Buying Price : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: "${product.buyingPrice!}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Selling Price : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: "₹${product.sellingPrice!}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Discount percentage : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: "${product.productDiscount!}%",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Offer price : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: "₹${product.productDiscountedValue!}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "UOM : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.productUom!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Sku : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.productSku!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Tax : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: "${product.productTax!}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Quantity : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: "${product.productQuantity!}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product HSN : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: "${product.productHsnCode!}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Model : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.productModel!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Created At : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.createdAt!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Available : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.isAvailable! ? 'Yes' : 'No',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Perishable : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.isPerishable! ? 'Yes' : 'No',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Returnable : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.isReturnable! ? 'Yes' : 'No',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Product Is Mrp : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold, // Set the fontWeight to bold
                        ),
                      ),
                      TextSpan(
                        text: product.isMrp! ? 'Yes' : 'No',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight
                              .normal, // Keep the fontWeight normal for the description
                        ),
                      ),
                    ],
                  ),
                ),


                // Text(
                //   '${product.saveMessage}',
                //   style: const TextStyle(
                //       color: Colors.green,
                //       fontSize: 18,
                //       fontWeight: FontWeight.normal),
                // ),
              ],
            ),
          ),
        );
      });
}
