import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mediecom/core/extentions/text_style_extentions.dart';
import 'package:mediecom/core/services/routes/arguments/product_details.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/explore/domain/entities/featured_entity..dart';
import 'package:mediecom/features/explore/domain/entities/product_entity.dart';
import 'package:mediecom/features/explore/presentation/pages/product_details.dart';
import 'package:mediecom/features/explore/presentation/widgets/categories.dart';
import 'package:mediecom/features/explore/presentation/widgets/products.dart';

// Main Featured Widget
class FeaturedWidget extends StatefulWidget {
  final FeaturesEntity feature;
  const FeaturedWidget({super.key, required this.feature});

  @override
  State<FeaturedWidget> createState() => _FeaturedWidgetState();
}

class _FeaturedWidgetState extends State<FeaturedWidget> {
  @override
  Widget build(BuildContext context) {
    final Color sectionBgColor = _getBackgroundColorForType(
      widget.feature.lname,
    );

    // Check if it's a category section
    if (widget.feature.lname == "ProductCategory") {
      return Container(
        color: sectionBgColor,
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // Section Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    widget.feature.name,
                    style: AppTextStyles.w700(16).black,
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16.sp),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // Category List - Horizontal scroll
            SizedBox(
              height: 120.h,
              // child: ListView.separated(
              //   padding: EdgeInsets.symmetric(horizontal: 16.w),
              //   physics: BouncingScrollPhysics(),
              //   scrollDirection: Axis.horizontal,
              //   itemCount: widget.feature.categories!.length,
              //   itemBuilder: (context, index) {
              //     final category = widget.feature.categories![index];
              //     // return _buildCategoryCard(context, category);
              //   },
              //   separatorBuilder: (BuildContext context, int index) {
              //     return SizedBox(width: 12.w);
              //   },
              // ),
              child: CategoryList(cate: widget.feature.categories!),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      );
    }

    // Check if it's a product section
    if (widget.feature.lname == "Product") {
      return Container(
        color: sectionBgColor,
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // Section Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    widget.feature.name,
                    style: AppTextStyles.w700(16).black,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      // Navigate to see all products
                    },
                    child: Row(
                      children: [
                        Text("See All", style: AppTextStyles.w600(14).primary),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14.sp,
                          color: Colours.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // Product Grid
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                mainAxisSpacing: 12,
                crossAxisSpacing: 10,
              ),
              itemCount: widget.feature.products?.length,
              itemBuilder: (context, index) {
                final ProductEntity product = widget.feature.products![index];
                return GestureDetector(
                  onTap: () {
                    context.push(
                      ProductDetailPage.path,
                      extra: ProductDetailsArgs(
                        tag: "featured_product_$index",
                        cate: product,
                      ),
                    );
                  },
                  // child: _buildProductCard(product, index),
                  child: ProductCard(data: product, index: index),
                );
              },
            ),
          ],
        ),
      );
    }

    return SizedBox.shrink();
  }

  // Build Category Card
  Widget _buildCategoryCard(
    BuildContext context,
    Map<String, dynamic> category,
  ) {
    final String categoryName = category['M1_NAME'] ?? 'Category';
    final String categoryImage = category['M1_DC1'] ?? '';

    return GestureDetector(
      onTap: () {
        // Navigate to category page
        // You can pass the category data here
      },
      child: Container(
        width: 100.w,
        decoration: BoxDecoration(
          color: Colours.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Category Image
            if (categoryImage.isNotEmpty)
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colours.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.network(
                    categoryImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.category,
                        color: Colours.primaryColor,
                        size: 30.sp,
                      );
                    },
                  ),
                ),
              ).animate().fadeIn(duration: 500.ms)
            else
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colours.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.category,
                  color: Colours.primaryColor,
                  size: 30.sp,
                ),
              ),

            SizedBox(height: 8.h),

            // Category Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                categoryName,
                style: AppTextStyles.w600(12).black,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Product Card
  Widget _buildProductCard(Map<String, dynamic> product, int index) {
    final String productName = product['M1_NAME'] ?? 'Product';
    final String manufacturer = product['M1_LNAME'] ?? '';
    final String description = product['M1_ADD1'] ?? '';
    final String imageUrl = product['M1_DC1'] ?? '';
    final String mrp = product['M1_AMT2']?.toString() ?? '0';
    final String sellingPrice = product['M1_AMT1']?.toString() ?? '0';
    final String volume = product['M1_VAL']?.toString() ?? '';
    final String unit = product['M1_OP']?.toString() ?? '';

    // Calculate discount percentage
    double discountPercent = 0;
    if (mrp != '0' && sellingPrice != '0') {
      final mrpValue = double.tryParse(mrp) ?? 0;
      final sellingValue = double.tryParse(sellingPrice) ?? 0;
      if (mrpValue > 0) {
        discountPercent = ((mrpValue - sellingValue) / mrpValue) * 100;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colours.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Stack(
            children: [
              Container(
                height: 140.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.medication,
                              size: 50.sp,
                              color: Colors.grey,
                            );
                          },
                        ).animate().fadeIn(duration: 500.ms)
                      : Icon(Icons.medication, size: 50.sp, color: Colors.grey),
                ),
              ),

              // Discount Badge
              if (discountPercent > 0)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${discountPercent.toStringAsFixed(0)}% OFF',
                      style: AppTextStyles.w700(10).white,
                    ),
                  ),
                ),
            ],
          ),

          // Product Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    productName,
                    style: AppTextStyles.w700(14).black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 4.h),

                  // Manufacturer
                  if (manufacturer.isNotEmpty)
                    Text(
                      manufacturer,
                      style: AppTextStyles.w400(11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  // Volume
                  if (volume.isNotEmpty && unit.isNotEmpty)
                    Text(
                      '$volume $unit',
                      style: AppTextStyles.w500(11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  Spacer(),

                  // Price Section
                  Row(
                    children: [
                      // Selling Price
                      Text(
                        '₹$sellingPrice',
                        style: AppTextStyles.w800(16).primary,
                      ),

                      SizedBox(width: 6.w),

                      // MRP (strikethrough)
                      if (mrp != sellingPrice && mrp != '0')
                        Text(
                          '₹$mrp',
                          style: AppTextStyles.w500(12).copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: 32.h,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add to cart logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colours.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Add to Cart',
                        style: AppTextStyles.w600(12).white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper function to get background color based on lname
Color _getBackgroundColorForType(String type) {
  switch (type) {
    case 'ProductCategory':
      return Colours.white;
    case 'Product':
      return Colours.secondaryBackgroundColour;
    default:
      return Colours.white;
  }
}
