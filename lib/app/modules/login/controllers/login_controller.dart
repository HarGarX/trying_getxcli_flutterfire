import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  FirebaseAuth auth = FirebaseAuth.instance;

  final isLoggedIn = true.obs;
  @override
  void onInit() {
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //     isLoggedIn.toggle();
    //   } else {
    //     print('User is signed in!');
    //     isLoggedIn.toggle();
    //   }
    // });

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<UserCredential> login() async {
    isLoggedIn.toggle();
    update();
    UserCredential user = await auth.signInAnonymously();
    await Future.delayed(Duration(seconds: 3));
    if (user.user != null) {
      print(user);
      isLoggedIn.toggle();
      update();
    } else {
      isLoggedIn.toggle();
      update();
    }
    return user;
  }

  @override
  void onClose() {}
}
