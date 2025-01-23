import 'package:client_app/controller/login_controller.dart';
import 'package:client_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/otp_txt_field.dart'; // Adjust the path as necessary

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create Your Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ctrl.registerNameCtrl,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Full Name',
                  hintText: 'Enter Your Full Name',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.phone,
                controller: ctrl.registerNumberCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.phone_android),
                  labelText: 'Mobile number',
                  hintText: 'Enter Your Phone number',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Enter Your Email',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  hintText: 'Enter Your Password',
                ),
              ),
              const SizedBox(height: 20),
              OtpTextField(
                  otpController: ctrl.otpController,
                  visible: ctrl.otpFieldShown, onComplete:(otp){
                    ctrl.otpEnter = int.tryParse(otp ?? '0000');
                  }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (ctrl.otpFieldShown) {
                    ctrl.addUser();
                  } else {
                    ctrl.sendOtp();
                  }
                  //Initially ctrl.addUser();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(103, 58, 183, 1),
                ),
                child: Text(ctrl.otpFieldShown ? 'Register' : 'Send OTP'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.to(LoginPage());
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
