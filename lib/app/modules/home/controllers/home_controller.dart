import 'dart:ffi';

import 'package:example_example/app/modules/login/controllers/login_controller.dart';
import 'package:example_example/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final wightTextEditingController = TextEditingController();
  final RxBool error = false.obs;
  final RxBool logoutError = false.obs;
  final RxBool isLoading = false.obs;
  late LoginController loginController;

  @override
  void onInit() {
    loginController = Get.find();
    wightTextEditingController.addListener(() async {});
    super.onInit();
  }

  Future<void> logout() async {
    isLoading.toggle();
    update();
    await loginController.auth.signOut().then((value) {
      isLoading.toggle();
      update();
    });

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print("THIS");
      if (user == null) {
        logoutError.isFalse;
        update();
      } else {
        logoutError.isTrue;
        update();
      }
    });
  }

  bool isNumeric(String result) {
    if (result.isEmpty) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
