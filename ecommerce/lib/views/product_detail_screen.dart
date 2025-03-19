import 'package:ecommerce/views/product_image_galary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_details_notifier.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final int productId;

  const ProductDetailsScreen({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  String selectedSize = 'S';
  Color selectedColor = Colors.brown;

  @override
  Widget build(BuildContext context) {
    final productDetailsAsync = ref.watch(productDetailsProvider(widget.productId));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Color(0xFFF5ECE3),
          elevation: 0,
          title: Text(
            "Product Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.favorite_border, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: productDetailsAsync.when(
        data: (product) => Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product["image"],
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              ProductImageGallery(imageUrls: [
                product["image"],
                "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
                "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg",
                "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg"
              ]),

              /// Product Info with Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product["category"],
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      SizedBox(width: 4),
                      Text(
                        "4.5",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                product["title"],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              /// Product Details
              Text(
                "Product Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                product["description"],
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              SizedBox(height: 15),

              /// Select Size
              Text(
                "Select Size",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: ["S", "M", "L", "XL", "XXL", "XXXL"].map((size) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSize = size;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: selectedSize == size ? Colors.brown : Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          size,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: selectedSize == size ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 15),

              /// Select Color
              Text(
                "Select Color",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Colors.brown.shade200,
                  Colors.brown.shade300,
                  Colors.brown.shade400,
                  Colors.brown.shade500,
                  Colors.brown,
                  Colors.black,
                ].map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                        border: Border.all(
                          color: selectedColor == color ? Colors.black : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error loading product details")),
      ),
      bottomNavigationBar: productDetailsAsync.when(
        data: (product) => Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product["price"].toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Add to cart functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                label: Text("Add to Cart", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
        loading: () => SizedBox(height: 60, child: Center(child: CircularProgressIndicator())),
        error: (err, stack) => SizedBox(height: 60, child: Center(child: Text("Error loading price"))),
      ),
    );
  }
}
