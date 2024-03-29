import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:samruddhi_store/dashboard/orders/models/update_payment_status_model.dart';
import 'package:samruddhi_store/utils/app_colors.dart';
import 'package:samruddhi_store/utils/app_widgets.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../api_calls.dart';
import '../models/order_status_update_response_model.dart';

class ViewOrderDetail extends StatefulWidget {
  const ViewOrderDetail({Key? key}) : super(key: key);

  @override
  State<ViewOrderDetail> createState() => _ViewOrderDetailState();
}

class _ViewOrderDetailState extends State<ViewOrderDetail> {
  String activeStatus = "";
  String nextStatus = "";

  final GlobalKey<SlideActionState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Map order = arguments['orderDetails'];
    activeStatus = arguments['orderDetails']['orderStatus'];
    if (activeStatus == "new") {
      nextStatus = "accepted";
    } else if (activeStatus == "accepted") {
      nextStatus = "processing";
    } else if (activeStatus == "processing") {
      nextStatus = "ready";
    } else if (activeStatus == "ready" &&
        order['orderDeliveryType'] == "selfPickUp") {
      nextStatus = "delivered";
    } else if (activeStatus == "ready" &&
        prefModel.userData!.deliveryType == "storeDelivery") {
      nextStatus = "delivered";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '#${order['orderId']}',
          style: const TextStyle(
            color: AppColors.fontColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            order['deliveryAddress'] != null
                ? Container(
                    padding: const EdgeInsets.all(20),
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
                          'Delivery Address',
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${order['deliveryAddress']['completeAddress']}',
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${order['deliveryAddress']['city']}',
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${order['deliveryAddress']['state']}',
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            double latitude = order['deliveryAddress']['lat'];
                            double longitude = order['deliveryAddress']['lng'];
                            MapsLauncher.launchCoordinates(latitude, longitude);
                          },
                          child: Container(
                            width: screenSize.width / 3,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: AppColors.primaryColor),
                            child: const Center(
                              child: Text(
                                "Navigate",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Ordered On : ${order['orderDate']}',
              style: const TextStyle(
                color: AppColors.fontColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Delivery Type : ${order['orderDeliveryType']}',
              style: const TextStyle(
                color: AppColors.fontColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Order PickUp Id : ${order['orderPickupId']}',
              style: const TextStyle(
                color: AppColors.fontColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Current Status : $activeStatus',
              style: const TextStyle(
                color: AppColors.fontColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              order['paymentDetailsArray']['paymentStatus'] != null
                  ? 'Payment Status : ${order['paymentDetailsArray']['paymentStatus']}'
                  : "Payment Status : Pending",
              style: const TextStyle(
                color: AppColors.fontColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            (order['paymentDetailsArray']['paymentStatus'] == null && activeStatus!='rejected' && activeStatus!='new')
                ? GestureDetector(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Are you sure ?"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Confirm payment for order"),
                                  Text(
                                    '#${order['orderId']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No")),
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      showLoaderDialog(context);
                                      UpdatePaymentStatusModel response =
                                          await ApiCalls()
                                              .confirmPayment(order['orderId']);
                                      Navigator.pop(context);
                                      if (response.statusCode == 200) {
                                        Navigator.pop(context);
                                        showSuccessToast(
                                            context, response.message!);
                                      } else {
                                        Navigator.pop(context);
                                        showErrorToast(
                                            context, response.message!);
                                      }
                                    },
                                    child: const Text("Yes"))
                              ],
                            );
                          });
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.secondaryColor),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: const Center(
                            child: Text(
                          'Confirm Payment',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ))),
                  )
                : const SizedBox.shrink(),
            (activeStatus != "delivered" && nextStatus != '')
                ? const SizedBox(
                    height: 10,
                  )
                : const SizedBox.shrink(),
            (activeStatus != "delivered" && nextStatus != '')
                ? const Text(
                    'Update Status',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : const SizedBox.shrink(),
            (activeStatus != "delivered" && nextStatus != '')
                ? const SizedBox(
                    height: 10,
                  )
                : const SizedBox.shrink(),

            // (activeStatus != "delivered" && nextStatus != '')?GestureDetector(
            //   onTap: () async {
            //     showLoaderDialog(context);
            //     OrderStatusUpdateResponseModel res = await ApiCalls().setOrderStatus(nextStatus,order['orderId']);
            //     Navigator.pop(context);
            //     Navigator.pop(context);
            //     if(res.statusCode==200){
            //       activeStatus = nextStatus;
            //       showSuccessToast(context, res.message!);
            //     }else{
            //       showErrorToast(context, res.message!);
            //     }
            //   },
            //   child: Container(
            //     width: screenSize.width,
            //     height: 50,
            //     decoration: ShapeDecoration(
            //       color: const Color(0xFF86DF71),
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             const SizedBox(width: 10,),
            //             const Icon(Icons.delivery_dining),
            //             const SizedBox(width: 10,),
            //             Text(
            //               "Move to "+nextStatus,
            //               style: const TextStyle(
            //                 color: AppColors.fontColor,
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w400,
            //               ),
            //             ),
            //           ],
            //         ),
            //         // const Padding(
            //         //   padding: EdgeInsets.only(right: 20),
            //         //   child: Icon(Icons.keyboard_arrow_down_outlined),
            //         // )
            //       ],
            //     ),
            //   ),
            // ):const SizedBox.shrink(),
            (activeStatus != "delivered" && nextStatus != '')
                ? SlideAction(
                    outerColor: const Color(0xFF86DF71),
                    text: "Move to $nextStatus",
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    key: _key,
                    onSubmit: () async {
                      showLoaderDialog(context);
                      OrderStatusUpdateResponseModel res = await ApiCalls()
                          .setOrderStatus(nextStatus, order['orderId']);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      if (res.statusCode == 200) {
                        activeStatus = nextStatus;
                        showSuccessToast(context, res.message!);
                      } else {
                        showErrorToast(context, res.message!);
                      }
                      _key.currentState!.reset();
                    },
                  )
                : const SizedBox.shrink(),

            (activeStatus == "new")
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: SlideAction(
                      outerColor: Colors.red,
                      text: "Reject order",
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      // key: _key,
                      onSubmit: () async {
                        showLoaderDialog(context);
                        OrderStatusUpdateResponseModel res = await ApiCalls()
                            .setOrderStatus('rejected', order['orderId']);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        if (res.statusCode == 200) {
                          activeStatus = nextStatus;
                          showSuccessToast(context, res.message!);
                        } else {
                          showErrorToast(context, res.message!);
                        }
                        _key.currentState!.reset();
                      },
                    ),
                  )
                : const SizedBox.shrink(),

            const SizedBox(
              height: 10,
            ),
            const Text(
              'Items',
              style: TextStyle(
                color: AppColors.fontColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            ListView.separated(
              shrinkWrap: true,
              itemCount: order['productDetails'].length,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
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
                        SizedBox(
                          width: screenSize.width / 1.7,
                          child: Text(
                            '${order['productDetails'][index]['productName']}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 1.7,
                          child: Text(
                            '${order['productDetails'][index]['addedCartQuantity']} Quantity',
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
                                  text:
                                      '₹${order['productDetails'][index]['productGrandTotal']}',
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
                      ],
                    )
                  ],
                ),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            )
          ],
        ),
      ),
    );
  }
}
