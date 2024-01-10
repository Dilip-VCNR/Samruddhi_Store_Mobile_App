import 'package:flutter/cupertino.dart';
import 'package:samruddhi_store/api_calls.dart';

class DashboardProvider extends ChangeNotifier{
  // HomeDataModel? homeData;
  ApiCalls apiCalls = ApiCalls();
  getHomeData() async {
    apiCalls.getHomeData();
    // notifyListeners();
  }
}