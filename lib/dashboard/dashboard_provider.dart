import 'package:flutter/cupertino.dart';
import 'package:samruddhi_store/api_calls.dart';
import 'package:samruddhi_store/dashboard/home/models/home_data_model.dart';

class DashboardProvider extends ChangeNotifier{
  // HomeDataModel? homeData;
  ApiCalls apiCalls = ApiCalls();
  HomeDataModel? homeResponse;
  getHomeData() async {
    homeResponse = await apiCalls.getHomeData();
    notifyListeners();
  }
}