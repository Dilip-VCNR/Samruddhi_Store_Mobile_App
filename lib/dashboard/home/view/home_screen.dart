import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi_store/dashboard/dashboard_provider.dart';
import 'package:samruddhi_store/utils/app_colors.dart';

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
      builder: (BuildContext context, DashboardProvider dashboardProvider, Widget? child) {
        if(firstTimeLoading!=true){
          print("case2");
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
           body: dashboardProvider.homeResponse!=null?SingleChildScrollView(
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
                   child:Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       const Text(
                         'Collections Today',
                         style: TextStyle(
                           color: AppColors.fontColor,
                           fontSize: 22,
                           fontWeight: FontWeight.w500,
                         ),
                         textAlign: TextAlign.center,
                       ),Text(
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
                 const SizedBox(height: 20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                       padding: const EdgeInsets.all(10),
                       margin: const EdgeInsets.only(right: 10),
                       width: screenSize.width/3-25,
                       height: screenSize.width/3-25,
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
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Text(
                             "Today's \nOrders",
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 18,
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


                     Container(
                       padding: const EdgeInsets.all(10),
                       margin: const EdgeInsets.only(right: 10),
                       width: screenSize.width/3-25,
                       height: screenSize.width/3-25,
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
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Text(
                             "Pending\nOrders",
                             style: TextStyle(
                               color: AppColors.fontColor,
                               fontSize: 18,
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
                     Container(
                       padding: const EdgeInsets.all(10),
                       margin: const EdgeInsets.only(right: 10),
                       width: screenSize.width/3-25,
                       height: screenSize.width/3-25,
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
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Text(
                             "Orders\nDelivered",
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 18,
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
                     )

                   ],
                 ),
                 const SizedBox(height: 10,),
                 const Text(
                   'New Orders',
                   style: TextStyle(
                     color: AppColors.fontColor,
                     fontSize: 22,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 dashboardProvider.homeResponse!.result!.newOrderListArray!.isNotEmpty?ListView.separated(
                   shrinkWrap: true,
                   itemCount: dashboardProvider.homeResponse!.result!.newOrderListArray!.length,
                   scrollDirection: Axis.vertical,
                   physics: const NeverScrollableScrollPhysics(),
                   itemBuilder: (context, index) => GestureDetector(
                     onTap: (){
                       Navigator.pushNamed(context, Routes.viewOrderDetailRoute,arguments: {
                         'orderDetails':dashboardProvider.homeResponse!.result!.newOrderListArray![index].toJson()
                       }).then((value) {
                         setState(() {
                           firstTimeLoading=false;
                         });
                         return null;
                       });
                     },
                     child: Container(
                       // color: Colors.black,
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
                           //       image: NetworkImage("https://via.placeholder.com/100x100"),
                           //       fit: BoxFit.fill,
                           //     ),
                           //     shape: RoundedRectangleBorder(
                           //       borderRadius: BorderRadius.circular(20),
                           //     ),
                           //   ),
                           // ),
                           // const SizedBox(width: 10,),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 'Order - #${dashboardProvider.homeResponse!.result!.newOrderListArray![index].orderId}',
                                 style: const TextStyle(
                                   color: Colors.black,
                                   fontSize: 16,
                                   fontWeight: FontWeight.w700,
                                 ),
                               ),
                               SizedBox(
                                 width: screenSize.width/1.7,
                                 child: Text(
                                   '${dashboardProvider.homeResponse!.result!.newOrderListArray![index].productDetails![0].productName} and ${dashboardProvider.homeResponse!.result!.newOrderListArray![index].productDetails!.length-1} other products',
                                   style: const TextStyle(
                                     color: Colors.black,
                                     fontSize: 14,
                                     fontWeight: FontWeight.w400,
                                   ),
                                 ),
                               ),
                               const SizedBox(height: 10,),
                               SizedBox(
                                 width: 212,
                                 child: Text.rich(
                                   TextSpan(
                                     children: [
                                       const TextSpan(
                                         text: 'Order value : ',
                                         style: TextStyle(
                                           color: Color(0xFF37474F),
                                           fontSize: 14,
                                           fontFamily: 'Poppins',
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),
                                       TextSpan(
                                         text: '₹${dashboardProvider.homeResponse!.result!.newOrderListArray![index].orderGrandTotal}',
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
                               const SizedBox(height: 10,),
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
                                   child: Text('${dashboardProvider.homeResponse!.result!.newOrderListArray![index].orderStatus}',style: const TextStyle(color: Colors.white),),
                                 ),
                               )
                             ],
                           )
                         ],
                       ),
                     ),
                   ), separatorBuilder: (BuildContext context, int index) {
                   return const Divider();
                 },
                 ):const Center(child: Text("No Orders yet !"),)

               ],
             ),
           ):const Center(child: CircularProgressIndicator(),),
         );
      },
    );
  }
}
