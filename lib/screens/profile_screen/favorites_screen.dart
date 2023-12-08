import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/firebase_const.dart';
import 'package:rokastore/consts/fonts.dart';
import 'package:rokastore/screens/home_screen/categories_screen/item_details.dart';
import 'package:rokastore/services/firestore_services.dart';
import 'package:velocity_x/velocity_x.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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
        stream: FirestoreServices.getAllFavorites(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return 'لا توجد منتجات قمت بتفضيلها'.text.makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    '${data[index]['p_images']}',
                    width: context.screenWidth / 4,
                    fit: BoxFit.cover,
                  ),
                  title:
                      '${data[index]['p_name']}'.text.semiBold.size(16).make(),
                  subtitle: '${data[index]['p_price']}'
                      .toString()
                      .numCurrency
                      .text
                      .semiBold
                      .color(redColor)
                      .make(),
                  trailing: IconButton(
                    onPressed: () async {
                      firestore
                          .collection(productsCollection)
                          .doc(data[index].id)
                          .set({
                        'p_wishlist':
                            FieldValue.arrayRemove([currentUser!.uid]),
                      }, SetOptions(merge: true));
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: golden,
                    ),
                  ),
                  onTap: (() {
                    Get.to(
                      () => ItemDetails(
                          title: '${data[index]['p_name']}', data: data[index]),
                    );
                  }),
                );
              },
            );
          }
        },
      ),
    );
  }
}
