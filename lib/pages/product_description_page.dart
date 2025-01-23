import 'package:flutter/material.dart';

class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details',
        style: TextStyle(
          fontWeight: FontWeight.bold
        )), ),
      body:SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://www.bing.com/images/search?view=detailV2&ccid=vLzIPjw0&id=39DCD5C6D92D1433B9F111F79B7FA26D047CD078&thid=OIP.vLzIPjw0JtJQ0U4m4e3irwHaHp&mediaurl=https%3a%2f%2fwallpapers.com%2fimages%2fhd%2fshoes-pictures-8b5z09bebjp4g8wm.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.bcbcc83e3c3426d250d14e26e1ede2af%3frik%3deNB8BG2if5v3EQ%26pid%3dImgRaw%26r%3d0&exph=1500&expw=1453&q=images+of+shoes&simid=608045118176888987&FORM=IRPRST&ck=0F5DD7368D6A9FCFA38DFB99F10F5081&selectedIndex=4&itb=0',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
            ),
            const SizedBox(height: 20),
            Text(
              'Puma Footwears',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Product Description',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Price: \$99.99',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
                maxLines: 3,
                decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Enter Your Billing Address',
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Buy Now',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                // Add your onPressed code here!
              },
            ),
          )  
          ],
        ),
      ),
    );
  }
}
