import 'package:flutter/material.dart';
import 'package:samruddhi_store/utils/app_colors.dart';
import 'package:samruddhi_store/utils/app_widgets.dart';

import '../../../api_calls.dart';
import '../../home/models/home_data_model.dart';
import '../models/order_status_update_response_model.dart';

class ViewOrderDetail extends StatefulWidget {
  const ViewOrderDetail({Key? key}) : super(key: key);

  @override
  State<ViewOrderDetail> createState() => _ViewOrderDetailState();
}

class _ViewOrderDetailState extends State<ViewOrderDetail> {
  String activeStatus = "Ready to dispatch";
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Map order = arguments['orderDetails'];
    print(order);
    return Scaffold(
      appBar: AppBar(
        title:  Text(
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
            Container(
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
                    'Delivery address',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${order['deliveryDetailsArray']}',
                    style: const TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Ordered on : ${order['orderDate']}',
              style: TextStyle(
                color: AppColors.fontColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Status',
              style: TextStyle(
                color: AppColors.fontColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            GestureDetector(
              onTap: (){
                List<String> statusTypes = [
                  "Order accepted",
                  "Packing Order",
                  "Packed",
                ];
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Select Status",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: statusTypes.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return InkWell(
                                      onTap: () async {
                                        showLoaderDialog(context);
                                        OrderStatusUpdateResponseModel res = await ApiCalls().setOrderStatus(statusTypes[index],order['orderId']);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        if(res.statusCode==200){
                                          activeStatus = statusTypes[index];
                                          showSuccessToast(context, res.message!);
                                        }else{
                                          showErrorToast(context, res.message!);
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                vertical: 10),
                                            child: Text(
                                              statusTypes[index],
                                              style: const TextStyle(
                                                  fontSize: 18),
                                            ),
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    }).then((value) {
                  setState(() {});
                });
              },
              child: Container(
                width: screenSize.width,
                height: 50,
                decoration: ShapeDecoration(
                  color: const Color(0xFF86DF71),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10,),
                        const Icon(Icons.delivery_dining),
                        const SizedBox(width: 10,),
                        Text(
                          activeStatus,
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.keyboard_arrow_down_outlined),
                    )
                  ],
                ),
              ),
            ),

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
            const SizedBox(
              height: 10,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
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
                                  text: '₹${order['productDetails'][index]['productGrandTotal']}',
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
