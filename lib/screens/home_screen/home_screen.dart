import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/lists.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/home_controller.dart';
import 'package:rokastore/screens/home_screen/categories_screen/categories_details.dart';
import 'package:rokastore/screens/home_screen/categories_screen/item_details.dart';
import 'package:rokastore/screens/home_screen/search_screen.dart';
import 'package:rokastore/services/firestore_services.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            //search
            Container(
              color: lightGrey,
              alignment: Alignment.center,
              child: TextFormField(
                controller: controller.searchController,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value) {
                  if (value.isNotEmptyAndNotNull) {
                    Get.to(
                      () => SearchScreen(
                        title: controller.searchController.text,
                      ),
                    );
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.5),
                    borderSide: BorderSide.none,
                  ),
                  hintText: search,
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(
                        () => SearchScreen(
                          title: controller.searchController.text,
                        ),
                      );
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                ),
              ),
            ).box.margin(const EdgeInsets.only(top: 10)).make(),

            (context.screenHeight / 100).heightBox,

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //swiper for ads
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: 'إعلانات'.text.semiBold.size(22).make(),
                    // ),

                    // Container(
                    //   width: context.screenWidth,
                    //   height: context.screenHeight * 0.25,
                    //   padding: const EdgeInsets.all(10),
                    //   margin: const EdgeInsets.symmetric(horizontal: 10),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: Colors.grey[300],
                    //     boxShadow: const [
                    //       BoxShadow(color: Colors.black, blurRadius: 0.2),
                    //     ],
                    //   ),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       'اعلن معنا'.text.size(30).bold.make(),
                    //       'ضع صورة / فيديو لإعلانك هنا'.text.make(),
                    //     ],
                    //   ),
                    // ),
                    // (context.screenHeight / 100).heightBox,
                    // VxSwiper.builder(
                    //   autoPlay: true,
                    //   autoPlayInterval: const Duration(
                    //     seconds: 2,
                    //   ),
                    //   height: context.screenHeight / 3,
                    //   itemCount: 5,
                    //   itemBuilder: (context, index) => Container(
                    //     width: context.screenWidth,
                    //     padding: const EdgeInsets.all(10),
                    //     margin: const EdgeInsets.symmetric(horizontal: 10),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.grey[300],
                    //       boxShadow: const [
                    //         BoxShadow(color: Colors.black, blurRadius: 0.2),
                    //       ],
                    //     ),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         'اعلن معنا'.text.size(30).bold.make(),
                    //         'ضع صورة لإعلانك هنا'.text.make(),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // (context.screenHeight / 100).heightBox,

                    //featured products
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.5),
                        color: redColor,
                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text.semiBold.white.size(22).make(),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor),
                                    ),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return 'لا توجد منتجات مميزة'
                                      .text
                                      .size(16)
                                      .semiBold
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;

                                  return Row(
                                    children: List.generate(
                                      featuredData.length,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            featuredData[index]['p_images'],
                                            width: context.screenWidth / 2,
                                            height: context.screenHeight / 4,
                                            fit: BoxFit.cover,
                                          ).box.makeCentered(),
                                          (context.screenHeight / 20).heightBox,
                                          '${featuredData[index]['p_name']}'
                                              .text
                                              .maxLines(1)
                                              .overflow(TextOverflow.ellipsis)
                                              .semiBold
                                              .make(),
                                          '${featuredData[index]['p_price']}'
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
                                          .width(context.screenWidth * 0.5)
                                          .white
                                          .roundedSM
                                          .padding(const EdgeInsets.all(8))
                                          .margin(const EdgeInsets.all(8))
                                          .make()
                                          .onTap(() {
                                        Get.to(
                                          () => ItemDetails(
                                            title:
                                                '${featuredData[index]['p_name']}',
                                            data: featuredData[index],
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    (context.screenHeight / 100).heightBox,

                    //swiper for products
                    Align(
                      alignment: Alignment.centerRight,
                      child: 'منتجات'.text.semiBold.size(22).make(),
                    ),

                    StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            ),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return 'لا يوجد منتجات'.text.make();
                        } else {
                          var data = snapshot.data!.docs;

                          return VxSwiper.builder(
                            autoPlay: true,
                            autoPlayInterval: const Duration(
                              seconds: 2,
                            ),
                            height: context.screenHeight / 3,
                            itemCount: data.length,
                            itemBuilder: (context, index) => Image.network(
                              data[index]['p_images'],
                              width: context.screenWidth,
                              fit: BoxFit.contain,
                            )
                                .box
                                .white
                                .roundedSM
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .make(),
                          );
                        }
                      },
                    ),

                    (context.screenHeight / 100).heightBox,

                    // categories
                    Align(
                      alignment: Alignment.centerRight,
                      child: 'فئات'.text.semiBold.size(22).make(),
                    ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        itemCount: categoriesTitlesList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          mainAxisExtent: context.screenHeight * 0.2,
                        ),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              child: Image.asset(
                                categoriesImagesList[index],
                                width: context.screenWidth / 4,
                                // fit: BoxFit.cover,
                              ),
                            ),
                            (context.screenHeight / 20).heightBox,
                            categoriesTitlesList[index]
                                .text
                                .align(TextAlign.center)
                                .maxLines(2)
                                .overflow(TextOverflow.ellipsis)
                                .make(),
                          ],
                        ).box.roundedSM.white.p8.make().onTap(() {
                          Get.to(
                            () => CategoriesDetails(
                                title: categoriesTitlesList[index]),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
