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

class ProductDetailPage extends StatefulWidget {
  static const path = '/product-details';
  const ProductDetailPage({super.key, required this.tag, required this.data});

  final String tag;
  final ProductEntity data;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _pageController = PageController(viewportFraction: 0.93);
  int _pageIndex = 0;
  // simple expand/collapse state for sections
  final Map<String, bool> _expanded = {
    'Description': false,
    'Ingredients': false,
    'Usage Instructions': false,
    'Side Effects': false,
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Color get primaryGreen => const Color(0xFF25A96E);
  Color get paleGreen => const Color(0xFFE9F9EF);
  Color get palePeach => const Color(0xFFFFF3EA);
  Color get orangeTag => const Color(0xFFFFA77A);

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final price = (data.M1_AMT2 ?? 00).toString();
    final oldPrice = (data.M1_AMT1 ?? 00).toString();
    final name = data.M1_NAME ?? 'Paracetamol';
    final subtitle = data.M1_CST ?? '500mg - 30 Tablets';
    final images = List<String>.from(data.image);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 12.0),
        //     child: IconButton(
        //       icon: const Icon(Icons.favorite_border, color: Colors.black),
        //       onPressed: () {},
        //     ),
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            // padding: const EdgeInsets.fromLTRB(16, 80, 16, 140),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image carousel with rounded corners
                _buildImageCarousel(images),

                const SizedBox(height: 10),

                // // dots indicator
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: List.generate(images.length, (i) {
                //     final bool active = i == _pageIndex;
                //     return AnimatedContainer(
                //       duration: const Duration(milliseconds: 200),
                //       margin: const EdgeInsets.symmetric(horizontal: 4),
                //       width: active ? 26 : 8,
                //       height: 8,
                //       decoration: BoxDecoration(
                //         color: active ? primaryGreen : Colors.grey.shade300,
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //     );
                //   }),
                // ),
                const SizedBox(height: 12),
                // Prescription tag
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: palePeach,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.description,
                            size: 16,
                            color: Color(0xFFDF7A4C),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Prescription Required',
                            style: TextStyle(
                              color: const Color(0xFFDF7A4C),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Title & subtitle
                Text(name, style: AppTextStyles.w800(22)),
                const SizedBox(height: 6),
                Text(subtitle, style: AppTextStyles.w600(14)),

                const SizedBox(height: 12),
                // Price row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: paleGreen,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Rs $price/-',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: primaryGreen,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Rs $oldPrice/-',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colours.secondaryColor.o10,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.category_2,
                        size: 16,
                        color: Colours.secondaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${data.category_name}',
                        style: TextStyle(
                          color: Colours.secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                // Sections (expandable)
                ExpandableTile(
                  title: 'Description',
                  content: data.M1_ADD1 ?? 'No description available.',
                ),
                ExpandableTile(
                  title: 'Ingredients',
                  content:
                      data.M1_ADD2 ??
                      'Not specified.', // using ADD2 if available, else fallback
                ),
                ExpandableTile(
                  title: 'Usage Instructions',
                  content: data.M1_ADD2 ?? 'Follow directions on the pack.',
                ),
                ExpandableTile(
                  title: 'Side Effects',
                  content:
                      data.M1_ADD2 ??
                      'Contact a physician if you experience any adverse effects.',
                ),
                const SizedBox(height: 20),

                // // Customer Reviews header
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Text(
                //       'Customer Reviews',
                //       style: TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.w700,
                //       ),
                //     ),
                //     TextButton(onPressed: () {}, child: const Text('See All')),
                //   ],
                // ),
                // const SizedBox(height: 10),
                // // Rating card
                // Container(
                //   padding: const EdgeInsets.all(14),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(12),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.shade200,
                //         blurRadius: 8,
                //         offset: const Offset(0, 4),
                //       ),
                //     ],
                //   ),
                //   child: Row(
                //     children: [
                //       // Big rating number
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             '4.8',
                //             style: TextStyle(
                //               fontSize: 32,
                //               fontWeight: FontWeight.w800,
                //               color: Colors.black87,
                //             ),
                //           ),
                //           const SizedBox(height: 4),
                //           Text(
                //             'out of 5',
                //             style: TextStyle(color: Colors.grey.shade600),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(width: 18),
                //       // Stars and text
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Row(
                //               children: List.generate(
                //                 5,
                //                 (i) => Icon(
                //                   Icons.star,
                //                   size: 18,
                //                   color: Colors.amber,
                //                 ),
                //               ),
                //             ),
                //             const SizedBox(height: 6),
                //             Text(
                //               'Based on 125 Reviews',
                //               style: TextStyle(color: Colors.grey.shade700),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 18),
                // // Individual reviews
                // _buildSingleReview(
                //   'Works great for headaches!',
                //   'Jane D. - 2 weeks ago',
                //   5,
                // ),
                // _divider(),
                // _buildSingleReview(
                //   'Good value for the price.',
                //   'John S. - 1 month ago',
                //   4,
                // ),
                // const SizedBox(height: 30),
              ],
            ),
          ),
          // subtle top background pale color to match screenshot
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   height: 140,
          //   child: Container(color: Colors.white),
          // ),
        ],
      ),

      // Bottom Bar with two actions
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(AddToCart(item: widget.data));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Added to cart'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: primaryGreen,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: paleGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide.none,
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2BA56A),
                    ),
                  ),
                ),
              ),
              // const SizedBox(width: 12),
              // Expanded(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // buy now
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: primaryGreen,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       padding: const EdgeInsets.symmetric(vertical: 16),
              //     ),
              //     child: const Text(
              //       'Buy Now',
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w800,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider({double height = 12}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.5),
      child: Divider(height: 1, color: Colors.grey.shade300),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildExpandable(String key, String content) {
    final isOpen = _expanded[key] ?? false;
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _expanded[key] = !(isOpen)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    content,
                    maxLines: isOpen ? 20 : 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
                Transform.rotate(
                  angle: (isOpen ? math.pi : 0),
                  child: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
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
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: img.isEmpty
                    ? Container(color: Colors.grey.shade200)
                    : Image.network(
                        ApiConstants.productBase + img,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
              ),
            );
          },
          options: CarouselOptions(
            height: 220,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enableInfiniteScroll: safeImages.length > 1,
            onPageChanged: (index, reason) {
              setState(() => _pageIndex = index);
            },
          ),
        ),

        const SizedBox(height: 8),

        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(safeImages.length, (index) {
            final bool active = index == _pageIndex;
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: active ? 26 : 8,
                decoration: BoxDecoration(
                  color: active ? Colors.green : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSingleReview(String title, String meta, int stars) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              stars,
              (i) => const Icon(Icons.star, size: 18, color: Colors.amber),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            meta,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
