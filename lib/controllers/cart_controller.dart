import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/firebase_const.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  var addressController = TextEditingController();

  var phoneController = TextEditingController();

  late dynamic productSnapshot;

  var products = [];

  var placingOrder = false.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP = totalP + int.parse(data[i]['price'].toString());
    }
  }

  placeOrder({required totalAmount}) async {
    placingOrder(true);

    await getProductDetails();

    await firestore.collection(ordersCollection).doc().set({
      'order_code': Random().nextInt(1000000000),
      'order_by': currentUser!.uid,
      'order_date': FieldValue.serverTimestamp(),
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delevery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();

    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'title': productSnapshot[i]['title'],
        'image': productSnapshot[i]['image'],
        'category': productSnapshot[i]['category'],
        'quantity': productSnapshot[i]['quantity'],
        'price': productSnapshot[i]['price'],
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
