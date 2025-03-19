import 'package:flutter/material.dart';

class ProductImageGallery extends StatelessWidget {
  final List<String> imageUrls;

  const ProductImageGallery({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(imageUrls.length > 5 ? 5 : imageUrls.length, (index) {
            if (index == 4 && imageUrls.length > 5) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  _buildImage(imageUrls[index]),
                  Container(
                    width:50,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "+${imageUrls.length - 5}",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );
            }
            return _buildImage(imageUrls[index]);
          }),
        ),
      ),
    );
  }

  /// 🔹 Helper Method to Create Rounded Image Widgets
  Widget _buildImage(String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          url,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey[200], // Just for preview
      body: Center(
        child: ProductImageGallery(imageUrls: [
          "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
          "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg",
          "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
          "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
          "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
          "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
        ]),
      ),
    ),
  ));
}
