import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediecom/core/extentions/text_style_extentions.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/cart/presentation/widgets/quantity_selector.dart';

class Cart extends StatelessWidget {
  static const path = '/cart';
  const Cart({super.key});

  // Light theme colors (re-using from previous light theme profile)
  static const Color _primaryLight = Color(0xFFF0F2F5); // Light grey background
  static const Color _cardBackground = Color(
    0xFFFFFFFF,
  ); // White card background
  static const Color _textColor = Color(0xFF212121); // Dark grey text
  static const Color _subtextColor = Color(0xFF757575); // Medium grey text
  static const Color _accentColor = Color(
    0xFF1E88E5,
  ); // Blue accent for active elements
  static const Color _iconColor = Color(0xFF616161); // Medium grey icon color
  static const Color _redAccent = Color(
    0xFFE53935,
  ); // For delete/danger actions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryLight,

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cart Item 1
                  _buildCartItem(
                    context,
                    productName: 'Paracetamol 500mg (10 tabs)',
                    pharmacyName: 'City Pharmacy',
                    price: 4.50,
                    quantity: 1,
                    imageUrl:
                        'https://via.placeholder.com/80x80/0000FF/FFFFFF?text=Med1', // Placeholder
                  ),
                  const SizedBox(height: 12),

                  // Cart Item 2
                  _buildCartItem(
                    context,
                    productName: 'Vitamin C 1000mg (30 caps)',
                    pharmacyName: 'Wellness Hub',
                    price: 7.00,
                    quantity: 2,
                    imageUrl:
                        'https://via.placeholder.com/80x80/FF0000/FFFFFF?text=Med2', // Placeholder
                  ),
                  const SizedBox(height: 12),

                  // Cart Item 3
                  _buildCartItem(
                    context,
                    productName: 'Antiseptic Solution 500ml',
                    pharmacyName: 'Local Drug Store',
                    price: 3.50,
                    quantity: 1,
                    imageUrl:
                        'https://via.placeholder.com/80x80/00FF00/FFFFFF?text=Med3', // Placeholder
                  ),
                  const SizedBox(height: 24),

                  // Voucher/Coupon Input
                  // _buildVoucherInput(context),
                  // const SizedBox(height: 24),

                  // Order Summary
                  // _buildOrderSummary(context),
                ],
              ),
            ),
          ),
          // Checkout Button (Fixed at bottom)
          _buildCheckoutButton(context),
        ],
      ),
    );
  }

  Widget _buildCartItem(
    BuildContext context, {
    required String productName,
    required String pharmacyName,
    required double price,
    required int quantity,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox.shrink();
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _textColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  pharmacyName, // "from Pantry Express" -> "from City Pharmacy"
                  style: const TextStyle(fontSize: 13, color: _subtextColor),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _accentColor,
                      ),
                    ),
                    QuantitySelector(
                      initialQuantity: quantity,
                      minQuantity: 1, // Optional: specify minimum
                      maxQuantity: 10, // Optional: specify maximum
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildQuantitySelector(int currentQuantity) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: _primaryLight, // Lighter background for the selector
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Row(
  //       children: [
  //         IconButton(
  //           constraints: const BoxConstraints(), // Remove default padding
  //           padding: EdgeInsets.zero,
  //           icon: Icon(Icons.remove, color: _iconColor, size: 20),
  //           onPressed: () {
  //             print('Decrement quantity');
  //           },
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //           child: Text(
  //             '$currentQuantity',
  //             style: const TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //               color: _textColor,
  //             ),
  //           ),
  //         ),
  //         IconButton(
  //           constraints: const BoxConstraints(), // Remove default padding
  //           padding: EdgeInsets.zero,
  //           icon: Icon(Icons.add, color: _iconColor, size: 20),
  //           onPressed: () {
  //             print('Increment quantity');
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildVoucherInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Enter your voucher code',
          hintStyle: TextStyle(color: _subtextColor.withOpacity(0.7)),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.confirmation_num_outlined, color: _iconColor),
        ),
        style: const TextStyle(color: _textColor),
        onSubmitted: (value) {
          print('Voucher submitted: $value');
        },
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    // Placeholder values
    const double subtotal = 15.00;
    const double deliveryFee = 3.50;
    const double discount = 1.50; // Example discount
    const double totalAmount = subtotal + deliveryFee - discount;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            'Subtotal',
            '\$${subtotal.toStringAsFixed(2)}',
            _textColor,
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(
            'Delivery Fee',
            '\$${deliveryFee.toStringAsFixed(2)}',
            _textColor,
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(
            'Discount',
            '-\$${discount.toStringAsFixed(2)}',
            _redAccent,
          ), // Show discount in red
          const Divider(height: 24, color: _primaryLight), // Subtle divider
          _buildSummaryRow(
            'Total Amount',
            '\$${totalAmount.toStringAsFixed(2)}',
            _textColor,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value,
    Color valueColor, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? _textColor : _subtextColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    const double totalAmount = 15.00 + 3.50 - 1.50; // Placeholder total
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _cardBackground, // White background for the sticky bar
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3), // Shadow on top
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow('Subtotal', '20', _textColor),
          const SizedBox(height: 10),
          _buildSummaryRow('Delivery Fee', '20', _textColor),
          const SizedBox(height: 10),

          const Divider(height: 24, color: _primaryLight), // Subtle divider

          Container(
            width: double.infinity,
            height: 60.h,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colours.accentCoral,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 5.w),
                Text(
                  'Total Amount ${totalAmount.toString()}',
                  style: AppTextStyles.karala14w800.white,
                ),
                Container(
                  width: 150.w,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: Text(
                      "Check Out",
                      style: AppTextStyles.karala14w800.dark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // _buildSummaryRow(
          //   'Total Amount',
          //   '\$${totalAmount.toStringAsFixed(2)}',
          //   _textColor,
          //   isTotal: true,
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     print('Checkout tapped!');
          //     // Implement checkout logic
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: _accentColor, // Blue accent color
          //     padding: const EdgeInsets.symmetric(vertical: 16),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     minimumSize: const Size(double.infinity, 50), // Full width button
          //   ),
          //   child: Text(
          //     'Checkout \$${totalAmount.toStringAsFixed(2)}',
          //     style: const TextStyle(
          //       fontSize: 18,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
