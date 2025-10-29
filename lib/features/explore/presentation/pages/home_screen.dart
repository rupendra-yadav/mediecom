import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
