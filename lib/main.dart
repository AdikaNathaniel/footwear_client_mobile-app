import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../pages/login_page.dart';
import '../controller/purchase_controller.dart';
import '../controller/login_controller.dart';
import '../controller/home_controller.dart';
import '../firebase_option.dart';
import 'constants.dart';
import 'stripe_configure.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
   Stripe.publishableKey = 'pk_test_51Ql8Us4GUh5P0VNWFj1S5Fk5aP2hN9YE0pXPqvdV7IvmkLQurgeYB7lfO2m31qLnVjy7HFSz21HsuRK5ecrSSgu700Bt9em69W';

      if (!kIsWeb){
   Stripe.publishableKey = "pk_test_51Ql8Us4GUh5P0VNWFj1S5Fk5aP2hN9YE0pXPqvdV7IvmkLQurgeYB7lfO2m31qLnVjy7HFSz21HsuRK5ecrSSgu700Bt9em69W";
     }

  //  Stripe.init(stripePublishableKey);
  await Firebase.initializeApp(options: firebaseOptions);
  Get.put(LoginController());
  Get.put(HomeController());
  Get.put(PurchaseController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: LoginPage(),
      home: StripePaymentScreen(),
    );
  }
}
