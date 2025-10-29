import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediecom/core/extentions/text_style_extentions.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/cart/presentation/widgets/quantity_selector.dart';

class Cart extends StatefulWidget {
  static const path = '/cart';
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // Light theme colors
  static const Color _primaryLight = Color(0xFFF0F2F5);
  static const Color _cardBackground = Color(0xFFFFFFFF);
  static const Color _textColor = Color(0xFF212121);
  static const Color _subtextColor = Color(0xFF757575);
  static const Color _accentColor = Color(0xFF1E88E5);
  static const Color _iconColor = Color(0xFF616161);
  static const Color _redAccent = Color(0xFFE53935);

  final double deliveryFee = 3.50;

  // Sample cart data (can later come from backend or provider)
  final List<Map<String, dynamic>> cartItems = [
    {
      'productName': 'Paracetamol 500mg (10 tabs)',
      'pharmacyName': 'City Pharmacy',
      'price': 4.50,
      'quantity': 1,
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRquzMUwap3aIcmZQhZ4FOztWQorUZSonP4wg&s',
    },
    {
      'productName': 'Vitamin C 1000mg (30 caps)',
      'pharmacyName': 'Wellness Hub',
      'price': 7.00,
      'quantity': 2,
      'imageUrl':
          'https://5.imimg.com/data5/SELLER/Default/2023/8/332350358/SI/JT/VF/98283251/amoxicillin-drugs3.jpg',
    },
    {
      'productName': 'Antiseptic Solution 500ml',
      'pharmacyName': 'Local Drug Store',
      'price': 3.50,
      'quantity': 1,
      'imageUrl':
          'https://cdn01.pharmeasy.in/dam/products/J21424/atorvastatin-10-mg-tablet-10-medlife-pure-generics-combo-3-1626532296.jpg',
    },
  ];

  // 🔹 Calculate subtotal dynamically
  double get subtotal {
    return cartItems.fold(0, (sum, item) {
      return sum + (item['price'] * item['quantity']);
    });
  }

  // 🔹 Calculate total amount dynamically
  double get totalAmount => subtotal + deliveryFee;

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
                children: [
                  for (int i = 0; i < cartItems.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildCartItem(context, i),
                    ),
                ],
              ),
            ),
          ),
          _buildCheckoutButton(context),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, int index) {
    final item = cartItems[index];

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
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item['imageUrl'],
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  width: 70,
                  height: 70,
                  child: Icon(Icons.medical_services, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['productName'],
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
                  item['pharmacyName'],
                  style: const TextStyle(fontSize: 13, color: _subtextColor),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rs ${item['price'].toStringAsFixed(2)}/-',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colours.success,
                      ),
                    ),
                    // 🔹 Quantity Selector triggers setState when changed
                    QuantitySelector(
                      initialQuantity: item['quantity'],
                      minQuantity: 1,
                      maxQuantity: 10,
                      onQuantityChanged: (newQty) {
                        setState(() {
                          item['quantity'] = newQty;
                        });
                      },
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

  Widget _buildSummaryRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _subtextColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            'Subtotal',
            '${subtotal.toStringAsFixed(2)}/-',
            Colours.success,
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(
            'Delivery Fee',
            '${deliveryFee.toStringAsFixed(2)}/-',
            Colours.success,
          ),
          const Divider(height: 24, color: _primaryLight),
          Container(
            width: double.infinity,
            height: 60.h,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colours.accentCoral,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 3.w),
                Text(
                  'Total Amt: ${totalAmount.toStringAsFixed(2)}/-',
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
        ],
      ),
    );
  }
}
