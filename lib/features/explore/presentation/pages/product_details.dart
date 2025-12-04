import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mediecom/core/constants/api_constants.dart';
import 'package:mediecom/core/extentions/color_extensions.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:mediecom/features/cart/presentation/blocs/cart_event.dart';
import 'dart:math' as math;

import 'package:mediecom/features/explore/domain/entities/product_entity.dart';
import 'package:mediecom/features/explore/presentation/widgets/expandable_information.dart';
import 'package:mediecom/features/explore/presentation/widgets/gradient_appBar.dart';

class ProductDetailPage extends StatefulWidget {
  static const path = '/product-details';
  const ProductDetailPage({super.key, required this.tag, required this.data});

  final String tag;
  final ProductEntity data;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(viewportFraction: 0.93);
  int _pageIndex = 0;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Color get primaryGreen => const Color(0xFF25A96E);
  Color get paleGreen => const Color(0xFFE9F9EF);
  Color get palePeach => const Color(0xFFFFF3EA);
  Color get lightGreenBg => const Color(0xFFF5FDF9);

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final price = (data.M1_AMT2 ?? 00).toString();
    final oldPrice = (data.M1_AMT1 ?? 00).toString();
    final name = data.M1_NAME ?? 'Paracetamol';
    final subtitle = data.M1_CST ?? '500mg - 30 Tablets';
    final images = List<String>.from(data.image);

    // Calculate discount percentage
    final discount = data.M1_AMT1 != null && data.M1_AMT2 != null
        ? (((double.parse(data.M1_AMT1!) - double.parse(data.M1_AMT2!)) /
                      double.parse(data.M1_AMT1!)) *
                  100)
              .round()
        : 0;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: GradientAppBar(
        name: name,
        address: "address",
        isUserName: false,
        leading: true,
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   scrolledUnderElevation: 0,
      //   title: const Text(
      //     'Product Details',
      //     style: TextStyle(
      //       fontSize: 18,
      //       fontWeight: FontWeight.w700,
      //       color: Colors.black87,
      //     ),
      //   ),
      //   leading: Container(
      //     margin: const EdgeInsets.all(8),
      //     decoration: BoxDecoration(
      //       color: Colors.grey.shade100,
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //     child: IconButton(
      //       icon: const Icon(
      //         Icons.arrow_back_ios_new,
      //         color: Colors.black87,
      //         size: 20,
      //       ),
      //       onPressed: () => Navigator.of(context).pop(),
      //     ),
      //   ),
      //   actions: [
      //     Container(
      //       margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
      //       decoration: BoxDecoration(
      //         color: Colors.grey.shade100,
      //         borderRadius: BorderRadius.circular(12),
      //       ),
      //       child: IconButton(
      //         icon: const Icon(Iconsax.share, color: Colors.black87, size: 22),
      //         onPressed: () {},
      //       ),
      //     ),
      //   ],
      // ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image carousel with enhanced styling
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _buildImageCarousel(images),
              ),

              const SizedBox(height: 12),

              // Main content card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tags row
                      Row(
                        children: [
                          _buildPrescriptionTag(),
                          const SizedBox(width: 8),
                          if (discount > 0) _buildDiscountBadge(discount),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Title & subtitle
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Iconsax.box,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Price card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [paleGreen, lightGreenBg],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: primaryGreen.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '₹$price',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                          color: primaryGreen,
                                          height: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 4,
                                        ),
                                        child: Text(
                                          '₹$oldPrice',
                                          style: TextStyle(
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness: 2,
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: primaryGreen,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.verify5,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'In Stock',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Category badge
                      _buildCategoryBadge(data.category_name ?? 'Medicine'),

                      const SizedBox(height: 24),

                      // Sections header
                      Text(
                        'Product Information',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Expandable sections with enhanced design
                      _buildEnhancedExpandableTile(
                        icon: Iconsax.document_text,
                        title: 'Description',
                        content: data.M1_ADD1 ?? 'No description available.',
                      ),
                      const SizedBox(height: 12),
                      _buildEnhancedExpandableTile(
                        icon: Iconsax.health,
                        title: 'Ingredients',
                        content: data.M1_ADD2 ?? 'Not specified.',
                      ),
                      const SizedBox(height: 12),
                      _buildEnhancedExpandableTile(
                        icon: Iconsax.clipboard_tick,
                        title: 'Usage Instructions',
                        content:
                            data.M1_ADD2 ?? 'Follow directions on the pack.',
                      ),
                      const SizedBox(height: 12),
                      _buildEnhancedExpandableTile(
                        icon: Iconsax.warning_2,
                        title: 'Side Effects',
                        content:
                            data.M1_ADD2 ??
                            'Contact a physician if you experience any adverse effects.',
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Enhanced bottom bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(AddToCart(item: widget.data));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Iconsax.tick_circle5, color: Colors.white),
                            const SizedBox(width: 12),
                            const Text(
                              'Added to cart successfully',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: primaryGreen,
                        duration: const Duration(seconds: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: primaryGreen.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.shopping_cart, size: 22),
                      const SizedBox(width: 10),
                      const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrescriptionTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: palePeach,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDF7A4C).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Iconsax.document_text5,
            size: 16,
            color: Color(0xFFDF7A4C),
          ),
          const SizedBox(width: 6),
          const Text(
            'Rx Required',
            style: TextStyle(
              color: Color(0xFFDF7A4C),
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountBadge(int discount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade400, Colors.red.shade600],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '$discount% OFF',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colours.secondaryColor.withOpacity(0.1),
            Colours.secondaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colours.secondaryColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Iconsax.category5, size: 18, color: Colours.secondaryColor),
          const SizedBox(width: 8),
          Text(
            category,
            style: TextStyle(
              color: Colours.secondaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedExpandableTile({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryGreen, size: 20),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel(List<String> images) {
    final CarouselSliderController _carouselController =
        CarouselSliderController();
    final safeImages = (images.isEmpty) ? [''] : images;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: safeImages.length,
          itemBuilder: (context, index, realIndex) {
            final img = safeImages[index];
            return Hero(
              tag: 'product_${widget.tag}_$index',
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: img.isEmpty
                      ? Container(
                          color: Colors.grey.shade100,
                          child: Center(
                            child: Icon(
                              Iconsax.gallery,
                              size: 60,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        )
                      : Image.network(
                          // ApiConstants.productBase + img,
                          img,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade100,
                              child: Center(
                                child: Icon(
                                  Iconsax.gallery,
                                  size: 60,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 280,
            viewportFraction: 0.85,
            enlargeCenterPage: true,
            enlargeFactor: 0.25,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enableInfiniteScroll: safeImages.length > 1,
            onPageChanged: (index, reason) {
              setState(() => _pageIndex = index);
            },
          ),
        ),

        const SizedBox(height: 16),

        // Enhanced dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(safeImages.length, (index) {
            final bool active = index == _pageIndex;
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: active ? 10 : 8,
                width: active ? 28 : 8,
                decoration: BoxDecoration(
                  gradient: active
                      ? LinearGradient(
                          colors: [primaryGreen, primaryGreen.withOpacity(0.7)],
                        )
                      : null,
                  color: active ? null : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: primaryGreen.withOpacity(0.4),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
