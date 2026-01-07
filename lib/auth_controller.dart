import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mustakim_snack/home_page.dart';
import 'package:mustakim_snack/login.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _auth.authStateChanges().listen(_handleLogin);
  }

  void _handleLogin(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.off(() => HomePage());
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
