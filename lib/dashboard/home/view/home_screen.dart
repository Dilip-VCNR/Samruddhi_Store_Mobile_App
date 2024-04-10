import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/dashboard/dashboard_provider.dart';
import 'package:samruddhi_store/utils/app_colors.dart';

import '../../../utils/app_widgets.dart';
import '../../../utils/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstTimeLoading = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        if (firstTimeLoading != true) {
          dashboardProvider.getHomeData();
          firstTimeLoading = true;
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Dashboard"),
            // actions: [
            //   IconButton(onPressed: (){}, icon: const Icon(Icons.power_settings_new))
            // ],
          ),
          body: dashboardProvider.homeResponse != null
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenSize.width,
                        height: 100,
                        decoration: ShapeDecoration(
                          color: AppColors.cardBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: AppColors.cardShadow,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Today's Collection",
                              style: TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '₹${dashboardProvider.homeResponse!.result!.counterArray![0].todaysCollection}',
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 10),
                            width: screenSize.width / 3 - 25,
                            height: screenSize.width / 3 - 25,
                            decoration: ShapeDecoration(
                              color: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: AppColors.cardShadow,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown, // Use BoxFit.scaleDown to scale down the text if needed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Today's\nOrders",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${dashboardProvider.homeResponse!.result!.counterArray![0].allOrderCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 10),
                            width: screenSize.width / 3 - 25,
                            height: screenSize.width / 3 - 25,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: AppColors.cardShadow,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown, // Use BoxFit.scaleDown to scale down the text if needed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Ongoing\nOrders",
                                    style: TextStyle(
                                      color: AppColors.fontColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${dashboardProvider.homeResponse!.result!.counterArray![0].pendingOrdersCount}',
                                    style: const TextStyle(
                                      color: AppColors.fontColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 10),
                            width: screenSize.width / 3 - 25,
                            height: screenSize.width / 3 - 25,
                            decoration: ShapeDecoration(
                              color: AppColors.secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: AppColors.cardShadow,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown, // Use BoxFit.scaleDown to scale down the text if needed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Orders\nDelivered",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${dashboardProvider.homeResponse!.result!.counterArray![0].ordersDelivered}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Today's New Order",
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      dashboardProvider.homeResponse!.result!.newOrderListArray!
                              .isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              itemCount: dashboardProvider.homeResponse!.result!
                                  .newOrderListArray!.length,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.viewOrderDetailRoute,
                                        arguments: {
                                          'orderDetails': dashboardProvider
                                              .homeResponse!
                                              .result!
                                              .newOrderListArray![index]
                                              .toJson()
                                        }).then((value) {
                                      setState(() {
                                        firstTimeLoading = false;
                                      });
                                      return null;
                                    });
                                  },
                                  child: Container(
                                    width: screenSize.width,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        color: AppColors.storeBackground),
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screenSize.width - 60,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: screenSize.width*0.6,
                                                child: Text(
                                                  '#${dashboardProvider.homeResponse!.result!.newOrderListArray![index].orderId}',
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
                                                    capitalizeWords(dashboardProvider.homeResponse!.result!.newOrderListArray![index].orderStatus!),
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
                                            '${dashboardProvider.homeResponse!.result!.newOrderListArray![index].productDetails![0].productName}${dashboardProvider.homeResponse!.result!.newOrderListArray![index].productDetails!.length > 1 ? " and ${dashboardProvider.homeResponse!.result!.newOrderListArray![index].productDetails!.length - 1} other products" : ""}',
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
                                                      '₹${dashboardProvider.homeResponse!.result!.newOrderListArray![index].orderGrandTotal}',
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
                                                    color: Color(0xFF37474F),
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                  capitalizeWords(dashboardProvider.homeResponse!.result!.newOrderListArray![index].orderDeliveryType!),
                                                  style: const TextStyle(
                                                    color: Color(0xFF37474F),
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
                                                      '${dashboardProvider.homeResponse!.result!.newOrderListArray![index].orderDate!.day}-${dashboardProvider.homeResponse!.result!.newOrderListArray![index].orderDate!.month}-${dashboardProvider.homeResponse!.result!.newOrderListArray![index].orderDate!.year}',
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
                                                      '${parseTime(dashboardProvider.homeResponse!.result!.newOrderListArray![index].orderTime!)}',
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
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider();
                              },
                            )
                          : const Center(
                              child: Text("No Orders yet !"),
                            )
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
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
