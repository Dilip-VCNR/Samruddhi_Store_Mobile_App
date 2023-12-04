import 'package:flutter/material.dart';
import 'package:samruddhi_store/utils/app_colors.dart';

import 'orders_list.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Orders"),
            GestureDetector(
              onTap: () {},
              child: const Text(
                '27-August -2023  Today',
                style: TextStyle(
                  color: Color(0xFF1B8902),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(20),
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenSize.width / 4,
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
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'All Orders\n10',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenSize.width / 4,
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
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Pending\n10',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenSize.width / 4,
                        padding: const EdgeInsets.all(11),
                        decoration: ShapeDecoration(
                          color: Colors.green.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Completed\n10',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
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
              length: 5,
              child: TabBar(
                controller: _tabController, // Add this line
                isScrollable: true,
                labelColor: AppColors.primaryColor,
                indicatorColor: AppColors.primaryColor,
                tabs: const [
                  Tab(
                    text: "All orders(12)",
                  ),
                  Tab(
                    text: "New orders(2)",
                  ),
                  Tab(
                    text: "Pending(6)",
                  ),
                  Tab(
                    text: "Packed(1)",
                  ),
                  Tab(
                    text: "Shipped(7)",
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  // physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: const [
                    OrdersList(),
                    OrdersList(),
                    OrdersList(),
                    OrdersList(),
                    OrdersList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
