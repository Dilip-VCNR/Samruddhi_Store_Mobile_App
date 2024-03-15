import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samruddhi_store/api_calls.dart';
import 'package:samruddhi_store/dashboard/my_products/models/add_product_response_model.dart';
import 'package:samruddhi_store/dashboard/my_products/models/product_sub_category_list_model.dart';
import 'package:samruddhi_store/utils/app_widgets.dart';
import 'package:samruddhi_store/utils/url_constants.dart';

import '../../../utils/app_colors.dart';
import '../models/all_product_response_model.dart';
import '../models/product_category_list_model.dart';

class ProductsProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();

  // Add product screen declarations
  TextEditingController productSkuController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  TextEditingController productSubCategoryController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productUomController = TextEditingController();
  TextEditingController productSellingPriceController = TextEditingController();
  TextEditingController productBuyingPriceController = TextEditingController();
  TextEditingController productDiscountController = TextEditingController();
  TextEditingController productMinQtyController = TextEditingController();
  TextEditingController productManufacturerController = TextEditingController();
  TextEditingController productHsnCodeController = TextEditingController();
  TextEditingController productModelController = TextEditingController();
  TextEditingController productTaxController = TextEditingController();
  TextEditingController productOfferController = TextEditingController();
  TextEditingController productSizeController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  bool addProductAvailability = false;
  bool addProductIsPerishable = false;
  bool addProductIsReturnable = false;
  File? selectedImage;

  final addProductFormKey = GlobalKey<FormState>();
  BuildContext? addProductScreenContext;
  ProductSubCategoryListModel? subCategoriesList;
  ProductCategoryListModel? categoriesList;
  bool? isLoaded;

  // my products screen
  AllProductResponseModel? allProductsModel;
  BuildContext? myProductsScreenContext;
  List allProducts = [];


  final editProductFormKey = GlobalKey<FormState>();
  BuildContext? editProductScreenContext;

  String? lastEditProductId;

  getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CroppedFile croppedFile = await getCroppedImage(pickedFile.path);
      selectedImage = File(croppedFile.path);
      notifyListeners();
    }
  }
  getCroppedImage(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return croppedFile;
  }

  getCategoriesDropDownData() async {
    categoriesList = null;
    subCategoriesList = null;
    categoriesList = await apiCalls.getProductCategoryList();
    subCategoriesList = await apiCalls.getProductSubCategoryList();
    isLoaded = true;
    notifyListeners();
  }

  addNewProduct() async {
    showLoaderDialog(addProductScreenContext!);
    AddProductResponseModel response = await apiCalls.addNewProduct(
        productSku: productSkuController.text,
        productName: productNameController.text,
        productQuantity: productQuantityController.text,
        productCategoryName: productCategoryController.text,
        description: productDescriptionController.text,
        sellingPrice: productSellingPriceController.text,
        buyingPrice: productBuyingPriceController.text,
        productTax: productTaxController.text,
        productUom: productUomController.text,
        productDiscount: productDiscountController.text,
        productOffer: productOfferController.text,
        purchaseMinQuantity: productMinQtyController.text,
        manufacturer: productManufacturerController.text,
        productHsnCode: productHsnCodeController.text,
        productModel: productModelController.text,
        productSubCategoryName: productSubCategoryController.text,
        selectedImage: selectedImage,
        isPerishable: addProductIsPerishable.toString(),
        isReturnable: addProductIsReturnable.toString(),
        isAvailable: addProductAvailability,
      expiryDate:expiryDateController.text
    );

    if (response.statusCode == 201) {
      await getStoreProducts();
      clearFields();
      Navigator.pop(addProductScreenContext!);
      showSuccessToast(addProductScreenContext!, response.message!);
      Navigator.pop(addProductScreenContext!);
    } else {
      Navigator.pop(addProductScreenContext!);
      showErrorToast(addProductScreenContext!, response.message!);
    }
  }

  getStoreProducts() async {
    allProducts = [];
    allProductsModel = await apiCalls.getStoreProducts();
    for (int i = 0; i < allProductsModel!.result!.length; i++) {
      allProducts.add(allProductsModel!.result![i].toJson());
    }
    notifyListeners();
  }

  Future<void> setProductToEdit(ProductsResult product) async {
    selectedImage=null;
    lastEditProductId = product.productUuid;
    productSkuController.text = product.productSku!;
    productNameController.text = product.productName!;
    productCategoryController.text = product.productCategory!.productCategoryName!;
    productSubCategoryController.text = product.productSubCategory!.productSubCategoryName!;
    productQuantityController.text = product.productQuantity.toString();
    productUomController.text = product.productUom!;
    productSellingPriceController.text = product.sellingPrice.toString();
    productBuyingPriceController.text = product.buyingPrice.toString();
    productDiscountController.text = product.productDiscount.toString();
    productTaxController.text = product.productTax.toString();
    productManufacturerController.text = product.manufacturer.toString();
    productModelController.text = product.productModel.toString();
    addProductIsPerishable = product.isPerishable??false;
    addProductIsReturnable = product.isReturnable?? false;
    addProductAvailability = product.isAvailable??false;
    expiryDateController.text = product.productExpiryDate ?? "";
    productHsnCodeController.text = product.productHsnCode.toString();
    productDescriptionController.text = product.description.toString();
    selectedImage = await downloadImageAndReturnFilePath(UrlConstant.imageBaseUrl+product.productImgArray![0].imagePath!);
    notifyListeners();
  }

  Future<File?> downloadImageAndReturnFilePath(String imageUrl) async {
    try {
      // Fetch the image data
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Create a temporary file
        File tempFile = File('${Directory.systemTemp.path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.jpg');

        // Write the image data to the temporary file
        await tempFile.writeAsBytes(response.bodyBytes);

        // Return the path to the temporary file
        return tempFile;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> updateProduct() async {
    showLoaderDialog(editProductScreenContext!);
    AddProductResponseModel response = await apiCalls.updateProduct(
        productSku: productSkuController.text,
        productName: productNameController.text,
        productQuantity: productQuantityController.text,
        productCategoryName: productCategoryController.text,
        description: productDescriptionController.text,
        sellingPrice: productSellingPriceController.text,
        buyingPrice: productBuyingPriceController.text,
        productTax: productTaxController.text,
        productUom: productUomController.text,
        productDiscount: productDiscountController.text,
        productOffer: productOfferController.text,
        purchaseMinQuantity: productMinQtyController.text,
        manufacturer: productManufacturerController.text,
        productHsnCode: productHsnCodeController.text,
        productModel: productModelController.text,
        productSubCategoryName: productSubCategoryController.text,
        selectedImage: selectedImage,
        isPerishable: addProductIsPerishable.toString(),
        isReturnable: addProductIsReturnable.toString(),
        isAvailable: addProductAvailability,
        expiryDate:expiryDateController.text,
        lastEditProductId:lastEditProductId
    );

    if (response.statusCode == 200) {
      await getStoreProducts();
      clearFields();
      Navigator.pop(editProductScreenContext!);
      showSuccessToast(editProductScreenContext!, response.message!);
      Navigator.pop(editProductScreenContext!);
    } else {
      Navigator.pop(editProductScreenContext!);
      showErrorToast(editProductScreenContext!, response.message!);
    }
  }
  clearFields(){
     productSkuController.clear();
     productNameController.clear();
     productQuantityController.clear();
     productCategoryController.clear();
     productSubCategoryController.clear();
     productDescriptionController.clear();
     productUomController.clear();
     productBuyingPriceController.clear();
     productSellingPriceController.clear();
     productDiscountController.clear();
     productMinQtyController.clear();
     productManufacturerController.clear();
     productHsnCodeController.clear();
     productModelController.clear();
     productTaxController.clear();
     productOfferController.clear();
     productSizeController.clear();
     expiryDateController.clear();
    addProductAvailability = false;
    addProductIsPerishable = false;
    addProductIsReturnable = false;
    selectedImage=null;
  }
}
