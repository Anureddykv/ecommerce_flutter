import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.home,
      Icons.shopping_bag_outlined,
      Icons.favorite_border,
      Icons.chat_bubble_outline,
      Icons.person_outline,
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF1E1E24), // Dark background color
          borderRadius: BorderRadius.circular(30), // Rounded shape
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            bool isSelected = currentIndex == index;
            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(8),
                decoration: isSelected
                    ? BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                )
                    : null,
                child: Icon(
                  icons[index],
                  size: 24,
                  color: isSelected ? Colors.brown : Colors.grey[400],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
