import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mediecom/core/extentions/color_extensions.dart';
import 'package:mediecom/core/extentions/text_style_extentions.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/explore/presentation/pages/product_details.dart';

class Products extends StatelessWidget {
  const Products({super.key, required this.products});
  final List<Map<String, dynamic>> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(
                  tag: "product_$index",
                  data: products[index],
                ),
              ),
            );
          },
          child: buildProductCard(products[index], index),
        );
      },
    );
  }
}

Widget buildProductCard(Map<String, dynamic> data, int index) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          // color: Colors.red,
          border: Border.all(color: Colors.black38.o10),
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: "product_$index",
                  child: CachedNetworkImage(
                    height: 100.h,
                    width: double.infinity,
                    imageUrl: data['image'],
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent.withOpacity(0.4),
                              blurRadius: 4,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          "4% off",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Iconsax.heart, size: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['drugName'] ?? "Medicine Name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.karala12w800,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    data['manufacturer'] ?? "Medicine Name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.karala12w300,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Rs ${data['price'].toString()}/-" ?? "",
                    style: AppTextStyles.karala14w800.green,
                  ),
                  // Text("Medicine Name"),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 4,
        right: 4,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colours.primaryColor,
              // shape: BoxShape.circle,
            ),
            child: const Icon(Iconsax.add, color: Colours.white, size: 18),
          ),
        ),
      ),
    ],
  );
}
