import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/dashboard/dashboard_provider.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';
import '../models/order_on_status_response_model.dart';

class OrdersList extends StatefulWidget {
  final String? ordersType;

  const OrdersList({Key? key, required this.ordersType}) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        return Scaffold(
            body: FutureBuilder<OrderOnStatusResponseModel>(
                future: dashboardProvider.getOrdersOnStatus(widget.ordersType),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return snapshot.data!.result!.isNotEmpty?ListView.separated(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.result!.length,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.viewOrderDetailRoute,arguments: {
                            'orderDetails':snapshot.data!.result![index].toJson()
                          });
                        },
                        child: Container(
                          width: screenSize.width,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Container(
                              //   width: 100,
                              //   height: 100,
                              //   decoration: ShapeDecoration(
                              //     image: const DecorationImage(
                              //       image: NetworkImage(
                              //           "https://via.placeholder.com/100x100"),
                              //       fit: BoxFit.fill,
                              //     ),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20),
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    '#${snapshot.data!.result![index].orderId}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width / 1.7,
                                    child: Text(
                                      '${snapshot.data!.result![index].productDetails![0].productName} and ${snapshot.data!.result![index].productDetails!.length-1} other products',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 212,
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Order value ',
                                            style: TextStyle(
                                              color: Color(0xFF37474F),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '₹${snapshot.data!.result![index].orderGrandTotal}',
                                            style: const TextStyle(
                                              color: Color(0xFF37474F),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 25,
                                    decoration: ShapeDecoration(
                                      color: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${snapshot.data!.result![index].orderStatus}",
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ):const Align(alignment: Alignment.topCenter,child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("No orders Yet"),
                    ));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${snapshot.error}'),
                          // ElevatedButton(
                          //     onPressed: _pullRefresh,
                          //     child: const Text("Refresh"))
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: Text("Loading..."),
                  );
                }));
      },
    );
  }
}
