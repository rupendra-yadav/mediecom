import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mediecom/core/constants/api_constants.dart';
import 'package:mediecom/core/extentions/color_extensions.dart';
import 'package:mediecom/core/extentions/text_style_extentions.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:mediecom/features/cart/presentation/blocs/cart_event.dart';
import 'package:mediecom/features/explore/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity data;
  final int index;

  const ProductCard({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext ctx) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38.o10),
            borderRadius: BorderRadius.circular(12),
            color: Colours.white,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: "product_$index",
                    child: Padding(
                      padding: const EdgeInsets.all(8),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          height: 133.h,
                          width: double.infinity,
                          imageUrl: data.image.isNotEmpty
                              ? "${data.image[0]}"
                              : "",

                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) => Container(
                            height: 100.h,
                            width: double.infinity,
                            color: Colors.grey,
                            child: Icon(
                              Iconsax.image,
                              size: 40.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
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

                        // InkWell(
                        //   onTap: () {},
                        //   borderRadius: BorderRadius.circular(12),
                        //   child: Container(
                        //     padding: const EdgeInsets.all(5),
                        //     decoration: const BoxDecoration(
                        //       color: Colors.white,
                        //       shape: BoxShape.circle,
                        //     ),
                        //     child: const Icon(Iconsax.heart, size: 15),
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  // Positioned(
                  //   bottom: 4,
                  //   right: 4,
                  //   child: Container(
                  //     height: 30,
                  //     width: 50,
                  //     decoration: BoxDecoration(
                  //       color: Colours.white,
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(8),
                  //         bottomLeft: Radius.circular(-8),
                  //       ),
                  //     ),
                  //     child: Text("data"),
                  //   ),
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.M1_NAME ?? "Medicine Name",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.w800(14),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      data.M1_CST ?? "Manufacturer",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.w500(12),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Rs ${data.M1_AMT1}/-",
                      style: AppTextStyles.w500(
                        10,
                      ).grey.copyWith(decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFE6F7EC,
                        ), // soft mint green / matches that “discount tag” style
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Rs ${data.M1_AMT2 ?? '0'}/-",
                        style: AppTextStyles.w800(14).green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 7,
          right: 7,
          child: InkWell(
            onTap: () {
              ctx.read<CartBloc>().add(AddToCart(item: data));

              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colours.white,
                  content: Text(
                    '${data.M1_NAME} Added to cart',
                    style: TextStyle(color: Colours.primaryColor),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
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
          ),
        ),
      ],
    );
  }
}
