import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Location
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.brown),
                  SizedBox(width: 5),
                  Text(
                    "New York, USA",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                ],
              ),

              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.notifications, color: Colors.black54),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            children: [
              // Search Field
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search, color: Colors.brown),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10),

              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.brown,
                child: Icon(Icons.tune, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
