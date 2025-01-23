import 'package:client_app/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../model/user/user.dart';
import '../widgets/otp_txt_field.dart';
import 'dart:math';
import 'package:client_app/widgets/otp_txt_field.dart'; 
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();
  TextEditingController loginNumberCtrl = TextEditingController();

  OtpFieldControllerV2 otpController = OtpFieldControllerV2();

  bool otpFieldShown = false;
  int? otpSend;
  int? otpEnter;
  User? loginUser;

  @override
  void onReady() {
    Map<String, dynamic>? user = box.read('LoginUser');

    if (user != null) {
      loginUser = User.fromJson(user);
      Get.to(const HomePage());
    }
    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  addUser() {
    try {
      if (registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty) {
        Get.snackbar('Error', 'Please Fill The Fields', colorText: Colors.red);
        return;
      }

      if (otpSend == otpEnter) {
        Get.snackbar('Success', 'OTP Verified Successfully', colorText: Colors.green);
        DocumentReference doc = userCollection.doc();

        User user = User(
          id: doc.id,
          name: registerNameCtrl.text,
          number: int.parse(registerNumberCtrl.text),
        );

        final userJson = user.toJson();
        doc.set(userJson);
        Get.snackbar('Success', 'User added successfully', colorText: Colors.green);
        registerNumberCtrl.clear();
        registerNameCtrl.clear();
        otpController.clear();
      } else {
        Get.snackbar('Error', 'OTP Is Incorrect', colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print('Failed to add user: $e');
    }
  }

  sendOtp() {
    try {
      if (registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty) {
        Get.snackbar('Error', 'Please Fill The Fields', colorText: Colors.red);
        return;
      }
      final random = Random();
      int otp = 1000 + random.nextInt(9000);

      print(otp);

      if (otp != null) {
        otpFieldShown = true;
        otpSend = otp;
        Get.snackbar('Success', 'OTP Sent Successfully', colorText: Colors.green);
      } else {
        Get.snackbar('Error', 'OTP Not Sent', colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print('Failed to send OTP: $e');
    } finally {
      update();
    }
  }

  Future<void> loginWithPhone() async {
    try {
      String phoneNumber = loginNumberCtrl.text;

      if (phoneNumber.isNotEmpty) {
        var querySnapshot = await userCollection
            .where('number', isEqualTo: int.tryParse(phoneNumber))
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;

          box.write('LoginUser', userData);
          loginNumberCtrl.clear();
          Get.to(const HomePage());

          Get.snackbar('Success', 'Login Successful', colorText: Colors.green);
        } else {
          Get.snackbar('Error', 'User Not Found, please register', colorText: Colors.red);
        }
      }
    } catch (error) {
      Get.snackbar('Error', error.toString(), colorText: Colors.red);
      print('Failed to login: $error');
    }
  }
}