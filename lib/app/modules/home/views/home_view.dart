import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';

import 'package:intl/intl.dart';

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
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
                      SizedBox(
                        width: 5.0,
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GetX<HomeController>(
                        //autoRemove: false,
                        //assignId: false,
                        init: HomeController(),
                        initState: (state) {
                          controller.wightsList;
                        },
                        builder: (_) {
                          return controller.wightsList.isEmpty
                              ? Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.wightsList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      shadowColor: Colors.black87,
                                      elevation: 1.5,
                                      margin: EdgeInsets.all(5.0),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color:
                                                Color.fromARGB(167, 15, 11, 11),
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.edit,
                                          color:
                                              Color.fromARGB(167, 15, 11, 11),
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Date & Time : ${DateFormat('yyyy-MM-dd  kk:mm').format(DateTime.parse(controller.wightsList[index].dateTime))}',
                                              textAlign: TextAlign.justify,
                                              style: GoogleFonts.adventPro(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              'Wight : ${controller.wightsList[index].wight} KG.',
                                              textAlign: TextAlign.justify,
                                              style: GoogleFonts.adventPro(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: GestureDetector(
                                          onTap: (() => controller.deleteWight(
                                              controller
                                                  .wightsList[index].wight)),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
