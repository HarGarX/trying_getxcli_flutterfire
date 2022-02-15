import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: (() => controller.logout().then((value) {
                    if (controller.logoutError.isTrue) {
                      Get.snackbar(
                        "Error",
                        "Failed to logout , please try again",
                        icon: Icon(Icons.person, color: Colors.red),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  })),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.logout_outlined,
                  color: Color.fromARGB(167, 15, 11, 11),
                  size: 30.0,
                ),
              ),
            ),
          ],
          title: Text(
            'Wight Monitring',
            style: GoogleFonts.adventPro(
              fontSize: 30.0,
              color: Color.fromARGB(167, 15, 11, 11),
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          elevation: 0.0,
        ),
        body: GetBuilder<HomeController>(
          init: HomeController(),
          initState: (_) {},
          builder: (controller) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter Your Wight \n  ⚖️",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.adventPro(
                      fontSize: 26.0,
                      color: Color.fromARGB(167, 0, 0, 0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.wightTextEditingController,
                    onChanged: (value) {
                      //  await Future.delayed(Duration(milliseconds: 500));
                      if (controller.isNumeric(value)) {
                        print("is Int");
                        controller.error.value = false;
                        controller.update();
                      } else {
                        controller.error.value = true;
                        controller.update();
                      }
                    },
                    decoration: InputDecoration(
                      errorText: controller.error.isTrue
                          ? 'Please Enter A Valid Number'
                          : null,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(167, 15, 11, 11), width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(167, 15, 11, 11), width: 1.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.storeToDataBase(
                              controller.wightTextEditingController.text);
                          controller.wightTextEditingController.clear();
                        },
                        child: Text(
                          'Submit',
                          style: GoogleFonts.adventPro(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(170.0, 50.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.getFromDataBase();
                        },
                        child: Text(
                          'Show Data',
                          style: GoogleFonts.adventPro(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(170.0, 50.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FirebaseDatabaseListView(
                    query: controller.ref.orderByPriority(),
                    itemBuilder: (context, snapshot) {
                      Map<String, dynamic> user =
                          snapshot.value as Map<String, dynamic>;

                      return Text('User name is ${user['name']}');
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }
}
