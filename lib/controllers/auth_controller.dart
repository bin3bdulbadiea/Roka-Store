import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/firebase_const.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // text controllers

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // login method

  Future<UserCredential?> loginMethod(context) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // storing data method
  storeUserData({name, email, phone, address, password}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);

    store.set({
      'id': currentUser!.uid,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'password': password,
    });
  }

  // signout method
  Future<void> signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
