import 'package:example_example/app/modules/home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        // height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Welcom to The simple Wight Tracker App ,\n Please Login :)",
                textAlign: TextAlign.center,
                style: GoogleFonts.adventPro(
                  fontSize: 30.0,
                  color: Color.fromARGB(167, 15, 11, 11),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            GetBuilder<LoginController>(
              init: LoginController(),
              initState: (_) {},
              builder: (controller) {
                return Center(
                  child: controller.isLoggedIn.value
                      ? ElevatedButton(
                          onPressed: () {
                            controller.login().then((value) {
                              if (value.runtimeType == UserCredential) {
                                Get.off(() => HomeView());
                              } else {}
                            });
                          },
                          child: Text(
                            'Login Please',
                            style: GoogleFonts.adventPro(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
