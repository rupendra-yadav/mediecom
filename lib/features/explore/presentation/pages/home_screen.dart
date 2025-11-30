import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediecom/core/common/widgets/safe_lottie_loader.dart';
import 'package:mediecom/core/constants/media_constants.dart';
import 'package:mediecom/core/extentions/text_style_extentions.dart';
import 'package:mediecom/core/services/routes/arguments/product_details.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/explore/presentation/bloc/product_bloc.dart';
import 'package:mediecom/features/explore/presentation/pages/add_prescriptions_page.dart';
import 'package:mediecom/features/explore/presentation/widgets/category_shimmers.dart';
import 'package:mediecom/features/explore/presentation/widgets/top_banner_shimmer.dart';
import 'package:mediecom/features/explore/presentation/pages/product_details.dart';
import 'package:mediecom/features/explore/presentation/widgets/categories.dart';
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
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<BannerBloc>().add(FetchBannerEvent());
    context.read<CategoryBloc>().add(FetchCategoryEvent());
    context.read<ProductBloc>().add(FetchProducts());

    // Listen to search controller changes
    _searchController.addListener(() {
      setState(() {
        _isSearching = _searchController.text.isNotEmpty;
      });

      // TODO: Add your search bloc event here when ready
      // if (_searchController.text.isNotEmpty) {
      //   context.read<SearchBloc>().add(SearchProducts(_searchController.text));
      // }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  XFile? _selectedImage;

  Future<dynamic> _onCallTapped() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colours.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final userMobile = "9303726071";
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // 📞 Call Button
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text("Call Us"),
                onTap: () {
                  // Launch dialer
                  // _launchDialer("9019008100");
                },
              ),

              // 💬 WhatsApp Button
              ListTile(
                leading: Image.asset(
                  "assets/images/whatsapp.png",
                  height: 20,
                  width: 20,
                ),
                title: const Text("Chat on WhatsApp"),
                onTap: () async {
                  // _openWhatsApp("+919303726071", "I have a query regrading...");
                },
              ),

              // 📧 Email Button
              ListTile(
                leading: const Icon(Icons.email, color: Colors.blue),
                title: const Text("Email Us"),
                onTap: () {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: 'helpdesk@omegafinancial.co.in',
                    query: 'subject=App%20Support%20Request',
                  );
                  // launchUrl(emailUri);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    // You'll need to provide these values or get them from your state management
    final String name = "User"; // Replace with actual user name
    final String address = "Your Address"; // Replace with actual address

    return Container(
      height: 161.h, // Adjust height as needed
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colours.primaryBackgroundColour,
            Colours.primaryBackgroundColour,
            Colours.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Name/Address + Notification
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, $name 👋",
                        style: const TextStyle(
                          color: Colours.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.location5,
                            size: 14,
                            color: Colours.primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(address, style: AppTextStyles.w400(10)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Make sure NotificationPage is imported
                    // context.push(NotificationPage.path);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Iconsax.notification, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Search Bar
            TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colours.white,
                enabled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colours.primaryColor,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colours.primaryColor,
                    width: 1.5,
                  ),
                ),
                hintText: "Search medicines, brands...",
                hintStyle: AppTextStyles.w600(14),
                prefixIcon: const Icon(
                  Iconsax.search_normal,
                  color: Colors.grey,
                ),
                suffixIcon: _isSearching
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          _searchFocusNode.unfocus();
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Results for "${_searchController.text}"',
            style: AppTextStyles.w700(16).black,
          ),
          SizedBox(height: 16.h),

          // TODO: Replace this with your actual search results from bloc
          // BlocBuilder<SearchBloc, SearchState>(
          //   builder: (context, state) {
          //     if (state is SearchLoading) {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //     if (state is SearchLoaded) {
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         physics: NeverScrollableScrollPhysics(),
          //         itemCount: state.results.length,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             title: Text(state.results[index].name),
          //             onTap: () {
          //               // Navigate to product detail
          //             },
          //           );
          //         },
          //       );
          //     }
          //     return Center(child: Text('No results found'));
          //   },
          // ),

          // Placeholder for now
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.search_normal, size: 64, color: Colors.grey[400]),
                SizedBox(height: 16.h),
                Text(
                  'Searching for products...',
                  style: AppTextStyles.w600(14),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Search results will appear here',
                  style: AppTextStyles.w400(12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        BlocBuilder<BannerBloc, BannerState>(
          builder: (context, state) {
            if (state is BannerSuccess) {
              final data = state.banners;
              return TopBannerCarousel(imageUrls: data);
            }
            if (state is BannerLoading) {
              return TopBannerShimmer();
            }
            return SizedBox.shrink();
          },
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Text("Quick Actions", style: AppTextStyles.w700(16).black),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 135.h,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push(UploadPrescriptionPage.path),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade50,
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
                            style: AppTextStyles.w800(12).primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: _onCallTapped,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade50,
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
                          style: AppTextStyles.w800(12).primary,
                        ),
                      ],
                    ),
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
                "Most Popular category",
                style: AppTextStyles.w700(16).black,
              ),
            ],
          ),
        ),

        SizedBox(height: 8.h),

        //  start from here
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategorySuccess) {
              final data = state.categories;
              return CategoryList(cate: data);
            }
            if (state is CategoryLoading) {
              return CategoryShimmer();
            }
            return SizedBox.shrink();
          },
        ),
        SizedBox(height: 8.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140.h),
        child: _buildAppBar(),
      ),
      backgroundColor: Colours.secondaryBackgroundColour,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: _isSearching ? _buildSearchResults() : _buildHomeContent(),
        ),
      ),
    );
  }
}
