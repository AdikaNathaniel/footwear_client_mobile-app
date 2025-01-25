import 'package:client_app/controller/login_controller.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/user/user.dart';
import '../pages/home_page.dart';

class PurchaseController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference orderCollection;

  TextEditingController addressController = TextEditingController();

  double orderPrice = 0;
  String itemName = '';
  String orderAddress = '';

  @override
  void onInit() {
    orderCollection = firestore.collection('orders');
    super.onInit();
  }

  submitOrder(
      {required double price,
      required String item,
      required String description}) {
    orderPrice = price;
    itemName = item;
    orderAddress = addressController.text;

    // Razorpay was used but we will use Stripe

    // Razorpay razorpay = Razorpay();

    // var options = {
    // 'key': '',  Gotten from razorpay
    // 'amount' : price * 100,
    // 'name'  : item,
    // 'description' : description;

    // }  This code was taken from pub.dev

    //There's a payment successful and payment error function -- Call orderSuccess() in the payment successful method
    //Use a get.snackbar to say paymenet was successful
  }

  Future<void> orderSuccess({required String? transactionId}) async {
    User? loginUse = Get.find<LoginController>().loginUser;
    try{
      if(transactionId != null){
        DocumentReference docRef = await orderCollection.add({
          'customer': loginUse?.name ?? '',
          'phone': loginUse?.number ?? '',
          'item': itemName,
          'price': orderPrice,
          'address': orderAddress,
          'transactionId': transactionId,
          'dateTime':DateTime.now().toString(),
        });
        print('Order Created Successfully : ${docRef.id}');
        showOrderSuccessDialog(docRef.id);
        Get.snackbar('Success', 'Order Created Successfully',colorText: Colors.green);
      }else{
        Get.snackbar('Error', 'Please fill all fields!',colorText: Colors.red);
      }
    }catch(error){
      Get.snackbar('Error', 'Failed to create order', colorText: Colors.red);
    }
  }

   void showOrderSuccessDialog(String orderId){
    Get.defaultDialog(
      title: 'Order Success',
      content: Text("Your Order Id is $orderId"),
      confirm: ElevatedButton(
        onPressed: () {
          Get.off(const HomePage());
        },
         child: const Text('Close'),
         )
    );
   }
}
