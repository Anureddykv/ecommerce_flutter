import 'package:ecommerce/views/banner_slider.dart';
import 'package:ecommerce/views/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_notifier.dart';
import 'flash_scrren.dart';
import 'header_section.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final productsAsync = ref.watch(productsProvider);
    final selectedTab = ref.watch(selectedTabProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(),
              BannerSlider(),
            // Category Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Category", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("See All", style: TextStyle(fontSize: 14, color: Colors.brown)),
                ],
              ),
            ),
        categoriesAsync.when(
          data: (categories) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 16,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: categories.map((category) => CategoryItem(category: category)).toList(),
            ),
          ),
          loading: () => Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error loading categories")),
        ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Flash Sale", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text("Closing in : ", style: TextStyle(fontSize: 14, color: Colors.grey)),
                      _buildTimer(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            FlashSaleTabs(),
            SizedBox(height: 16,),
            Expanded(
              child: productsAsync.when(
                data: (products) {
                  final filteredProducts = _filterProducts(products, selectedTab);
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.7, // Controls height vs width
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: filteredProducts[index]);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const Center(child: Text("Error loading products")),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTimer() {
    return Row(
      children: [
        _timerBox("02"),
        Text(" : ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        _timerBox("12"),
        Text(" : ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        _timerBox("56"),
      ],
    );
  }

  Widget _timerBox(String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }


  List<Map<String, dynamic>> _filterProducts(List<Map<String, dynamic>> products, int selectedTab) {
    switch (selectedTab) {
      case 1:
        return products.where((product) => product["isNewest"] == true).toList();
      case 2:
        return products.where((product) => product["isPopular"] == true).toList();
      case 3:
        return products.where((product) => product["category"] == "men's clothing").toList();
      case 4:
        return products.where((product) => product["category"] == "women's clothing").toList();
      default:
        return products; // Show all products
    }

  }

}
class CategoryItem extends StatelessWidget {
  final String category;

  const CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.brown.withOpacity(0.1),
            ),
            child: Center(
              child: Icon(
                _getCategoryIcon(category),
                size: 30,
                color: Colors.brown,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            _capitalize(category),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "men's clothing":
        return Icons.checkroom;
      case "women's clothing":
        return Icons.woman;
      case "electronics":
        return Icons.electrical_services;
      case "jewelery":
        return Icons.diamond;
      default:
        return Icons.category;
    }
  }

  String _capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false; // 🔹 Track favorite state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(productId: widget.product["id"]),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: 150,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2),
            ],
          ),
          child: Stack(
            children: [
              /// 🔹 Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.product['image'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),

              /// 🔹 Heart Icon Button (Toggles on Click)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite; // 🔹 Toggle favorite state
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2),
                      ],
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border, // 🔹 Toggle icon
                      color: isFavorite ? Colors.red : Colors.brown, // 🔹 Toggle color
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
