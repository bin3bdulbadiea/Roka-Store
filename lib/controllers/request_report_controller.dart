// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rokastore/consts/firebase_const.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

class RequestAndReportController extends GetxController {
  var descController = TextEditingController();

  // images to request product & report on problem
  var isLoading = false.obs;

  var imagePath = ''.obs;

  var imageLink = '';

  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (img == null) return;
      imagePath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // logic to REQUEST PRODUCT

  uploadImageInRequestProduct() async {
    var fileName = basename(imagePath.value);
    var destination = 'requests/${currentUser!.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imagePath.value));
    imageLink = await ref.getDownloadURL();
  }

  storeImageInRequestProduct({img, desc}) async {
    var store = firestore.collection(requestsCollection).doc();

    await store.set({
      'added_by': currentUser!.uid,
      'added_by_email': currentUser!.email,
      'image': img,
      'description': desc,
    });

    isLoading(false);
  }

  // logic to REPORT PROBLEM

  uploadImageInReportProblem() async {
    var fileName = basename(imagePath.value);
    var destination = 'reports/${currentUser!.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imagePath.value));
    imageLink = await ref.getDownloadURL();
  }

  storeImageInReportProblem({img, desc}) async {
    var store = firestore.collection(reportsCollection).doc();

    await store.set({
      'added_by': currentUser!.uid,
      'added_by_email': currentUser!.email,
      'image': img,
      'description': desc,
    });

    isLoading(false);
  }

  // logic to SUGGEST

  uploadImageInSuggest() async {
    var fileName = basename(imagePath.value);
    var destination = 'suggests/${currentUser!.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imagePath.value));
    imageLink = await ref.getDownloadURL();
  }

  storeImageInSuggest({img, desc}) async {
    var store = firestore.collection(suggestsCollection).doc();

    await store.set({
      'added_by': currentUser!.uid,
      'added_by_email': currentUser!.email,
      'image': img,
      'description': desc,
    });

    isLoading(false);
  }
}
