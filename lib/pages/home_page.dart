import '../pages/login_page.dart';
import '../widgets/multi_select_drop_down.dart';
import '../widgets/product_card.dart';
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
        return RefreshIndicator(
          onRefresh: () async {
            ctrl.fetchProducts();          
          },
          child: Scaffold(
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
                  itemCount: ctrl.productCategories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ctrl.filterByCategory(ctrl.productCategories[index].name ?? 'Error');
                      },
                      child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Chip(label: Text(ctrl.productCategories[index].name ?? 'Error')),
                    )
                    );
                  },
                ),
              ),
              Row(
                children: [
                  DropDownBtn(
                    items: ['GH₵: Low to High', 'GH₵: High to Low'],
                    selectedItemText: 'Sort',
                    onSelected: (selected) {
                          ctrl.sortByPrice(ascending: selected == 'GH₵: Low to High' ? true : false);
                    },
                  ),
                  Flexible(
                    child: MultiSelectDropDown(
                      items: ['Boots', 'Beach Slides','Sneakers','High Heels'],
                      onSelectionChanged: (selectedItems) {
                         ctrl.filterByBrand(selectedItems);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: ctrl.products.length,   //ctrl.products.length
                  itemBuilder: (context, index) {
                    return ProductCard(
                      name: ctrl.productShowInUI[index].name ?? 'No name',
                      imageUrl: ctrl.productShowInUI[index].image ?? 'url',
                      price: ctrl.productShowInUI[index].price ?? 0,
                      offerTag: '20% off',
                      onTap: () {
                        Get.to(ProductDescriptionPage(),arguments: {'data': ctrl.productShowInUI[index]}); //Passing data to the next page
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ));
      },
    );
  }
}
