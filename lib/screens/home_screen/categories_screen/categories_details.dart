import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/product_controller.dart';
import 'package:rokastore/screens/home_screen/categories_screen/item_details.dart';
import 'package:rokastore/services/firestore_services.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoriesDetails extends StatefulWidget {
  const CategoriesDetails({super.key, required this.title});
  final String? title;

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: widget.title!.text.bold.size(20).white.make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getProducts(widget.title),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: noProductsFound.text.make(),
            );
          } else {
            var data = snapshot.data!.docs;

            return Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: context.screenHeight * 0.4,
                ),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Image.network(
                        data[index]['p_images'],
                        width: context.screenWidth / 2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    (context.screenHeight / 20).heightBox,
                    '${data[index]['p_name']}'
                        .text
                        .maxLines(2)
                        .overflow(TextOverflow.ellipsis)
                        .semiBold
                        .make(),
                    10.heightBox,
                    data[index]['p_price']
                        .toString()
                        .numCurrency
                        .text
                        .color(redColor)
                        .size(16)
                        .semiBold
                        .make(),
                  ],
                )
                    .box
                    .white
                    .roundedSM
                    .padding(const EdgeInsets.all(8))
                    .make()
                    .onTap(() {
                  controller.checkIfFav(data[index]);
                  Get.to(
                    () => ItemDetails(
                      title: '${data[index]['p_name']}',
                      data: data[index],
                    ),
                  );
                }),
              ),
            );
          }
        },
      ),
    );
  }
}
