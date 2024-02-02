import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samruddhi_store/api_calls.dart';
import 'package:samruddhi_store/dashboard/my_products/models/add_product_response_model.dart';
import 'package:samruddhi_store/dashboard/my_products/models/product_sub_category_list_model.dart';
import 'package:samruddhi_store/utils/app_widgets.dart';

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
      selectedImage = File(pickedFile.path);
      notifyListeners();
    }
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

  void setProductToEdit(element) {
    log(element.toString());
    lastEditProductId = element['productUuid'];
    productSkuController.text = element['productSku'];
    productNameController.text = element['productName'];
    productCategoryController.text =
        element['productCategory']['productCategoryName'];
    productSubCategoryController.text =
        element['productSubCategory']['productSubCategoryName'];
    productQuantityController.text = element['productQuantity'].toString();
    productUomController.text = element['productUom'];
    productSellingPriceController.text = element['sellingPrice'].toString();
    productDiscountController.text = element['productDiscount'].toString();
    productTaxController.text = element['productTax'].toString();
    productOfferController.text = element['productOffer'].toString();
    productMinQtyController.text =
        element['purchaseMinQuantity'].toString();
    productManufacturerController.text = element['manufacturer'].toString();
    productModelController.text = element['productModel'].toString();
    addProductIsPerishable = element['isPerishable']??false;
    addProductIsReturnable = element['isReturnable']?? false;
    addProductAvailability = element['isAvailable']??false;
    expiryDateController.text = element['productExpiryDate'] ?? "";
    productHsnCodeController.text = element['productHsnCode'].toString();
    productDescriptionController.text = element['description'].toString();
    // selectedImage = File.fromUri(Uri.parse(UrlConstant.imageBaseUrl+element['productImgArray'][0]['imagePath']));
    notifyListeners();
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
