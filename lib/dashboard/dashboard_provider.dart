import 'package:flutter/cupertino.dart';
import 'package:samruddhi_store/api_calls.dart';
import 'package:samruddhi_store/dashboard/home/models/home_data_model.dart';

import 'orders/models/order_on_status_response_model.dart';

class DashboardProvider extends ChangeNotifier{
  // HomeDataModel? homeData;
  ApiCalls apiCalls = ApiCalls();

  HomeDataModel? homeResponse;
  int allOrdersCount = 0;
  int pendingCount = 0;
  int completedCount = 0;


  getHomeData() async {
    homeResponse = await apiCalls.getHomeData();
    notifyListeners();
  }

  Future<OrderOnStatusResponseModel> getOrdersOnStatus(String? orderType) async {
    OrderOnStatusResponseModel res = await apiCalls.getOrdersOnStatus(orderType!);
    if(orderType == 'all'){
      allOrdersCount = 0;
      pendingCount = 0;
      completedCount = 0;
      print('case1');
      allOrdersCount =res.result!.length;
      print(allOrdersCount);
      for(int i = 0;i<res.result!.length;i++){
        if(res.result![i].orderStatus!="delivered" && res.result![i].orderStatus!="new"){
          pendingCount  = pendingCount+1;
        }
        if(res.result![i].orderStatus=="delivered"){
          completedCount  = completedCount+1;
        }
      }
    }
    return res;
  }
}