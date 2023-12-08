import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/screens/home_screen/categories_screen/item_details.dart';
import 'package:rokastore/services/firestore_services.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.title});
  final String? title;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'بحث عن : ${widget.title}'.text.make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProduct(widget.title),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return 'لا توجد منتجات'.text.semiBold.size(16).make();
          } else {
            var data = snapshot.data!.docs;

            var filtered = data
                .where(
                  (element) => element['p_name'].toString().contains(
                        widget.title!,
                      ),
                )
                .toList();

            return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: context.screenHeight * 0.4,
              ),
              children: filtered
                  .mapIndexed((currentValue, index) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              child: Image.network(
                                filtered[index]['p_images'],
                                width: context.screenWidth / 2,
                                fit: BoxFit.cover,
                              ).box.makeCentered(),
                            ),
                            (context.screenHeight / 20).heightBox,
                            '${filtered[index]['p_name']}'
                                .text
                                .maxLines(1)
                                .overflow(TextOverflow.ellipsis)
                                .semiBold
                                .make(),
                            '${filtered[index]['p_price']}'
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
                            .width(context.screenWidth * 0.5)
                            .roundedSM
                            .padding(const EdgeInsets.all(8))
                            .make()
                            .onTap(() {
                          Get.to(
                            () => ItemDetails(
                                title: '${filtered[index]['p_name']}',
                                data: filtered[index]),
                          );
                        }),
                      ))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
