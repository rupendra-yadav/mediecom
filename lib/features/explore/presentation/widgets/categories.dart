import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mediecom/core/style/app_colors.dart';

class CategoryList extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "Medicines",
      "icon": Iconsax.health5,
      "color": Color(0xFFFFF3CD), // light yellow
    },
    {
      "name": "Health Care",
      "icon": Iconsax.heart5,
      "color": Color(0xFFFFE4E1), // light pink
    },
    {
      "name": "Vitamins",
      "icon": Iconsax.activity,
      "color": Color(0xFFD7F9F7), // light teal
    },
    {
      "name": "Devices",
      "icon": Iconsax.cpu,
      "color": Color(0xFFDCE7FF), // light blue
    },
    {
      "name": "Baby Care",
      "icon": Iconsax.health5,
      "color": Color(0xFFFFF2F2), // soft rose
    },
    {
      "name": "Ayurvedic",
      "icon": Iconsax.health5,
      "color": Color(0xFFE9F8E5), // light green
    },
  ];

  CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colours.white, // soft yellow background
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: categories.map((category) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        category["color"],
                        // category["color"],
                        Colours.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        category["icon"],
                        color: Colors.amber[700],
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category["name"],
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Container(
          height: 50,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.yellow.shade50,
            border: Border.all(color: Colors.yellow, width: 1.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(child: Text("View All")),
        ),
      ],
    );
  }
}
