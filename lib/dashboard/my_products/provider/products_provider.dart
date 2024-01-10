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
  TextEditingController productColorController = TextEditingController();
  TextEditingController productQualityController = TextEditingController();
  TextEditingController productSizeController = TextEditingController();
  final addProductFormKey = GlobalKey<FormState>();
  BuildContext? addProductScreenContext;
  ProductSubCategoryListModel? subCategoriesList;
  ProductCategoryListModel? categoriesList;
  File? selectedImage;
  bool? isLoaded;


  // my products screen
  AllProductResponseModel? allProductsModel;
  BuildContext? myProductsScreenContext;
  List allProducts= [];

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
        color: productColorController.text,
        size: productSizeController.text,
        quality: productQualityController.text,
        productTax: productTaxController.text,
        productUom: productUomController.text,
        productDiscount: productDiscountController.text,
        productOffer: productOfferController.text,
        purchaseMinQuantity: productMinQtyController.text,
        manufacturer: productManufacturerController.text,
        productHsnCode: productHsnCodeController.text,
        productModel: productModelController.text,
        productSubCategoryName: productSubCategoryController.text,
        selectedImage: selectedImage);

    if (response.statusCode == 201) {
      await getStoreProducts();
      Navigator.pop(addProductScreenContext!);
      showSuccessToast(addProductScreenContext!, response.message!);
      Navigator.pop(addProductScreenContext!);
    } else {
      Navigator.pop(addProductScreenContext!);
      showErrorToast(addProductScreenContext!, response.message!);
    }
  }

  getStoreProducts() async {
    allProducts=[];
    allProductsModel = await apiCalls.getStoreProducts();
    for(int i = 0;i<allProductsModel!.result!.length;i++){
      allProducts.add(allProductsModel!.result![i].toJson());
    }
    notifyListeners();
  }
}
