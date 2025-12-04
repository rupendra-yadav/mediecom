import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mediecom/core/extentions/text_style_extentions.dart';
import 'package:mediecom/core/services/routes/arguments/product_details.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:mediecom/features/cart/presentation/blocs/cart_event.dart';
import 'package:mediecom/features/cart/presentation/blocs/cart_state.dart';
import 'package:mediecom/features/explore/domain/entities/featured_entity..dart';
import 'package:mediecom/features/explore/domain/entities/product_entity.dart';
import 'package:mediecom/features/explore/presentation/pages/product_details.dart';
import 'package:mediecom/features/explore/presentation/widgets/categories.dart';
import 'package:mediecom/features/master/presentation/pages/subcategory_page.dart';

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

    final products = widget.feature.products ?? [];

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
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // Category List - Horizontal scroll
            SizedBox(
              height: 120.h,
              child: CategoryList(cate: widget.feature.categories ?? []),
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
                    onTap: () => context.push(SubcategoryPage.path),
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

            // Products grid with synced quantities
            BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                return GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final ProductEntity product = products[index];
                    final quantity = cartState.quantities[product.M1_CODE] ?? 0;

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
                      child: _buildProductCard(
                        context: context,
                        data: product,
                        quantity: quantity,
                        index: index,
                      ),
                    );
                  },
                );
              },
            ),

            SizedBox(height: 100.h),
          ],
        ),
      );
    }

    return SizedBox.shrink();
  }

  // Product card builder function (same pattern as subcategory page)
  Widget _buildProductCard({
    required BuildContext context,
    required ProductEntity data,
    required int quantity,
    required int index,
  }) {
    double originalPrice = double.tryParse(data.M1_AMT1 ?? '0') ?? 0;
    double discountedPrice = double.tryParse(data.M1_AMT2 ?? '0') ?? 0;

    int discountPercent = 0;
    if (originalPrice > 0 && discountedPrice > 0) {
      discountPercent =
          (((originalPrice - discountedPrice) / originalPrice) * 100).round();
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE SECTION
              Stack(
                children: [
                  Hero(
                    tag: "featured_product_$index",
                    child: Container(
                      height: 140.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [const Color(0xFFF8F9FA), Colors.grey[100]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: data.image.isNotEmpty
                                ? data.image[0]
                                : "",
                            fit: BoxFit.contain,
                            errorWidget: (context, url, error) => Center(
                              child: Icon(
                                Iconsax.box,
                                size: 48.sp,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // DISCOUNT BADGE
                  if (discountPercent > 0)
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                          ),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFEF4444).withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          "$discountPercent% OFF",
                          style: AppTextStyles.w700(
                            11,
                          ).copyWith(color: Colors.white, letterSpacing: 0.5),
                        ),
                      ),
                    ),
                ],
              ),

              // PRODUCT DETAILS
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.M1_NAME ?? "Medicine Name",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.w700(
                          14,
                        ).copyWith(color: const Color(0xFF1A1A1A), height: 1.3),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.M1_LNAME ?? "Manufacturer",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.w500(
                          12,
                        ).copyWith(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.M1_CST ?? "Type",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.w500(
                          12,
                        ).copyWith(color: Colors.grey[600]),
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0FDF4),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "₹${data.M1_AMT2 ?? '0'}",
                              style: AppTextStyles.w700(
                                16,
                              ).copyWith(color: const Color(0xFF10B981)),
                            ),
                          ),
                          const SizedBox(width: 6),
                          if (originalPrice > discountedPrice)
                            Text(
                              "₹${data.M1_AMT1}",
                              style: AppTextStyles.w500(12).copyWith(
                                color: Colors.grey[500],
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.grey[500],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // CART BUTTON / QUANTITY CONTROL
        Positioned(
          bottom: 8,
          right: 8,
          child: _buildCartButton(context, data, quantity),
        ),
      ],
    );
  }

  // Cart button builder
  Widget _buildCartButton(
    BuildContext context,
    ProductEntity data,
    int quantity,
  ) {
    if (quantity == 0) {
      return InkWell(
        onTap: () {
          print('🔵 Add to cart tapped: ${data.M1_CODE}');
          context.read<CartBloc>().add(AddToCart(item: data));
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     behavior: SnackBarBehavior.floating,
          //     backgroundColor: Colours.primaryColor,
          //     content: Row(
          //       children: [
          //         const Icon(Icons.check_circle, color: Colours.white),
          //         SizedBox(width: 8.w),
          //         Text(
          //           '${data.M1_NAME} Added to cart',
          //           style: AppTextStyles.w600(
          //             14,
          //           ).copyWith(color: Colours.white),
          //         ),
          //       ],
          //     ),
          //     duration: const Duration(seconds: 2),
          //   ),
          // );
        },
        child: Container(
          height: 35,
          width: 35,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colours.primaryColor,
          ),
          child: const Icon(Iconsax.add, color: Colours.white, size: 18),
        ),
      );
    } else {
      return Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colours.primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                print('🔵 Decrease quantity: ${data.M1_CODE}');
                context.read<CartBloc>().add(
                  UpdateQuantity(
                    productCode: data.M1_CODE ?? '',
                    quantity: quantity - 1,
                  ),
                );
              },
              child: const SizedBox(
                width: 32,
                height: 35,
                child: Center(
                  child: Icon(Iconsax.minus, color: Colours.white, size: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "$quantity",
                style: AppTextStyles.w700(14).copyWith(color: Colours.white),
              ),
            ),
            InkWell(
              onTap: () {
                print('🔵 Increase quantity: ${data.M1_CODE}');
                context.read<CartBloc>().add(
                  UpdateQuantity(
                    productCode: data.M1_CODE ?? '',
                    quantity: quantity + 1,
                  ),
                );
              },
              child: const SizedBox(
                width: 32,
                height: 35,
                child: Center(
                  child: Icon(Iconsax.add, color: Colours.white, size: 16),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

// Helper function to get background color based on lname
Color _getBackgroundColorForType(String type) {
  switch (type) {
    case 'ProductCategory':
      return Colours.primaryBackgroundColour;
    case 'Product':
      return Colours.secondaryBackgroundColour;
    default:
      return Colours.white;
  }
}
