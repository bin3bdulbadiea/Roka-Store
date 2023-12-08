import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/product_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key, required this.title, this.data});
  final String? title;
  final dynamic data;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  var controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title!.text.bold
            .size(20)
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .make(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
              if (controller.isFav.value) {
                controller.removeFromWishlist(widget.data.id, context);
                controller.isFav(false);
              } else {
                controller.addToWishlist(widget.data.id, context);
                controller.isFav(true);
              }
            },
            icon: controller.isFav.value
                ? const Icon(Icons.favorite, color: golden)
                : const Icon(Icons.favorite),
            tooltip:
                controller.isFav.value ? disFavoriteTooltip : favoriteTooltip,
          ),
        ],
      ),
      body: Column(
        children: [
          //item
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //product section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //product slider
                      Image.network(
                        '${widget.data['p_images']}',
                        width: double.infinity,
                        height: context.screenHeight * 0.4,
                        fit: BoxFit.contain,
                      ),
                      (context.screenHeight / 50).heightBox,

                      //title
                      widget.title!.text
                          .size(18)
                          .bold
                          .maxLines(2)
                          .overflow(TextOverflow.ellipsis)
                          .make(),
                      (context.screenHeight / 50).heightBox,

                      //price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          price.text.make(),
                          (context.screenHeight / 50).widthBox,
                          widget.data['p_price']
                              .toString()
                              .numCurrency
                              .text
                              .color(redColor)
                              .size(18)
                              .bold
                              .make(),
                        ],
                      ),
                    ],
                  )
                      .box
                      .white
                      .padding(const EdgeInsets.all(10))
                      .roundedSM
                      .make(),

                  (context.screenHeight / 100).heightBox,

                  //quantity section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //quantity
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          quantity.text.make(),
                          (context.screenHeight / 50).widthBox,
                          Obx(
                            () => Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.increaseQuantity(
                                      int.parse(widget.data['p_quantity']),
                                    );
                                    controller.calculateTotalPrice(
                                        int.parse(widget.data['p_price']));
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.add),
                                  tooltip: addQuantity,
                                ),
                                (context.screenHeight / 100).widthBox,
                                controller.quantity.value.text.bold
                                    .size(20)
                                    .make(),
                                (context.screenHeight / 100).widthBox,
                                IconButton(
                                  onPressed: () {
                                    controller.decreaseQuantity();
                                    controller.calculateTotalPrice(
                                        int.parse(widget.data['p_price']));
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.remove),
                                  tooltip: removeQuantity,
                                ),
                                (context.screenHeight / 100).widthBox,
                                '(${widget.data['p_quantity']} $available)'
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ],
                            )
                                .box
                                .white
                                .padding(const EdgeInsets.all(10))
                                .make(),
                          ),
                        ],
                      ),

                      (context.screenHeight / 100).heightBox,

                      //total price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          totalPrice.text.make(),
                          (context.screenHeight / 50).widthBox,
                          controller.totalPrice.value
                              .toString()
                              .numCurrency
                              .text
                              .size(16)
                              .color(redColor)
                              .bold
                              .make(),
                        ],
                      ),
                    ],
                  )
                      .box
                      .white
                      .padding(const EdgeInsets.all(10))
                      .roundedSM
                      .make(),

                  (context.screenHeight / 100).heightBox,

                  //description section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //description
                      description.text.semiBold.make(),

                      (context.screenHeight / 100).heightBox,

                      '${widget.data['p_description']}'.text.gray500.make(),
                    ],
                  )
                      .box
                      .white
                      .padding(const EdgeInsets.all(10))
                      .width(double.infinity)
                      .roundedSM
                      .make(),
                ],
              ),
            ),
          ),

          //add to cart
          SizedBox(
            height: context.screenHeight / 12,
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  controller.quantity.value == 0 ? lightGolden : redColor,
                ),
                shape: MaterialStatePropertyAll(
                  BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              onPressed: () {
                if (controller.quantity.value != 0) {
                  controller.addToCart(
                    context: context,
                    title: widget.data['p_name'],
                    img: widget.data['p_images'],
                    price: controller.totalPrice.value,
                    qty: controller.quantity.value,
                    category: widget.data['p_category'],
                  );
                  VxToast.show(context, msg: addedToCart);
                } else {
                  VxToast.show(context, msg: enterQuantity);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: whiteColor,
                  ),
                  (context.screenWidth / 20).widthBox,
                  addToCart.text
                      .color(whiteColor)
                      .fontWeight(FontWeight.bold)
                      .make(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
