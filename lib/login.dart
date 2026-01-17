import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
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
          Text("LOGIN", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: passC,
                obscureText: loginC.isSeen.value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon:
                      // loginC.isSeen.value
                      //     ? IconButton(onPressed: () => loginC.isSeen.toggle(), icon: Icon(Icons.visibility))
                      //     : IconButton(onPressed: () => loginC.isSeen.toggle(), icon: Icon(Icons.visibility_off)),

                    IconButton(onPressed: () => loginC.isSeen.toggle(), icon: loginC.isSeen.value ?  Icon(Icons.visibility_off) : Icon(Icons.visibility) )
                ),
              ),
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
