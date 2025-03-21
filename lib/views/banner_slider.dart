import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _currentIndex = 0;

  final List<IconData> _bannerIcons = [
    Icons.electrical_services,
    Icons.diamond,
    Icons.male,
    Icons.female,
  ];

  final List<String> _bannerTitles = [
    "Electronics Sale",
    "Luxury Jewelry",
    "Men's Fashion",
    "Women's Fashion",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _bannerIcons.asMap().entries.map((entry) {
            int index = entry.key;
            IconData icon = entry.value;

            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // Background container instead of image
                  Container(
                    width: double.infinity,
                    color: Colors.brown.withOpacity(0.1), // Background color
                  ),

                  // Aligning the Icon to the Right
                  Align(
                    alignment: Alignment.centerRight, // Moves the icon to the right
                    child: Padding(
                      padding: EdgeInsets.only(right: 20), // Adjust spacing
                      child: Icon(icon, size: 80, color: Colors.brown), // Large Icon
                    ),
                  ),

                  // Text & Button Overlay (on the left)
                  Positioned(
                    left: 20,
                    top: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _bannerTitles[index], // Dynamic Title
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Exclusive deals available now!",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          icon: Icon(Icons.shopping_cart, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {},
                          label: Text("Shop Now", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            );
          }).toList(),
        ),
        SizedBox(height: 10),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _bannerIcons.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == entry.key ? Colors.brown : Colors.grey[300],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
