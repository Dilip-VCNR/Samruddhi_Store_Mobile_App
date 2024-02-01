import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samruddhi_store/api_calls.dart';
import 'package:samruddhi_store/dashboard/my_products/models/add_product_response_model.dart';
import 'package:samruddhi_store/dashboard/my_products/models/product_sub_category_list_model.dart';
import 'package:samruddhi_store/dashboard/my_products/models/update_/product_response_model.dart';
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

  final addProductFormKey = GlobalKey<FormState>();
  BuildContext? addProductScreenContext;
  ProductSubCategoryListModel? subCategoriesList;
  ProductCategoryListModel? categoriesList;
  File? selectedImage;
  bool? isLoaded;

  // my products screen
  AllProductResponseModel? allProductsModel;
  BuildContext? myProductsScreenContext;
  List allProducts = [];

  // edit product pahge declarations
  TextEditingController editProductSkuController = TextEditingController();
  TextEditingController editProductNameController = TextEditingController();
  TextEditingController editProductQuantityController = TextEditingController();
  TextEditingController editProductCategoryController = TextEditingController();
  TextEditingController editProductSubCategoryController =
      TextEditingController();
  TextEditingController editProductDescriptionController =
      TextEditingController();
  TextEditingController editProductUomController = TextEditingController();
  TextEditingController editProductSellingPriceController =
      TextEditingController();
  TextEditingController editProductDiscountController = TextEditingController();
  TextEditingController editProductMinQtyController = TextEditingController();
  TextEditingController editProductManufacturerController =
      TextEditingController();
  TextEditingController editProductHsnCodeController = TextEditingController();
  TextEditingController editProductModelController = TextEditingController();
  TextEditingController editProductTaxController = TextEditingController();
  TextEditingController editProductOfferController = TextEditingController();
  TextEditingController editExpiryDateController = TextEditingController();
  bool editProductAvailability = false;
  bool editProductIsPerishable = false;
  bool editProductIsReturnable = false;

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
        isAvailable: addProductAvailability);

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
    allProducts = [];
    allProductsModel = await apiCalls.getStoreProducts();
    for (int i = 0; i < allProductsModel!.result!.length; i++) {
      allProducts.add(allProductsModel!.result![i].toJson());
    }
    notifyListeners();
  }

  void setProductToEdit(element) {
    lastEditProductId = element['productUuid'];
    editProductSkuController.text = element['productSku'];
    editProductNameController.text = element['productName'];
    editProductCategoryController.text =
        element['productCategory']['productCategoryName'];
    editProductSubCategoryController.text =
        element['productSubCategory']['productSubCategoryName'];
    editProductQuantityController.text = element['productQuantity'].toString();
    editProductMinQtyController.text =
        element['purchaseMinQuantity'].toString();
    editProductUomController.text = element['productUom'];
    editProductSellingPriceController.text = element['sellingPrice'].toString();
    editProductDiscountController.text = element['productDiscount'].toString();
    editProductTaxController.text = element['productTax'].toString();
    editProductOfferController.text = element['productOffer'].toString();
    editProductMinQtyController.text =
        element['purchaseMinQuantity'].toString();
    editProductManufacturerController.text = element['manufacturer'].toString();
    editProductModelController.text = element['productModel'].toString();
    editProductIsPerishable = element['isPerishable']??false;
    editProductIsReturnable = element['isReturnable']?? false;
    editProductAvailability = element['isAvailable']??false;
    editExpiryDateController.text = element['productExpiryDate'] ?? "";
    editProductDescriptionController.text = element['description'].toString();
    notifyListeners();
  }

  Future<void> updateProduct() async {
    showLoaderDialog(editProductScreenContext!);
    UpdateProductResponseModel res = await apiCalls.updateProduct({
      "storeUuid": prefModel.userData!.storeUuid,
      "productUuid": lastEditProductId,
      "productSku": editProductSkuController.text,
      "productName": editProductNameController.text,
      "imageDescription": editProductDescriptionController.text,
      "storeName": prefModel.userData!.storeName,
      "description": editProductDescriptionController.text,
      "sellingPrice": editProductSellingPriceController.text,
      "isAvailable": editProductAvailability,
      "productUom": editProductUomController.text,
      "productDiscount": editProductDiscountController.text,
      "productOffer": editProductOfferController.text,
      "purchaseMinQuantity": editProductMinQtyController.text,
      "manufacturer": editProductManufacturerController.text,
      "hsnCode": editProductHsnCodeController.text,
      "productModel": editProductModelController.text,
      "isPerishable":editProductIsPerishable,
      "isReturnable":editProductIsReturnable,
    }, selectedImage);
    Navigator.pop(editProductScreenContext!);
    if (res.statusCode == 200) {
      Navigator.pop(editProductScreenContext!);
      showSuccessToast(editProductScreenContext!, res.message!);
    } else {
      showErrorToast(editProductScreenContext!, res.message!);
    }
  }
}
