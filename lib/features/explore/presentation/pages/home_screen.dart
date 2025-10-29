import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mediecom/core/common/widgets/safe_lottie_loader.dart';
import 'package:mediecom/core/constants/media_constants.dart';
import 'package:mediecom/core/extentions/text_style_extentions.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/dummydata.dart';
import 'package:mediecom/features/explore/presentation/widgets/categories.dart';
import 'package:mediecom/features/explore/presentation/widgets/gradient_appBar.dart';
import 'package:mediecom/features/explore/presentation/widgets/products.dart';
import 'package:mediecom/features/explore/presentation/widgets/top_banners.dart';
import 'package:mediecom/features/master/presentation/blocs/banner/banner_bloc.dart';
import 'package:mediecom/features/master/presentation/blocs/category/category_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const path = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageUrls = const [
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
    "https://www.shutterstock.com/image-vector/medicine-vector-trendy-banner-design-260nw-644484853.jpg",
  ];

  @override
  void initState() {
    super.initState();
    context.read<BannerBloc>().add(FetchBannerEvent());
    context.read<CategoryBloc>().add(FetchCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            children: [
              BlocBuilder<BannerBloc, BannerState>(
                builder: (context, state) {
                  if (state is BannerSuccess) {
                    final data = state.banners;
                    return TopBannerCarousel(imageUrls: data);
                  }
                  return SizedBox.shrink();
                },
              ),

              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      "Most Popular category",
                      style: AppTextStyles.karala16w800.black,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),

              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategorySuccess) {
                    final data = state.categories;
                    return CategoryList(cate: data);
                  }
                  return SizedBox.shrink();
                },
              ),
              SizedBox(height: 8.h),

              SizedBox(
                height: 135.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade50,
                          border: Border.all(color: Colors.yellow, width: 1.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SafeLottie(
                              asset: AppMedia.lottiePresciption,
                              height: 50.h,
                              width: 50.h,
                            ),
                            Center(
                              child: Text(
                                "Order With\nPrescription",
                                style: AppTextStyles.karala12w800.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade50,
                          border: Border.all(color: Colors.yellow, width: 1.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SafeLottie(
                              asset: AppMedia.lottieCalling,
                              height: 50.h,
                              width: 50.h,
                            ),
                            Text(
                              "Call to order\nmedicine",
                              style: AppTextStyles.karala12w800.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      "Flash Sales Today",
                      style: AppTextStyles.karala16w800.black,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),

              Products(products: sampleMedicins),
            ],
          ),
        ),
      ),
    );
  }
}
