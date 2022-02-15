import 'dart:convert';
import 'dart:ffi';

import 'package:example_example/app/data/wight_model.dart';
import 'package:example_example/app/modules/login/controllers/login_controller.dart';
import 'package:example_example/app/modules/login/views/login_view.dart';
import 'package:example_example/app/routes/app_pages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final wightTextEditingController = TextEditingController();
  final RxBool error = false.obs;
  final RxBool logoutError = false.obs;
  final RxBool isLoading = false.obs;
  RxList<dynamic> wightsList = [].obs;
  // FirebaseDatabase database = FirebaseDatabase.instance;
  late LoginController loginController;
  late FirebaseDatabase database;
  late DatabaseReference ref;
  late Stream<DatabaseEvent> stream;

  @override
  void onInit() {
    loginController = Get.find();
    wightTextEditingController.addListener(() async {});
    database = FirebaseDatabase.instance;
    ref = FirebaseDatabase.instance.ref("wights");
    stream = ref.onValue;
    // getFromDataBase();
    print("THIS IS DATA ${ref.path}");
    super.onInit();
  }

  void storeToDataBase(String wight) async {
    WightModel wightModel =
        WightModel(wight: wight, dateTime: DateTime.now().toString());
    await ref.set(wightModel.toJson());
  }

  void getFromDataBase() async {
    stream = ref.onValue;
    stream.listen((DatabaseEvent event) {
      // for (var element in event.snapshot.children) {
      //   print(element.value);
      // }
      for (var e in event.snapshot.children) {
        print(e);
      }

      // // wightsList.forEach((element) {
      // //   print("WIGHT LIST ${element.wight} || ${element.dateTime}");
      // // });

      // print('Event Type: ${event.type}'); // DatabaseEventType.value;
      // print(
      //     'Snapshot: ${WightModel.fromJson(event.snapshot.value.toString())}'); // DataSnapshot
    });
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
        Get.off(() => LoginView());
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
