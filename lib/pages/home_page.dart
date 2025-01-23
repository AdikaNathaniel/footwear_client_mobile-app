import 'package:client_app/pages/login_page.dart';
import 'package:client_app/widgets/multi_select_drop_down.dart';
import 'package:client_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import '../widgets/drop_down_btn.dart';
import '../controller/home_controller.dart';
import '../pages/product_description_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Footwear Store',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  GetStorage box = GetStorage();
                  box.erase();
                  Get.offAll(const LoginPage());
                },
                icon: const Icon(Icons.logout),
              )
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6),
                      child: Chip(label: Text('Category $index')),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  DropDownBtn(
                    items: ['Rs: Low to High', 'Rs: High to Low'],
                    selectedItemText: 'Sort',
                    onSelected: (selected) {},
                  ),
                  Flexible(
                    child: MultiSelectDropDown(
                      items: ['Item 1', 'Item 2', 'Item 3'],
                      onSelectionChanged: (selectedItems) {
                        // Handle selection change
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Reduced from 8 for better mobile view
                    //Change back to 8 if it is not suitable
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: ctrl.products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      name: ctrl.products[index].name ?? 'No name',
                      imageUrl: ctrl.products[index].image ?? 'url',
                      price: ctrl.products[index].price ?? 0,
                      offerTag: '20% off',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ProductDescriptionPage(),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
