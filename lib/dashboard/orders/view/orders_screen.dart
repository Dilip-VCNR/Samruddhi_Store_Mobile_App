import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/dashboard/dashboard_provider.dart';
import 'package:samruddhi_store/utils/app_colors.dart';
import 'package:samruddhi_store/utils/app_widgets.dart';

import '../../../utils/routes.dart';
import '../models/order_on_status_response_model.dart';
import '../models/payment_pending_orders_response_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 9, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Orders"),
                // GestureDetector(
                //   onTap: () {},
                //   child: const Text(
                //     '27-August -2023  Today',
                //     style: TextStyle(
                //       color: Color(0xFF1B8902),
                //       fontSize: 14,
                //       fontWeight: FontWeight.w500,
                //       decoration: TextDecoration.underline,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: screenSize.width,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE5E5E7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Summary',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenSize.width / 2 - 25,
                            height: screenSize.width / 4 - 25,
                            padding: const EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF7D5B1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              // Use BoxFit.scaleDown to scale down the text if needed
                              child: Text(
                                'All Orders\n${dashboardProvider.allOrdersCount}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.fontColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: screenSize.width / 2 - 25,
                            height: screenSize.width / 4 - 25,
                            padding: const EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              // Use BoxFit.scaleDown to scale down the text if needed
                              child: Text(
                                'Pending\n${dashboardProvider.pendingCount}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.fontColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenSize.width / 2 - 25,
                            height: screenSize.width / 4 - 25,
                            padding: const EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: Colors.green.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              // Use BoxFit.scaleDown to scale down the text if needed
                              child: Text(
                                'Completed\n${dashboardProvider.completedCount}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: screenSize.width / 2 - 25,
                            height: screenSize.width / 4 - 25,
                            padding: const EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: Colors.red.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              // Use BoxFit.scaleDown to scale down the text if needed
                              child: Text(
                                'Payment pending\n${dashboardProvider.pendingPaymentCount}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DefaultTabController(
                  initialIndex: 0,
                  length: 9,
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    controller: _tabController,
                    // Add this line
                    isScrollable: true,
                    labelColor: AppColors.primaryColor,
                    indicatorColor: AppColors.primaryColor,
                    tabs: const [
                      Tab(
                        text: "All Orders",
                      ),
                      Tab(
                        text: "New Orders",
                      ),
                      Tab(
                        text: "Accepted",
                      ),
                      Tab(
                        text: "Processing",
                      ),
                      Tab(
                        text: "Ready",
                      ),
                      Tab(
                        text: "Picked",
                      ),
                      Tab(
                        text: "Delivered",
                      ),
                      Tab(
                        text: "Payment Pending",
                      ),
                      Tab(
                        text: "Rejected Orders",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      ordersListView(ordersType: "all", screenSize: screenSize),
                      ordersListView(ordersType: "new", screenSize: screenSize),
                      ordersListView(
                          ordersType: "accepted", screenSize: screenSize),
                      ordersListView(
                          ordersType: "processing", screenSize: screenSize),
                      ordersListView(
                          ordersType: "ready", screenSize: screenSize),
                      ordersListView(
                          ordersType: "picked", screenSize: screenSize),
                      ordersListView(
                          ordersType: "delivered", screenSize: screenSize),
                      paymentPendingOrdersListView(screenSize: screenSize),
                      ordersListView(ordersType: "rejected", screenSize: screenSize),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ordersListView({required String ordersType, required Size screenSize}) {
    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        // dashboardProvider.getOrdersOnStatus(ordersType);
        // return Container();
        return FutureBuilder<OrderOnStatusResponseModel>(
            future: dashboardProvider.getOrdersOnStatus(ordersType),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data!.result!.orders!.isNotEmpty) {
                  return ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.result!.orders!.length,
                        scrollDirection: Axis.vertical,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.viewOrderDetailRoute,
                                  arguments: {
                                    'orderDetails': snapshot
                                        .data!.result!.orders![index]
                                        .toJson()
                                  }).then((value) {
                                    setState(() {
                                      dashboardProvider.getOrdersOnStatus(ordersType);
                                    });
                                return null;
                              });
                            },
                            child: Container(
                              // color: Colors.black,
                              width: screenSize.width,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8)),
                                  color: AppColors.storeBackground),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: screenSize.width - 40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: screenSize.width*0.6,
                                              child: Text(
                                                '#${snapshot.data!.result!.orders![index].orderId}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: screenSize.width*0.25,
                                              height: 25,
                                              decoration: ShapeDecoration(
                                                color: AppColors
                                                    .primaryColor,
                                                shape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(15),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  capitalizeWords(snapshot.data!.result!.orders![index].orderStatus!),
                                                  style: const TextStyle(
                                                      color:
                                                          Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenSize.width / 1.7,
                                        child: Text(
                                          '${snapshot.data!.result!.orders![index].productDetails![0].productName}${snapshot.data!.result!.orders![index].productDetails!.length > 1 ? " and ${snapshot.data!.result!.orders![index].productDetails!.length - 1} other products" : ""}',
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
                                                text: 'Order Value : ',
                                                style: TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                      FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '₹ ${snapshot.data!.result!.orders![index].orderGrandTotal}',
                                                style: const TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 212,
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Order Type : ',
                                                style: TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                      FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    capitalizeWords(snapshot.data!.result!.orders![index].orderDeliveryType!),
                                                style: const TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Order Date : ',
                                                style: TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                      FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${snapshot.data!.result!.orders![index].orderDate!.day}-${snapshot.data!.result!.orders![index].orderDate!.month}-${snapshot.data!.result!.orders![index].orderDate!.year}',
                                                style: const TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Order Time : ',
                                                style: TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                      FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${parseTime(snapshot.data!.result!.orders![index].orderTime!)}',
                                                style: const TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      );
                } else {
                  return const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("No orders Yet"),
                        ));
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${snapshot.error}'),
                    ],
                  ),
                );
              }
              return const Center(
                child: Text("Loading..."),
              );
            });
      },
    );
  }



  paymentPendingOrdersListView({required Size screenSize}) {
    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        return FutureBuilder<PaymentPendingOrdersResponseModel>(
            future: dashboardProvider.getPaymentPendingOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data!.result!.isNotEmpty) {
                  return ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.result!.length,
                        scrollDirection: Axis.vertical,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.viewOrderDetailRoute,
                                  arguments: {
                                    'orderDetails': snapshot
                                        .data!.result![index]
                                        .toJson()
                                  }).then((value) {
                                setState(() {
                                  dashboardProvider.getPaymentPendingOrders();
                                });
                                return null;
                              });
                            },
                            child: Container(
                              // color: Colors.black,
                              width: screenSize.width,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8)),
                                  color: AppColors.storeBackground),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: screenSize.width - 40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: screenSize.width*0.6,
                                              child: Text(
                                                '#${snapshot.data!.result![index].orderId}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: screenSize.width*0.25,
                                              height: 25,
                                              decoration: ShapeDecoration(
                                                color: AppColors
                                                    .primaryColor,
                                                shape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(15),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  capitalizeWords(snapshot.data!.result![index].orderStatus!),
                                                  style: const TextStyle(
                                                      color:
                                                          Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenSize.width / 1.7,
                                        child: Text(
                                          '${snapshot.data!.result![index].productDetails![0].productName}${snapshot.data!.result![index].productDetails!.length > 1 ? " and ${snapshot.data!.result![index].productDetails!.length - 1} other products" : ""}',
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
                                                text: 'Order Value : ',
                                                style: TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                      FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '₹ ${snapshot.data!.result![index].orderGrandTotal}',
                                                style: const TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 212,
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Order Type : ',
                                                style: TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                      FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    capitalizeWords(snapshot.data!.result![index].orderDeliveryType!),
                                                style: const TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Order Date : ',
                                                style: TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                      FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${snapshot.data!.result![index].orderDate!.day}-${snapshot.data!.result![index].orderDate!.month}-${snapshot.data!.result![index].orderDate!.year}',
                                                style: const TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Order Time : ',
                                                style: TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                      FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${parseTime(snapshot.data!.result![index].orderTime!)}',
                                                style: const TextStyle(
                                                  color:
                                                      Color(0xFF37474F),
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      );
                } else {
                  return const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("No orders Yet"),
                        ));
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${snapshot.error}'),
                    ],
                  ),
                );
              }
              return const Center(
                child: Text("Loading..."),
              );
            });
      },
    );
  }
  parseTime(String timeString) {
    DateFormat inputFormat = DateFormat('HH:mm:ss');
    DateTime dateTime = inputFormat.parse(timeString);
    DateFormat outputFormat = DateFormat('hh:mm aa');
    String formattedTime = outputFormat.format(dateTime);
    return formattedTime;
  }
}
