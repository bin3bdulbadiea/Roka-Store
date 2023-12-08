// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/screens/profile_screen/orders_screen/components/order_status.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatefulWidget {
  const OrdersDetails({super.key, this.data});
  final dynamic data;

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'تفاصيل الطلب'.text.semiBold.size(20).make(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (context.screenHeight / 100).heightBox,
            Column(
              children: [
                'حالة الطلب'.text.semiBold.size(18).make(),
                (context.screenHeight / 100).heightBox,
                orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: 'تم الحجز',
                  showDone: widget.data['order_placed'],
                ),
                orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: 'تأكيد الحجز',
                  showDone: widget.data['order_confirmed'],
                ),
                orderStatus(
                  color: Colors.orange,
                  icon: Icons.local_shipping,
                  title: 'جاري التوصيل',
                  showDone: widget.data['order_on_delevery'],
                ),
                orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: 'تم التسليم',
                  showDone: widget.data['order_delivered'],
                ),
              ],
            )
                .box
                .white
                .roundedSM
                .margin(const EdgeInsets.symmetric(horizontal: 10))
                .p16
                .make(),
            Column(
              children: [
                'معلومات الطلب'.text.semiBold.size(18).make(),
                (context.screenHeight / 100).heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'رمز الطلب'.text.semiBold.make(),
                        '${widget.data['order_code']}'
                            .text
                            .color(redColor)
                            .semiBold
                            .make(),
                        (context.screenHeight / 100).heightBox,
                        'تاريخ الطلب'.text.semiBold.make(),
                        intl.DateFormat()
                            .add_yMd()
                            .format(widget.data['order_date'].toDate())
                            .text
                            .color(redColor)
                            .semiBold
                            .make(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 'حالة التسليم'.text.semiBold.make(),
                        // 'تم الحجز'.text.color(redColor).semiBold.make(),
                        // (context.screenHeight / 100).heightBox,
                        'السعر الإجمالي'.text.semiBold.make(),
                        '${widget.data['total_amount']}'
                            .toString()
                            .numCurrency
                            .text
                            .color(redColor)
                            .semiBold
                            .make(),
                      ],
                    ),
                  ],
                ),
                
              ],
            ).box.white.roundedSM.margin(const EdgeInsets.all(10)).p16.make(),
            Column(
              children: [
                'المنتج المطلوب'.text.semiBold.size(18).make(),
                (context.screenHeight / 100).heightBox,
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    widget.data['orders'].length,
                    (index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                '${widget.data['orders'][index]['image']}',
                                fit: BoxFit.cover,
                                width: context.screenWidth / 6,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    '${widget.data['orders'][index]['title']}'
                                        .text
                                        .maxLines(1)
                                        .overflow(TextOverflow.ellipsis)
                                        .semiBold
                                        .make(),
                                    '${widget.data['orders'][index]['quantity']}×'
                                        .text
                                        .color(redColor)
                                        .semiBold
                                        .make(),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    'السعر'.text.semiBold.make(),
                                    '${widget.data['orders'][index]['price']}'
                                        .text
                                        .color(redColor)
                                        .semiBold
                                        .make(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          (context.screenHeight / 50).heightBox,
                        ],
                      );
                    },
                  ).toList(),
                ),
              ],
            )
                .box
                .white
                .roundedSM
                .margin(const EdgeInsets.symmetric(horizontal: 10))
                .p16
                .make(),
          ],
        ),
      ),
    );
  }
}
