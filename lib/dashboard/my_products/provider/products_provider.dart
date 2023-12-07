import 'package:flutter/cupertino.dart';
import 'package:samruddhi_store/dashboard/my_products/model/create_product_response_model.dart';
import 'package:samruddhi_store/utils/app_widgets.dart';

import '../../../api_calls.dart';
import '../../../database/app_pref.dart';
import '../../../database/models/pref_model.dart';
import '../model/create_product_request_model.dart';

class ProductProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();

  TextEditingController productNameController = TextEditingController();
  TextEditingController productCategoryController = TextEditingController();
  TextEditingController productSubCategoryController = TextEditingController();
  TextEditingController productMrpController = TextEditingController();
  TextEditingController productDiscountController = TextEditingController();
  TextEditingController productTaxController = TextEditingController();
  TextEditingController productOfferController = TextEditingController();
  TextEditingController productColorController = TextEditingController();
  TextEditingController productQualityController = TextEditingController();
  TextEditingController productSizeController = TextEditingController();
  TextEditingController productSellingPriceController = TextEditingController();
  TextEditingController productHSNController = TextEditingController();
  TextEditingController productUOMController = TextEditingController();
  TextEditingController productModelController = TextEditingController();
  TextEditingController productManufacturerController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  final productFormKey = GlobalKey<FormState>();

  Future<void> addNewProduct(BuildContext context) async {
    PrefModel prefModel = AppPref.getPref();
    showLoaderDialog(context);
    CreateProductRequestModel reqData = CreateProductRequestModel();
    reqData.productName = productNameController.text;
    reqData.productSku = "PRD1115";
    reqData.productQuantity = int.parse(productQuantityController.text);
    reqData.productCategoryName = productCategoryController.text;
    reqData.productSubCategoryName = productSubCategoryController.text;
    reqData.productDiscount = int.parse(productDiscountController.text);
    reqData.isMrp = true;
    reqData.storeUuid = "e2cAIGmlUYPOSigBbD2t15AHkaJ3";
    reqData.storeName = "cvgd";
    // reqData.tax
    reqData.productOffer = int.parse(productOfferController.text);
    reqData.color = productColorController.text;
    reqData.size = productSizeController.text;
    reqData.sellingPrice = int.parse(productSellingPriceController.text);
    reqData.productHsnCode = int.parse(productHSNController.text);
    reqData.productUom = productUOMController.text;
    reqData.productModel = productModelController.text;
    reqData.manufacturer = productManufacturerController.text;
    reqData.description = productDescriptionController.text;
    reqData.quality = int.parse(productQualityController.text);
    CreateProductResponseModel response = await apiCalls.addProduct(reqData, context);
    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      showErrorToast(context, response.message ?? "Unknown error");
    }
  }
}