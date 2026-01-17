import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final email = ''.obs;
  final pass = ''.obs;
  final _auth = FirebaseAuth.instance;
  final isSeen = true.obs;

  Future<void> login({required String email, required String pass}) async {
    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e){
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
