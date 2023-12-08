import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/firebase_const.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;

  var totalPrice = 0.obs;

  var isFav = false.obs;

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, qty, price, category, context}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'image': img,
      'quantity': qty,
      'price': price,
      'added_by': currentUser!.uid,
      'category': category,
    }).catchError((e) {
      VxToast.show(context, msg: e.toString());
    });
  }

  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set(
      {
        'p_wishlist': FieldValue.arrayUnion([currentUser!.uid]),
      },
      SetOptions(merge: true),
    );
    isFav(true);
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set(
      {
        'p_wishlist': FieldValue.arrayRemove([currentUser!.uid]),
      },
      SetOptions(merge: true),
    );
    isFav(false);
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
