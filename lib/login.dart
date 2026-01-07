import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:mustakim_snack/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final passC = TextEditingController();
    final loginC = Get.put(LoginController());
    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Login"),
        const SizedBox(height: 20),
        TextField(
          controller: emailC,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 10),
        Obx(
          () => TextField(
            controller: passC,
            obscureText: loginC.isSeen.value,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => ElevatedButton(
            onPressed:
                loginC.isLoading.value
                    ? null
                    : () => loginC.login(
                      email: emailC.text.trim(),
                      pass: passC.text.trim(),
                    ),
            child:
                loginC.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
          ),
        ),
      ],
    ),
    );
  }
}
