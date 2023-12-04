import 'package:flutter/cupertino.dart';

import '../../../api_calls.dart';

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
  final productFormKey = GlobalKey<FormState>();
}