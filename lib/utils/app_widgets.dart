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
    title: message,
    autoCloseDuration: const Duration(seconds: 5),
  );
}

showSuccessToast(BuildContext context, String message) {
  toastification.show(
    style: ToastificationStyle.fillColored,
    type: ToastificationType.success,
    closeOnClick: true,
    context: context,
    title: message,
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
                      "Product details",
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
                Text(
                  "Product Name : ${product.productName!}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("Product Description : ${product.description!}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("Product Category : ${product.description!}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("Product Sub Category : ${product.productSubCategory!.productSubCategoryName!}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text('Buying Price : ₹${product.buyingPrice!}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text('Selling Price : ₹${product.sellingPrice!}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("Discount percentage : ${product.productDiscount!}%",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text('Offer price : ₹${product.productDiscountedValue!}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("UOM : ${product.productUom!}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("Product Sku : ${product.productSku!}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("Product Tax : ${product.productTax!}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("Product Quantity : ${product.productQuantity!}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("Product HSN : ${product.productHsnCode!}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("Product Model : ${product.productModel!}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("Created At : ${product.createdAt!}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text(
                  "Product Available : ${product.isAvailable! ? 'Yes' : 'No'}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
                Text("Product Perishable : ${product.isPerishable! ? 'Yes' : 'No'}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("Product Returnable : ${product.isReturnable! ? 'Yes' : 'No'}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text("Product Is Mrp : ${product.isMrp! ? 'Yes' : 'No'}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)),
                Text(
                  '${product.saveMessage}',
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        );
      });
}
