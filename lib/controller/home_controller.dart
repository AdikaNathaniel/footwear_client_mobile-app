import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product/product.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference productCollection;

  List<Product> products = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();

      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Success', 'Products fetched successfully',
          colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print('Failed to fetch products: $e');
    } finally {
      update();
    }
  }
}
