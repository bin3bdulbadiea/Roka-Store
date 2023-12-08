import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/fonts.dart';
import 'package:rokastore/screens/profile_screen/orders_screen/orders_details.dart';
import 'package:rokastore/services/firestore_services.dart';
import 'package:velocity_x/velocity_x.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key, this.data});
  final dynamic data;

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            WavyAnimatedText(
              'Roka Store',
              textStyle: const TextStyle(fontSize: 25, fontFamily: tektur),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return 'لا يوجد طلبات'.text.makeCentered();
          } else {
            var data = snapshot.data!.docs;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: ListTile(
                    leading: '${index + 1}'.text.make(),
                    title: data[index]['order_code']
                        .toString()
                        .text
                        .color(redColor)
                        .size(18)
                        .semiBold
                        .make(),
                    subtitle: data[index]['total_amount']
                        .toString()
                        .numCurrency
                        .text
                        .make(),
                    trailing: IconButton(
                      onPressed: () {
                        Get.to(() => OrdersDetails(data: data[index]));
                      },
                      icon: const Icon(Icons.arrow_forward),
                    ),
                    onTap: () {
                      Get.to(() => OrdersDetails(data: data[index]));
                    },
                  ),
                ).box.make();
              },
            );
          }
        },
      ),
    );
  }
}
