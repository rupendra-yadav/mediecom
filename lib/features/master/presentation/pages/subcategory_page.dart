import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/explore/presentation/widgets/gradient_appBar.dart';

class SubcategoryPage extends StatefulWidget {
  static const path = '/sub_category';
  const SubcategoryPage({super.key});

  @override
  State<SubcategoryPage> createState() => _SubcategoryPageState();
}

class _SubcategoryPageState extends State<SubcategoryPage> {
  int selectedIndex = 0; // 👈 tracks selected category index

  final List<String> categories = [
    "Ticks & Flea",
    "Skin & Coat Care",
    "Joint Care",
    "Digestive Aid",
    "Liver Care",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GradientAppBar(
        name: "Pet Supplements",
        address: "",
        isUserName: false,
        leading: true,
      ),

      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text("Pet Supplements", style: AppTextStyles.karala12w800),
      //   actions: const [
      //     Icon(Iconsax.search_normal, color: Colors.black, size: 22),
      //     SizedBox(width: 12),

      //     SizedBox(width: 12),
      //   ],
      // ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side categories
          Container(
            width: 90.w,
            color: const Color(0xFFF8F8F8),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index; // 👈 updates selection
                    });
                  },
                  child: _buildCategoryItem(categories[index], isSelected),
                );
              },
            ),
          ),

          // Right side product list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  // Sort & Filter row
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _sortFilterButton(Iconsax.sort, "Sort"),
                      SizedBox(width: 4.w),
                      _sortFilterButton(Iconsax.filter, "All filters"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Product Cards
                  _buildProductCard(
                    imageUrl:
                        "https://m.media-amazon.com/images/I/61Isdg+63+L._SL1500_.jpg",
                    title: "ClearKill -IMX Spot On for Dogs 10–25kg",
                    subtitle: "2.5 ml Liquid\nGet by Fri, 31 Oct",
                    price: "₹548",
                    originalPrice: "₹563",
                    discount: "3% off",
                    offerPrice: "₹493",
                  ),
                  _buildProductCard(
                    imageUrl:
                        "https://m.media-amazon.com/images/I/71jvxftHc2L._SL1500_.jpg",
                    title: "ClearKill SMT Spot On for Dogs 20.1–40Kg",
                    subtitle: "2 ml Liquid\nGet by Fri, 31 Oct",
                    price: "₹855",
                    originalPrice: "₹900",
                    discount: "5% off",
                    offerPrice: "₹770",
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String name, bool selected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        border: selected
            ? const Border(left: BorderSide(color: Colors.purple, width: 3))
            : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.purple : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sortFilterButton(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String imageUrl,
    required String title,
    required String subtitle,
    required String price,
    required String originalPrice,
    required String discount,
    required String offerPrice,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  width: 80,
                  height: 80,
                  "assets/burger_hero.png",
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      originalPrice,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black45,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      discount,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "$offerPrice order for ₹1200",
                  style: const TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 80,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.deepOrange),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "ADD",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
