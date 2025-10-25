import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediecom/core/extentions/text_style_extentions.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/explore/presentation/widgets/categories.dart';
import 'package:mediecom/features/explore/presentation/widgets/gradient_appBar.dart';
import 'package:mediecom/features/explore/presentation/widgets/products.dart';
import 'package:mediecom/features/explore/presentation/widgets/top_banners.dart';

class HomeScreen extends StatelessWidget {
  static const path = '/home-screen';
  const HomeScreen({super.key});

  final List<String> imageUrls = const [
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              TopBannerCarousel(imageUrls: imageUrls),

              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      "Most Popular category",
                      style: AppTextStyles.karala16w800.black,
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16.sp),
                  ],
                ),
              ),
              SizedBox(height: 8.h),

              CategoryList(),

              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      "Flash Sales Today",
                      style: AppTextStyles.karala16w800.black,
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16.sp),
                  ],
                ),
              ),
              SizedBox(height: 8.h),

              Products(products: imageUrls),
            ],
          ),
        ),
      ),
    );
  }
}
