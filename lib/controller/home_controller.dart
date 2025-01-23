import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product/product.dart';
import 'package:flutter/material.dart';
import '../model/product_category/product_category.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference productCollection;

  late CollectionReference categoryCollection;

  List<Product> products = [];
  List<ProductCategory> productCategories = [];
  List<Product> productShowInUI = [];

  @override
  Future<void> onInit() async {
    categoryCollection = firestore.collection('products');
    productCollection = firestore.collection('category');
    await fetchCategory();
    await fetchProducts();
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

  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();

      final List<ProductCategory> retrievedCategories = categorySnapshot.docs
          .map((doc) =>
              ProductCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      products.clear();
      productCategories.assignAll(retrievedCategories);
      // Get.snackbar('Success', 'Category fetched successfully',
      //     colorText: Colors.green);

      productShowInUI.assignAll(products);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print('Failed to fetch products: $e');
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
    productShowInUI.clear();
    productShowInUI =
        products.where((element) => element.category == category).toList();

    update();
  }

  filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      productShowInUI = products;
    }else{
      List<String> lowerCaseBrands = brands.map((brand) => brand.toLowerCase()).toList();
      productShowInUI = products.where((product) => lowerCaseBrands.contains(product.brand?.toLowerCase() ?? '')).toList();
    }
    update();   //This causes it to show in the UI
  }

    void sortByPrice({required bool ascending}) {
  List<Product> sortedProducts = List<Product>.from(productShowInUI);
  sortedProducts.sort((a, b) => ascending 
    ? a.price!.compareTo(b.price!) 
    : b.price!.compareTo(a.price!)
  );
  productShowInUI = sortedProducts;
  update();
}
}
