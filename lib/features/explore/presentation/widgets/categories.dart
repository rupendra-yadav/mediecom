import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/features/master/domain/entities/category_entity.dart';
import 'package:mediecom/features/master/presentation/pages/subcategory_page.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryEntity> cate;

  CategoryList({super.key, required this.cate});

  Color getRandomColor() {
    final random = Random();
    const colors = [
      Color(0xFFFFF3CD),
      Color(0xFFFFE4E1),
      Color(0xFFD7F9F7),
      Color(0xFFDCE7FF),
      Color(0xFFFFF2F2),
      Color(0xFFE9F8E5),
      Color(0xFFE3F2FD),
      Color(0xFFFCE4EC),
    ];
    return colors[random.nextInt(colors.length)];
  }

  /// icons IN SAME ORDER as your backend list
  final List<IconData> categoryIcons = [
    Iconsax.health5, // Diabetes essential
    Iconsax.magicpen5, // New age store
    Iconsax.brush_4, // Personal care
    Iconsax.activity, // Vitamins & supplements
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 130.h,
          color: Colours.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: cate.asMap().entries.map((entry) {
                final index = entry.key;
                final category = entry.value;

                return GestureDetector(
                  onTap: () {
                    context.push(SubcategoryPage.path);
                  },
                  child: Container(
                    width: 80.w,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [getRandomColor(), Colours.white],
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
                          categoryIcons[index % categoryIcons.length],
                          color: Colours.dark,
                          size: 22,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.m1Name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
