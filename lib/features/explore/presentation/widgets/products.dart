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
                      imageUrl: data.image.isNotEmpty
                          ? "${ApiConstants.productBase}${data.image[0]}"
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
                            decoration: const BoxDecoration(
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
                      data.M1_NAME ?? "Medicine Name",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.karala12w800,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      data.M1_CST ?? "Manufacturer",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.karala12w300,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Rs ${data.M1_AMT1 ?? '0'}/-",
                      style: AppTextStyles.karala14w800.green,
                    ),
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
