import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';
import '../pages/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (ctrl) {
        return Scaffold(
          body: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: ctrl.loginNumberCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.phone_android),
                    labelText: 'Mobile number',
                    hintText: 'Enter Your Phone number',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ctrl.loginWithPhone();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.to(const RegisterPage());
                  },
                  child: const Text('Register new Account'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}