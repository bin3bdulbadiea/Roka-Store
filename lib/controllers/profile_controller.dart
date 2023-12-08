import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/firebase_const.dart';

class ProfileController extends GetxController {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var addressController = TextEditingController();

  var passwordController = TextEditingController();

  var newPasswordController = TextEditingController();

  var retypeNewPasswordController = TextEditingController();

  var isLoading = false.obs;

  updateProfile({name, email, phone, address, password}) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);

    await store.set(
      {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'password': password,
      },
      SetOptions(merge: true),
    );
    isLoading(false);
  }

  changePassword({email, oldPassword, newPassword}) async {
    final cred = EmailAuthProvider.credential(
      email: email,
      password: oldPassword,
    );

    await currentUser!.reauthenticateWithCredential(cred).then(
      (value) {
        currentUser!.updatePassword(
          newPassword,
        );
      },
    );
  }
}
