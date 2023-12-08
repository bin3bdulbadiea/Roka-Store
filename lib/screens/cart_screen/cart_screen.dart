import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/firebase_const.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/cart_controller.dart';
import 'package:rokastore/layout/home_layout.dart';
import 'package:rokastore/services/firestore_services.dart';
import 'package:rokastore/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: cartEmpty.text.make(),
            );
          } else {
            var data = snapshot.data!.docs;

            controller.calculate(data);

            controller.productSnapshot = data;

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                            data[index]['image'],
                            width: context.screenWidth / 4,
                            fit: BoxFit.cover,
                          ),
                          title:
                              '${data[index]['title']} (×${data[index]['quantity']})'
                                  .text
                                  .semiBold
                                  .size(18)
                                  .make(),
                          subtitle: data[index]['price']
                              .toString()
                              .numCurrency
                              .text
                              .color(redColor)
                              .semiBold
                              .make(),
                          trailing: const Icon(Icons.delete, color: redColor)
                              .onTap(() {
                            FirestoreServices.deleteDocument(data[index].id);
                          }),
                        );
                      },
                    ),
                  ),
                  'الدفع عند الإستلام'.text.semiBold.sm.red500.make(),
                  (context.screenHeight / 250).heightBox,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            totalPrice.text.semiBold.make(),
                            Obx(
                              () => controller.totalP.value
                                  .toString()
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .bold
                                  .make(),
                            ),
                          ],
                        )
                            .box
                            .roundedSM
                            .shadowMd
                            .padding(const EdgeInsets.all(15))
                            .color(lightGolden)
                            .make(),
                      ),
                      (context.screenHeight / 100).widthBox,
                      Expanded(
                        child: SizedBox(
                          height: context.screenHeight / 15,
                          child: controller.placingOrder.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                      redColor,
                                    ),
                                  ),
                                )
                              : ourButton(
                                  backgroundColor: redColor,
                                  onPressed: () async {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      title: 'تم الشراء',
                                      text:
                                          'تم شراء المنتج وسوف يقوم مندوب التوصيل بالإتصال بك لاحقا',
                                      confirmBtnText: 'الصفحة الرئيسية',
                                      onConfirmBtnTap: () => Get.offAll(
                                        () => const HomeLayout(),
                                      ),
                                      confirmBtnColor: redColor,
                                    );

                                    await controller.placeOrder(
                                      totalAmount: controller.totalP.value,
                                    );

                                    await controller.clearCart();
                                  },
                                  textColor: whiteColor,
                                  title: 'شراء',
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
