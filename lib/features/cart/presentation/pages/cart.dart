import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mediecom/core/constants/api_constants.dart';
import 'package:mediecom/core/extentions/text_style_extentions.dart';
import 'package:mediecom/core/style/app_colors.dart';
import 'package:mediecom/core/style/app_text_styles.dart';
import 'package:mediecom/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:mediecom/features/cart/presentation/blocs/cart_state.dart';
import 'package:mediecom/features/cart/presentation/widgets/quantity_selector.dart';

import '../../../explore/domain/entities/product_entity.dart';

class Cart extends StatefulWidget {
  static const path = '/cart';
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  static const Color _primaryLight = Color(0xFFF0F2F5);
  static const Color _cardBackground = Color(0xFFFFFFFF);
  static const Color _textColor = Color(0xFF212121);
  static const Color _subtextColor = Color(0xFF757575);
  static const Color _accentColor = Color(0xFF1E88E5);
  static const Color _iconColor = Color(0xFF616161);
  static const Color _redAccent = Color(0xFFE53935);

  final double deliveryFee = 3.50;

  // -------- FIXED PART ---------
  double get subtotal {
    final items = (context.read<CartBloc>().state.items);
    double sum = 0;
    for (var item in items) {
      final price = double.tryParse(item.M1_AMT1 ?? "0") ?? 0;
      sum += price * (item.quantity ?? 1); // <--- qty included
    }
    return sum;
  }
  // -----------------------------

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
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  final data = state.items;
                  if (data.isEmpty) {
                    return Center(
                      child: Text(
                        'Your cart is empty',
                        style: AppTextStyles.karala16w600.dark,
                      ),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return _buildCartItem(context, item);
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 12.h);
                    },
                  );
                },
              ),
            ),
          ),
          _buildCheckoutButton(context),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, ProductEntity item) {
    return StatefulBuilder(
      builder: (context, setStateInner) {
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
                  item.image.isNotEmpty
                      ? "${ApiConstants.productBase}${item.image[0]}"
                      : "",

                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey,
                    child: Icon(Iconsax.image, size: 30.sp, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.M1_NAME ?? 'Unknown Product',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.M1_CST ?? 'Unknown Pharmacy',
                      style: const TextStyle(
                        fontSize: 13,
                        color: _subtextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs ${item.M1_AMT1}/-',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colours.success,
                          ),
                        ),

                        QuantitySelector(
                          initialQuantity: item.quantity,
                          minQuantity: 1,
                          maxQuantity: 10,
                          onQuantityChanged: (newQty) {
                            setStateInner(() {
                              item.quantity = newQty;

                              // ---- FIXED ----
                              if (mounted) setState(() {});
                              // --------------
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
      },
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
